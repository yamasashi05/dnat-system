// ============================================================
// DNAT Equipment Management - Express.js Backend
// ============================================================

// โหลดค่าตัวแปรจากไฟล์ .env (เช่น DB_HOST, PORT ฯลฯ)
require("dotenv").config();

// ── นำเข้า Library ที่จำเป็น ──────────────────────────────────
const express = require("express");        // Web framework หลัก
const mysql = require("mysql2/promise");   // ติดต่อฐานข้อมูล MySQL แบบ async/await
const cors = require("cors");              // อนุญาตให้ Frontend ต่าง domain เรียก API ได้
const multer = require("multer");          // รับไฟล์อัปโหลด
const bcrypt = require("bcrypt");          // เข้ารหัส/ตรวจสอบรหัสผ่าน
const path = require("path");             // จัดการ path ของไฟล์
const fs = require("fs");                 // อ่าน/เขียนไฟล์บน server

const app = express();
const PORT = Number(process.env.PORT || 10000); // พอร์ตที่ server รับฟัง

// ── อ่านค่าการเชื่อมต่อฐานข้อมูลจาก Environment Variables ──────
const DB_HOST     = process.env.DB_HOST     || process.env.MYSQLHOST;
const DB_PORT     = Number(process.env.DB_PORT || process.env.MYSQLPORT || 3306);
const DB_USER     = process.env.DB_USER     || process.env.MYSQLUSER;
const DB_PASSWORD = process.env.DB_PASSWORD || process.env.MYSQLPASSWORD;
const DB_NAME     = process.env.DB_NAME     || process.env.MYSQLDATABASE;
const DB_SSL      = String(process.env.DB_SSL || "false").toLowerCase() === "true"; // เปิด SSL หรือไม่

// ── ตั้งค่า CORS: อนุญาตเฉพาะ origin ที่กำหนดเท่านั้น ──────────
app.use(cors({
  origin: [
    "http://localhost:5173",                  // Vite dev server
    "http://localhost:3000",                  // React dev server
    "https://dnat-system-1.onrender.com"     // Production frontend
  ],
  methods: ["GET", "POST", "PUT", "PATCH", "DELETE", "OPTIONS"],
  credentials: true
}));

app.use(express.json()); // แปลง request body จาก JSON string เป็น object อัตโนมัติ
app.use("/uploads", express.static(path.join(__dirname, "uploads"))); // เสิร์ฟไฟล์รูปภาพสาธารณะ

// ── สร้าง Connection Pool สำหรับ MySQL ──────────────────────────
// ใช้ pool แทน connection เดี่ยว เพื่อรองรับหลาย request พร้อมกัน
const pool = mysql.createPool({
  host: DB_HOST,
  port: DB_PORT,
  user: DB_USER,
  password: DB_PASSWORD,
  database: DB_NAME,
  waitForConnections: true, // รอ connection ว่างถ้า pool เต็ม
  connectionLimit: 10,      // จำนวน connection สูงสุดใน pool
  ssl: DB_SSL
    ? {
        // โหลด CA certificate สำหรับ Aiven MySQL (ถ้ามีไฟล์)
        ca: fs.existsSync("/etc/secrets/aiven-ca.pem")
          ? fs.readFileSync("/etc/secrets/aiven-ca.pem", "utf8")
          : undefined,
        rejectUnauthorized: false
      }
    : undefined
});

// ── ฟังก์ชันทดสอบการเชื่อมต่อ DB ตอน server เริ่มทำงาน ──────────
async function initDB() {
  let conn;
  try {
    conn = await pool.getConnection();
    await conn.query("SELECT 1"); // query ง่ายๆ เพื่อตรวจว่า DB ตอบสนอง
    console.log("DB Connected");
  } catch (err) {
    console.error("DB ERROR FULL:", err);
    throw err; // โยน error ขึ้นไปให้ process.exit() จัดการ
  } finally {
    if (conn) conn.release(); // คืน connection กลับ pool เสมอ
  }
}

// ── Health check endpoint ────────────────────────────────────────
app.get("/", (req, res) => res.send("DNAT API is running 🚀"));

// ── ตั้งค่า Multer: อัปโหลดรูปลงดิสก์ (disk storage) ──────────
const uploadDir = path.join(__dirname, "uploads", "equipment");
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir, { recursive: true }); // สร้างโฟลเดอร์ถ้ายังไม่มี

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir), // กำหนดโฟลเดอร์ปลายทาง
  filename: (req, file, cb) => {
    const ext = path.extname(file.originalname);
    cb(null, `${req.params.id}_${Date.now()}${ext}`); // ชื่อไฟล์: {id}_{timestamp}.{ext}
  },
});

// multer สำหรับบันทึกลงดิสก์ (จำกัด 10MB, รับเฉพาะรูปภาพ)
const upload = multer({
  storage,
  limits: { fileSize: 10 * 1024 * 1024 },
  fileFilter: (req, file, cb) => {
    const allowed = ["image/jpeg", "image/png", "image/webp", "image/gif"];
    allowed.includes(file.mimetype) ? cb(null, true) : cb(new Error("Only image files"));
  }
});

// multer สำหรับเก็บไฟล์ใน memory (ก่อนบันทึกลง DB เป็น binary)
const uploadMem = multer({
  storage: multer.memoryStorage(),
  limits: { fileSize: 10 * 1024 * 1024 }
});

// ── Helper functions: สร้าง response มาตรฐาน ───────────────────
const ok  = (res, data, msg = "success") => res.json({ success: true,  message: msg, data });
const err = (res, msg, code = 500)       => res.status(code).json({ success: false, message: msg });

// ════════════════════════════════════════════════════════════════
// EQUIPMENT ROUTES - จัดการข้อมูลครุภัณฑ์
// ════════════════════════════════════════════════════════════════

// GET /equipment — ดึงรายการครุภัณฑ์ทั้งหมด (กรองได้ด้วย query string)
// Query params: status, team, category, q (ค้นหาชื่อ/รหัส)
app.get("/equipment", async (req, res) => {
  try {
    const { status, team, category, q } = req.query;

    // ดึงทุก field ยกเว้น image_data (blob ใหญ่) → ส่งแค่ flag 'HAS_IMAGE' แทน
    let sql = `
  SELECT
    id, code, name, category, team, status,
    location, quantity, image_path, description,
    CASE WHEN image_data IS NOT NULL THEN 'HAS_IMAGE' ELSE NULL END AS image_data
  FROM equipment
  WHERE 1=1
`;
    const params = [];

    // เพิ่มเงื่อนไข WHERE แบบ dynamic ตาม query ที่ส่งมา
    if (status)   { sql += " AND status=?";                           params.push(status); }
    if (team)     { sql += " AND team=?";                             params.push(team); }
    if (category) { sql += " AND category=?";                         params.push(category); }
    if (q)        { sql += " AND (name LIKE ? OR code LIKE ?)";       params.push(`%${q}%`, `%${q}%`); }

    sql += " ORDER BY code";

    const [rows] = await pool.query(sql, params);
    ok(res, rows);
  } catch (e) {
    err(res, e.message);
  }
});

// GET /equipment/stats — ดึงสถิติสรุปภาพรวมครุภัณฑ์ (ใช้แสดง Dashboard)
app.get("/equipment/stats", async (req, res) => {
  try {
    const [[total]]    = await pool.query("SELECT COUNT(*) AS n FROM equipment");
    const [[normal]]   = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ปกติ'");
    const [[damaged]]  = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ชำรุด'");
    const [[repair]]   = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ส่งซ่อม'");
    const [[borrowed]] = await pool.query("SELECT COUNT(*) AS n FROM borrow_history WHERE return_status='ยังไม่คืน'");
    const [[overdue]]  = await pool.query("SELECT COUNT(*) AS n FROM borrow_history WHERE return_status='เกินกำหนด'");

    ok(res, {
      total:    total.n,
      normal:   normal.n,
      damaged:  damaged.n,
      repair:   repair.n,
      borrowed: borrowed.n,
      overdue:  overdue.n,
      health: total.n > 0 ? Math.round((normal.n / total.n) * 100) : 0 // % ครุภัณฑ์ที่อยู่ในสภาพปกติ
    });
  } catch (e) {
    err(res, e.message);
  }
});

// GET /equipment/next-code — คำนวณรหัสครุภัณฑ์ถัดไป (format: A1, A2, A3, ...)
app.get("/equipment/next-code", async (req, res) => {
  try {
    // หารหัสล่าสุดที่มีรูปแบบ A{ตัวเลข} แล้วเรียง DESC เพื่อเอาตัวใหญ่สุด
    const [rows] = await pool.query(
      "SELECT code FROM equipment WHERE code REGEXP '^A[0-9]+$' ORDER BY CAST(SUBSTRING(code, 2) AS UNSIGNED) DESC LIMIT 1"
    );

    let nextNum = 1;
    if (rows.length > 0) {
      const lastNum = parseInt(rows[0].code.replace("A", ""), 10);
      nextNum = lastNum + 1;
    }

    ok(res, { code: `A${nextNum}` });
  } catch (e) {
    err(res, e.message);
  }
});

// GET /equipment/:id — ดึงข้อมูลครุภัณฑ์รายชิ้นตาม id
app.get("/equipment/:id", async (req, res) => {
  try {
    const [rows] = await pool.query("SELECT * FROM equipment WHERE id=?", [req.params.id]);
    if (!rows.length) return err(res, "Not found", 404);
    // ซ่อน blob จริง → ส่งแค่ flag ว่ามีรูปหรือไม่
    ok(res, { ...rows[0], image_data: rows[0].image_data ? "HAS_IMAGE" : null });
  } catch (e) {
    err(res, e.message);
  }
});

// POST /equipment — เพิ่มครุภัณฑ์ใหม่ (รหัสถูก generate อัตโนมัติ)
app.post("/equipment", async (req, res) => {
  try {
    const { name, category, team, status, location, quantity, description } = req.body;

    // ตรวจ field บังคับ
    if (!name || !category || !team || !status) {
      return err(res, "name, category, team, status required", 400);
    }

    // หารหัสถัดไปแบบเดียวกับ /next-code
    const [rows] = await pool.query(
      "SELECT code FROM equipment WHERE code REGEXP '^A[0-9]+$' ORDER BY CAST(SUBSTRING(code, 2) AS UNSIGNED) DESC LIMIT 1"
    );

    let nextNum = 1;
    if (rows.length > 0) {
      const lastNum = parseInt(rows[0].code.replace("A", ""), 10);
      nextNum = lastNum + 1;
    }

    const autoCode = `A${nextNum}`;

    const [result] = await pool.query(
      `INSERT INTO equipment
       (code, name, category, team, status, location, quantity, description, image_path)
       VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [autoCode, name, category, team, status,
       location || "", quantity || 1, description || "", null]
    );

    ok(res, { id: result.insertId, code: autoCode }, "Created");
  } catch (e) {
    console.error("POST /equipment ERROR:", e);
    err(res, e.message);
  }
});

// PUT /equipment/:id — แก้ไขข้อมูลครุภัณฑ์ทั้งหมด (ไม่รวมรูปภาพ)
app.put("/equipment/:id", async (req, res) => {
  try {
    const { name, category, team, status, location, quantity, description } = req.body;

    if (!name || !category || !team || !status) {
      return err(res, "name, category, team, status required", 400);
    }

    await pool.query(
      `UPDATE equipment
       SET name=?, category=?, team=?, status=?, location=?, quantity=?, description=?
       WHERE id=?`,
      [name, category, team, status,
       location || "", quantity || 1, description || "", req.params.id]
    );

    ok(res, null, "Updated");
  } catch (e) {
    console.error("PUT /equipment ERROR:", e);
    err(res, e.message);
  }
});

// DELETE /equipment/:id — ลบครุภัณฑ์ตาม id
app.delete("/equipment/:id", async (req, res) => {
  try {
    await pool.query("DELETE FROM equipment WHERE id=?", [req.params.id]);
    ok(res, null, "Deleted");
  } catch (e) {
    console.error("DELETE /equipment ERROR:", e);
    err(res, e.message);
  }
});

// ════════════════════════════════════════════════════════════════
// IMAGE ROUTES - จัดการรูปภาพครุภัณฑ์
// ════════════════════════════════════════════════════════════════

// POST /equipment/:id/image — อัปโหลดรูปและบันทึก path ลง DB (เก็บไฟล์จริงบนดิสก์)
app.post("/equipment/:id/image", upload.single("image"), async (req, res) => {
  try {
    if (!req.file) return err(res, "No file uploaded", 400);
    const imgPath = `/uploads/equipment/${req.file.filename}`;
    await pool.query("UPDATE equipment SET image_path=? WHERE id=?", [imgPath, req.params.id]);
    ok(res, { image_path: imgPath }, "Image uploaded");
  } catch (e) {
    err(res, e.message);
  }
});

// POST /equipment/:id/image-binary — อัปโหลดรูปแบบ binary เก็บตรงใน DB (ไม่ใช้ดิสก์)
app.post("/equipment/:id/image-binary", uploadMem.single("image"), async (req, res) => {
  try {
    if (!req.file) return err(res, "No file uploaded", 400);
    await pool.query(
      "UPDATE equipment SET image_data=?, image_mime=? WHERE id=?",
      [req.file.buffer, req.file.mimetype, req.params.id]
    );
    ok(res, null, "Image saved to DB");
  } catch (e) {
    err(res, e.message);
  }
});

// GET /equipment/:id/image-binary — ดึงรูปจาก DB แล้วส่งกลับเป็น raw image (ใช้ใน <img src="...">)
app.get("/equipment/:id/image-binary", async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT image_data, image_mime FROM equipment WHERE id=?",
      [req.params.id]
    );
    if (!rows.length || !rows[0].image_data) return err(res, "No image", 404);
    res.set("Content-Type", rows[0].image_mime || "image/jpeg");
    res.send(rows[0].image_data); // ส่ง buffer กลับโดยตรง
  } catch (e) {
    err(res, e.message);
  }
});

// ════════════════════════════════════════════════════════════════
// HISTORY ROUTES - จัดการประวัติการเบิก/ยืมครุภัณฑ์
// ════════════════════════════════════════════════════════════════

// GET /history — ดึงประวัติการยืม (กรองได้ด้วย return_status และ keyword)
app.get("/history", async (req, res) => {
  try {
    const { return_status, q } = req.query;
    let sql = "SELECT * FROM borrow_history WHERE 1=1";
    const params = [];

    if (return_status) {
      sql += " AND return_status=?";
      params.push(return_status);
    }
    if (q) {
      // ค้นหาจากชื่อผู้ยืม, ชื่อครุภัณฑ์, หรือเลขที่เอกสาร
      sql += " AND (borrower LIKE ? OR equipment_name LIKE ? OR doc_no LIKE ?)";
      params.push(`%${q}%`, `%${q}%`, `%${q}%`);
    }

    sql += " ORDER BY created_at DESC";
    const [rows] = await pool.query(sql, params);
    ok(res, rows);
  } catch (e) {
    err(res, e.message);
  }
});

// POST /history — บันทึกรายการยืม/เบิกใหม่ (return_status เริ่มต้น = 'ยังไม่คืน')
app.post("/history", async (req, res) => {
  try {
    const { doc_no, equipment_code, equipment_name, type, borrow_qty,
            borrower, department, borrow_date, notes } = req.body;

    if (!doc_no || !borrower) return err(res, "doc_no and borrower required", 400);

    const [result] = await pool.query(
      "INSERT INTO borrow_history (doc_no,equipment_code,equipment_name,type,borrow_qty,borrower,department,borrow_date,return_status,notes) VALUES (?,?,?,?,?,?,?,?,?,?)",
      [doc_no, equipment_code || "", equipment_name || "", type || "เบิก",
       borrow_qty || 1, borrower, department || "", borrow_date || null,
       "ยังไม่คืน", notes || ""]
    );

    ok(res, { id: result.insertId }, "Created");
  } catch (e) {
    err(res, e.message);
  }
});

// PATCH /history/:id/return — อัปเดตสถานะว่าคืนแล้ว พร้อมบันทึกวันคืนและหมายเหตุ
app.patch("/history/:id/return", async (req, res) => {
  try {
    const { return_date, notes } = req.body;
    await pool.query(
      // ต่อท้าย notes เดิมด้วย notes ใหม่ (ไม่เขียนทับ)
      "UPDATE borrow_history SET return_status='คืนแล้ว', return_date=?, notes=CONCAT(IFNULL(notes,''),' ',IFNULL(?,'')) WHERE id=?",
      [return_date || new Date().toISOString().split("T")[0], notes || "", req.params.id]
    );
    ok(res, null, "Returned");
  } catch (e) {
    err(res, e.message);
  }
});

// DELETE /history/:id — ลบประวัติการยืมตาม id
app.delete("/history/:id", async (req, res) => {
  try {
    await pool.query("DELETE FROM borrow_history WHERE id=?", [req.params.id]);
    ok(res, null, "Deleted");
  } catch (e) {
    err(res, e.message);
  }
});

// ════════════════════════════════════════════════════════════════
// AUTH ROUTES - ระบบล็อกอิน
// ════════════════════════════════════════════════════════════════

// POST /auth/login — ตรวจสอบ username/password แล้วคืนข้อมูล user (ไม่มี JWT)
// - ใช้ bcrypt.compare() เพื่อตรวจ password ที่ hash ไว้ใน DB
// - is_active=1 คือเฉพาะ user ที่เปิดใช้งานเท่านั้น
app.post("/auth/login", async (req, res) => {
  try {
    const { username, password } = req.body;
    const [rows] = await pool.query(
      "SELECT * FROM users WHERE username=? AND is_active=1",
      [username]
    );

    if (!rows.length) return err(res, "Invalid credentials", 401);

    const match = await bcrypt.compare(password, rows[0].password);
    if (!match) return err(res, "Invalid credentials", 401);

    // ลบ field password ออกก่อนส่งกลับ เพื่อความปลอดภัย
    const { password: _password, ...user } = rows[0];
    ok(res, { user }, "Login success");
  } catch (e) {
    err(res, e.message);
  }
});

// ════════════════════════════════════════════════════════════════
// START SERVER — เริ่ม server หลังจาก DB พร้อมเท่านั้น
// ════════════════════════════════════════════════════════════════
initDB()
  .then(() => {
    console.log("LIMIT VERSION: 100");
    app.listen(PORT, "0.0.0.0", () => {
      console.log(`DNAT API running on port ${PORT}`);
    });
  })
  .catch((e) => {
    console.error("Startup failed:", e.message);
    process.exit(1); // หยุด process ทันทีถ้า DB เชื่อมต่อไม่ได้
  });