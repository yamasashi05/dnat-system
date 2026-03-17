// ============================================================
// DNAT Equipment Management - Express.js Backend
// ============================================================

require("dotenv").config();

const express = require("express");
const mysql = require("mysql2/promise");
const cors = require("cors");
const multer = require("multer");
const bcrypt = require("bcrypt");
const path = require("path");
const fs = require("fs");


const app = express();
const PORT = process.env.PORT || 10000;

// ✅ CORS (ใส่ origin ของ frontend Railway คุณ)

app.use(cors({
  origin: [
    "http://localhost:5173",
    "http://localhost:3000",
    "https://dnat-system-1.onrender.com"
  ],
  methods: ["GET","POST","PUT","PATCH","DELETE","OPTIONS"],
  credentials: true
}));
app.use(express.json());

app.options("*", cors())

app.use(express.json());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: process.env.DB_PORT || 3306,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  ssl: {
    rejectUnauthorized: false
  }
});

// 👇 ใส่ตรงนี้
async function initDB() {
  try {
    await pool.query("SELECT 1");
    console.log("DB Connected");
  } catch (err) {
    console.error("DB ERROR:", err.message);
  }
}

initDB();



  

app.get("/", (req, res) => res.send("DNAT API is running 🚀"));

const uploadDir = path.join(__dirname, 'uploads', 'equipment');
if (!fs.existsSync(uploadDir)) fs.mkdirSync(uploadDir, { recursive: true });

const storage = multer.diskStorage({
  destination: (req, file, cb) => cb(null, uploadDir),
  filename:    (req, file, cb) => {
    const ext  = path.extname(file.originalname);
    cb(null, `${req.params.id}_${Date.now()}${ext}`);
  },
});
const upload = multer({ storage, limits: { fileSize: 10*1024*1024 }, fileFilter: (req,file,cb) => {
  ['image/jpeg','image/png','image/webp','image/gif'].includes(file.mimetype) ? cb(null,true) : cb(new Error('Only image files'));
}});
const uploadMem = multer({ storage: multer.memoryStorage(), limits: { fileSize: 10*1024*1024 } });

const ok  = (res, data, msg='success') => res.json({ success:true, message:msg, data });
const err = (res, msg, code=500)       => res.status(code).json({ success:false, message:msg });

// ── EQUIPMENT ──
app.get('/equipment', async (req, res) => {
  try {
    const { status, team, category, q } = req.query;
    let sql = 'SELECT id,code,name,category,team,status,location,quantity,image_path,description FROM equipment WHERE 1=1';
    const params = [];
    if (status)   { sql += ' AND status=?'; params.push(status); }
    if (team)     { sql += ' AND team=?'; params.push(team); }
    if (category) { sql += ' AND category=?'; params.push(category); }
    if (q)        { sql += ' AND (name LIKE ? OR code LIKE ?)'; params.push(`%${q}%`,`%${q}%`); }
    sql += ' ORDER BY code';
    const [rows] = await pool.query(sql, params);
    ok(res, rows);
  } catch(e) { err(res, e.message); }
});

app.get('/equipment/stats', async (req, res) => {
  try {
    const [[total]]    = await pool.query("SELECT COUNT(*) AS n FROM equipment");
    const [[normal]]   = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ปกติ'");
    const [[damaged]]  = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ชำรุด'");
    const [[repair]]   = await pool.query("SELECT COUNT(*) AS n FROM equipment WHERE status='ส่งซ่อม'");
    const [[borrowed]] = await pool.query("SELECT COUNT(*) AS n FROM borrow_history WHERE return_status='ยังไม่คืน'");
    const [[overdue]]  = await pool.query("SELECT COUNT(*) AS n FROM borrow_history WHERE return_status='เกินกำหนด'");
    ok(res, { total:total.n, normal:normal.n, damaged:damaged.n, repair:repair.n, borrowed:borrowed.n, overdue:overdue.n,
      health: total.n > 0 ? Math.round((normal.n/total.n)*100) : 0 });
  } catch(e) { err(res, e.message); }
});

// ── AUTO-GENERATE CODE (ต้องอยู่ก่อน /:id เสมอ) ──
app.get('/equipment/next-code', async (req, res) => {
  try {
    const [rows] = await pool.query(
      "SELECT code FROM equipment WHERE code REGEXP '^A[0-9]+$' ORDER BY CAST(SUBSTRING(code, 2) AS UNSIGNED) DESC LIMIT 1"
    );
    let nextNum = 1;
    if (rows.length > 0) {
      const lastNum = parseInt(rows[0].code.replace('A', ''), 10);
      nextNum = lastNum + 1;
    }
    const nextCode = `A${nextNum}`;
    ok(res, { code: nextCode });
  } catch(e) { err(res, e.message); }
});

app.get('/equipment/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM equipment WHERE id=?', [req.params.id]);
    if (!rows.length) return err(res, 'Not found', 404);
    ok(res, { ...rows[0], image_data: rows[0].image_data ? 'HAS_IMAGE' : null });
  } catch(e) { err(res, e.message); }
});

app.post('/equipment', async (req, res) => {
  try {
    const { name,category,team,status,location,quantity,description,purchase_date,purchase_price,notes } = req.body;
    if (!name) return err(res, 'name required', 400);

    // Auto-generate รหัสอุปกรณ์
    const [rows] = await pool.query(
      "SELECT code FROM equipment WHERE code REGEXP '^A[0-9]+$' ORDER BY CAST(SUBSTRING(code, 2) AS UNSIGNED) DESC LIMIT 1"
    );
    let nextNum = 1;
    if (rows.length > 0) {
      const lastNum = parseInt(rows[0].code.replace('A', ''), 10);
      nextNum = lastNum + 1;
    }
    const autoCode = `A${nextNum}`;

    const [result] = await pool.query(
      'INSERT INTO equipment (code,name,category,team,status,location,quantity,description,purchase_date,purchase_price,notes) VALUES (?,?,?,?,?,?,?,?,?,?,?)',
      [autoCode,name,category,team||'Other',status||'ปกติ',location,quantity||1,description,purchase_date||null,purchase_price||null,notes]
    );
    ok(res, { id: result.insertId, code: autoCode }, 'Created');
  } catch(e) { err(res, e.message); }
});

app.put('/equipment/:id', async (req, res) => {
  try {
    const { name,category,team,status,location,quantity,description,purchase_date,purchase_price,notes } = req.body;
    await pool.query(
      'UPDATE equipment SET name=?,category=?,team=?,status=?,location=?,quantity=?,description=?,purchase_date=?,purchase_price=?,notes=? WHERE id=?',
      [name,category,team,status,location,quantity,description,purchase_date||null,purchase_price||null,notes,req.params.id]
    );
    ok(res, null, 'Updated');
  } catch(e) { err(res, e.message); }
});

app.delete('/equipment/:id', async (req, res) => {
  try {
    await pool.query('DELETE FROM equipment WHERE id=?', [req.params.id]);
    ok(res, null, 'Deleted');
  } catch(e) { err(res, e.message); }
});

// ── IMAGES ──
app.post('/equipment/:id/image', upload.single('image'), async (req, res) => {
  try {
    if (!req.file) return err(res, 'No file uploaded', 400);
    const imgPath = `/uploads/equipment/${req.file.filename}`;
    await pool.query('UPDATE equipment SET image_path=? WHERE id=?', [imgPath, req.params.id]);
    ok(res, { image_path: imgPath }, 'Image uploaded');
  } catch(e) { err(res, e.message); }
});

app.post('/equipment/:id/image-binary', uploadMem.single('image'), async (req, res) => {
  try {
    if (!req.file) return err(res, 'No file uploaded', 400);
    await pool.query('UPDATE equipment SET image_data=?, image_mime=? WHERE id=?',
      [req.file.buffer, req.file.mimetype, req.params.id]);
    ok(res, null, 'Image saved to DB');
  } catch(e) { err(res, e.message); }
});

app.get('/equipment/:id/image-binary', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT image_data, image_mime FROM equipment WHERE id=?', [req.params.id]);
    if (!rows.length || !rows[0].image_data) return err(res, 'No image', 404);
    res.set('Content-Type', rows[0].image_mime || 'image/jpeg');
    res.send(rows[0].image_data);
  } catch(e) { err(res, e.message); }
});

// ── HISTORY ──
app.get('/history', async (req, res) => {
  try {
    const { return_status, q } = req.query;
    let sql = 'SELECT * FROM borrow_history WHERE 1=1';
    const params = [];
    if (return_status) { sql += ' AND return_status=?'; params.push(return_status); }
    if (q) { sql += ' AND (borrower LIKE ? OR equipment_name LIKE ? OR doc_no LIKE ?)'; params.push(`%${q}%`,`%${q}%`,`%${q}%`); }
    sql += ' ORDER BY created_at DESC';
    const [rows] = await pool.query(sql, params);
    ok(res, rows);
  } catch(e) { err(res, e.message); }
});

app.post('/history', async (req, res) => {
  try {
    const { doc_no,equipment_code,equipment_name,type,borrow_qty,borrower,department,borrow_date,notes } = req.body;
    if (!doc_no || !borrower) return err(res, 'doc_no and borrower required', 400);
    const [result] = await pool.query(
      'INSERT INTO borrow_history (doc_no,equipment_code,equipment_name,type,borrow_qty,borrower,department,borrow_date,return_status,notes) VALUES (?,?,?,?,?,?,?,?,?,?)',
      [doc_no,equipment_code||'',equipment_name||'',type||'เบิก',borrow_qty||1,borrower,department||'',borrow_date||null,'ยังไม่คืน',notes||'']
    );
    ok(res, { id: result.insertId }, 'Created');
  } catch(e) { err(res, e.message); }
});

app.patch('/history/:id/return', async (req, res) => {
  try {
    const { return_date, notes } = req.body;
    await pool.query(
      "UPDATE borrow_history SET return_status='คืนแล้ว', return_date=?, notes=CONCAT(IFNULL(notes,''),' ',IFNULL(?,'')) WHERE id=?",
      [return_date || new Date().toISOString().split('T')[0], notes||'', req.params.id]
    );
    ok(res, null, 'Returned');
  } catch(e) { err(res, e.message); }
});

app.delete('/history/:id', async (req, res) => {
  try {
    await pool.query('DELETE FROM borrow_history WHERE id=?', [req.params.id]);
    ok(res, null, 'Deleted');
  } catch(e) { err(res, e.message); }
});

// ── AUTH ──
app.post('/auth/login', async (req, res) => {
  try {
    const { username, password } = req.body;
    const [rows] = await pool.query('SELECT * FROM users WHERE username=? AND is_active=1', [username]);
    if (!rows.length) return err(res, 'Invalid credentials', 401);
    const match = await bcrypt.compare(password, rows[0].password);
    if (!match) return err(res, 'Invalid credentials', 401);
    const { password:_, ...user } = rows[0];
    ok(res, { user }, 'Login success');
  } catch(e) { err(res, e.message); }
});

// ✅ Listen แค่ครั้งเดียว พร้อม 0.0.0.0 สำหรับ Railway
app.listen(PORT, "0.0.0.0", () => {
  console.log(`DNAT API running on port ${PORT}`);
});