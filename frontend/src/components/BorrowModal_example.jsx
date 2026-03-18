// ============================================================
// BorrowModal_example.jsx
// ตัวอย่างการใช้ SearchableSelect ใน Modal บันทึกการเบิกอุปกรณ์
// แทนที่ <select> เดิมด้วย dropdown ที่ค้นหาได้
// ============================================================

import { useState, useEffect } from "react";
import SearchableSelect from "./SearchableSelect"; // import component

function BorrowModal({ onClose, onSaved }) {
  // ── State: รายการอุปกรณ์ทั้งหมด (โหลดจาก API) ──────────────
  const [equipmentList, setEquipmentList] = useState([]);

  // ── State: ข้อมูลฟอร์ม ─────────────────────────────────────
  const [form, setForm] = useState({
    doc_no: `BRW-${Math.random().toString(36).substr(2,6).toUpperCase()}`, // สร้างเลขที่เอกสารแบบสุ่ม
    equipment_code: "",
    equipment_name: "",
    borrow_qty: "1",
    borrower: "",
    department: "",
    borrow_date: new Date().toISOString().split("T")[0], // วันนี้เป็นค่าเริ่มต้น
    notes: "",
  });

  // ── โหลดรายการอุปกรณ์จาก API ตอน component mount ──────────
  useEffect(() => {
    fetch("/equipment")
      .then(r => r.json())
      .then(json => setEquipmentList(json.data || []));
  }, []);

  // ── แปลง equipment array → format ที่ SearchableSelect ใช้ ─
  // label แสดง "รหัส — ชื่อ" เพื่อให้ค้นหาได้ทั้งสองแบบ
  const equipmentOptions = equipmentList.map(eq => ({
    value: eq.id,
    label: `${eq.code} — ${eq.name}`,
    code: eq.code,   // ข้อมูลพิเศษที่เก็บไว้ใน option
    name: eq.name,
  }));

  // ── Handler: เมื่อผู้ใช้เลือกอุปกรณ์จาก dropdown ──────────
  // อัปเดต equipment_code และ equipment_name ใน form พร้อมกัน
  function handleEquipmentChange(val, opt) {
    setForm(f => ({
      ...f,
      equipment_code: opt?.code || "",
      equipment_name: opt?.name || "",
    }));
  }

  // ── Handler: บันทึกการเบิก ──────────────────────────────────
  async function handleSubmit() {
    if (!form.borrower || !form.equipment_code) {
      alert("กรุณากรอกผู้เบิกและเลือกอุปกรณ์");
      return;
    }

    // ส่งข้อมูลไป POST /history
    // NOTE: ส่งเฉพาะ field ที่มีใน borrow_history table เท่านั้น
    const res = await fetch("/history", {
      method: "POST",
      headers: { "Content-Type": "application/json" },
      body: JSON.stringify({
        doc_no:           form.doc_no,
        equipment_code:   form.equipment_code,
        equipment_name:   form.equipment_name,
        type:             "เบิก",
        borrow_qty:       form.borrow_qty,
        borrower:         form.borrower,
        department:       form.department,
        borrow_date:      form.borrow_date,
        notes:            form.notes,
      }),
    });
    const json = await res.json();
    if (json.success) {
      onSaved?.(); // แจ้ง parent ให้ reload ข้อมูล
      onClose?.(); // ปิด modal
    } else {
      alert("เกิดข้อผิดพลาด: " + json.message);
    }
  }

  return (
    <div className="modal">
      <h3>บันทึกการเบิกอุปกรณ์</h3>

      {/* เลขที่เอกสาร */}
      <label>เลขที่เอกสาร</label>
      <input value={form.doc_no} onChange={e => setForm(f => ({...f, doc_no: e.target.value}))} />

      {/* 🔍 SearchableSelect แทน <select> เดิม ────────────────
          - options: รายการอุปกรณ์ทั้งหมด (label = "รหัส — ชื่อ")
          - value: ผูกกับ equipment_code ที่เลือกอยู่
          - onChange: อัปเดตทั้ง code และ name ใน form */}
      <label>อุปกรณ์</label>
      <SearchableSelect
        options={equipmentOptions}
        value={equipmentOptions.find(o => o.code === form.equipment_code)?.value}
        onChange={handleEquipmentChange}
        placeholder="-- เลือกอุปกรณ์ --"
      />

      {/* จำนวนที่เบิก */}
      <label>จำนวนที่เบิก</label>
      <input value={form.borrow_qty} onChange={e => setForm(f => ({...f, borrow_qty: e.target.value}))} />

      {/* ผู้เบิก (field บังคับ) */}
      <label>ผู้เบิก</label>
      <input value={form.borrower} onChange={e => setForm(f => ({...f, borrower: e.target.value}))} />

      {/* แผนก/ทีม */}
      <label>แผนก</label>
      <input value={form.department} onChange={e => setForm(f => ({...f, department: e.target.value}))} />

      {/* วันที่เบิก */}
      <label>วันที่เบิก</label>
      <input type="date" value={form.borrow_date} onChange={e => setForm(f => ({...f, borrow_date: e.target.value}))} />

      {/* หมายเหตุ */}
      <label>หมายเหตุ</label>
      <textarea value={form.notes} onChange={e => setForm(f => ({...f, notes: e.target.value}))} />

      <button onClick={handleSubmit}>บันทึก</button>
      <button onClick={onClose}>ยกเลิก</button>
    </div>
  );
}

export default BorrowModal;