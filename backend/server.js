// ============================================================
// DNAT Equipment Management - Express.js Backend
// ============================================================

require('dotenv').config();
const express  = require('express');
const mysql    = require('mysql2/promise');
const cors     = require('cors');
const multer   = require('multer');
const bcrypt   = require('bcrypt');
const path     = require('path');
const fs       = require('fs');

const app  = express();
const PORT = process.env.PORT || 4000;

app.use(cors());
app.use(express.json());
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));

const pool = mysql.createPool({
  host: process.env.DB_HOST || "localhost",
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER || "root",
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME || "dnat_equipment",
  charset: "utf8mb4",
  waitForConnections: true,
  connectionLimit: 10,
});

// ─── Auto-init Tables ────────────────────────────────────────
async function initDB() {
  await pool.query(`
    CREATE TABLE IF NOT EXISTS users (
      id INT AUTO_INCREMENT PRIMARY KEY,
      username VARCHAR(50) NOT NULL UNIQUE,
      password VARCHAR(255) NOT NULL,
      is_active TINYINT DEFAULT 1,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  `);
  await pool.query(`
    INSERT IGNORE INTO users (username, password, is_active) VALUES 
    ('admin', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1)
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS equipment (
      id INT AUTO_INCREMENT PRIMARY KEY,
      code VARCHAR(50) NOT NULL UNIQUE,
      name VARCHAR(200) NOT NULL,
      category VARCHAR(100),
      team VARCHAR(100) DEFAULT 'Other',
      status VARCHAR(50) DEFAULT 'ปกติ',
      location VARCHAR(200),
      quantity INT DEFAULT 1,
      image_path VARCHAR(500),
      image_data MEDIUMBLOB,
      image_mime VARCHAR(50),
      description TEXT,
      purchase_date DATE,
      purchase_price DECIMAL(10,2),
      notes TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
      updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
    )
  `);
  await pool.query(`
    CREATE TABLE IF NOT EXISTS borrow_history (
      id INT AUTO_INCREMENT PRIMARY KEY,
      doc_no VARCHAR(100) NOT NULL,
      equipment_code VARCHAR(50),
      equipment_name VARCHAR(200),
      type VARCHAR(50) DEFAULT 'เบิก',
      borrow_qty INT DEFAULT 1,
      borrower VARCHAR(200) NOT NULL,
      department VARCHAR(200),
      borrow_date DATE,
      return_date DATE,
      return_status VARCHAR(50) DEFAULT 'ยังไม่คืน',
      notes TEXT,
      created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
  `);
  console.log('✅ DB initialized');
}
initDB().catch(console.error);

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

app.get('/equipment/:id', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM equipment WHERE id=?', [req.params.id]);
    if (!rows.length) return err(res, 'Not found', 404);
    ok(res, { ...rows[0], image_data: rows[0].image_data ? 'HAS_IMAGE' : null });
  } catch(e) { err(res, e.message); }
});

app.post('/equipment', async (req, res) => {
  try {
    const { code,name,category,team,status,location,quantity,description,purchase_date,purchase_price,notes } = req.body;
    if (!code || !name) return err(res, 'code and name required', 400);
    const [result] = await pool.query(
      'INSERT INTO equipment (code,name,category,team,status,location,quantity,description,purchase_date,purchase_price,notes) VALUES (?,?,?,?,?,?,?,?,?,?,?)',
      [code,name,category,team||'Other',status||'ปกติ',location,quantity||1,description,purchase_date||null,purchase_price||null,notes]
    );
    ok(res, { id: result.insertId }, 'Created');
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

app.listen(PORT, () => console.log(`✅ DNAT API running → http://localhost:${PORT}`));