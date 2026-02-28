// ตัวอย่างการใช้ SearchableSelect ใน BorrowModal
// =====================================================
// แทนที่ <select> เดิมในฟอร์มเบิกอุปกรณ์

import { useState, useEffect } from "react";
import SearchableSelect from "./SearchableSelect"; // import component

// ใน BorrowModal component:

function BorrowModal({ onClose, onSaved }) {
  const [equipmentList, setEquipmentList] = useState([]);
  const [form, setForm] = useState({
    doc_no: `BRW-${Math.random().toString(36).substr(2,6).toUpperCase()}`,
    equipment_code: "",
    equipment_name: "",
    borrow_qty: "1",
    borrower: "",
    department: "",
    borrow_date: new Date().toISOString().split("T")[0],
    notes: "",
  });

  // โหลดรายการอุปกรณ์
  useEffect(() => {
    fetch("/equipment")
      .then(r => r.json())
      .then(json => setEquipmentList(json.data || []));
  }, []);

  // แปลง equipment เป็น options สำหรับ SearchableSelect
  const equipmentOptions = equipmentList.map(eq => ({
    value: eq.id,
    label: `${eq.code} — ${eq.name}`,
    code: eq.code,
    name: eq.name,
  }));

  function handleEquipmentChange(val, opt) {
    setForm(f => ({
      ...f,
      equipment_code: opt?.code || "",
      equipment_name: opt?.name || "",
    }));
  }

  async function handleSubmit() {
    if (!form.borrower || !form.equipment_code) {
      alert("กรุณากรอกผู้เบิกและเลือกอุปกรณ์");
      return;
    }

    // ส่งข้อมูลไป POST /history
    // NOTE: ส่งแค่ field ที่มีในตาราง (ไม่ส่ง equipment_id / expected_return_date)
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
      onSaved?.();
      onClose?.();
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

      {/* 🔍 Searchable Dropdown แทน <select> เดิม */}
      <label>อุปกรณ์</label>
      <SearchableSelect
        options={equipmentOptions}
        value={equipmentOptions.find(o => o.code === form.equipment_code)?.value}
        onChange={handleEquipmentChange}
        placeholder="-- เลือกอุปกรณ์ --"
      />

      {/* จำนวน */}
      <label>จำนวนที่เบิก</label>
      <input value={form.borrow_qty} onChange={e => setForm(f => ({...f, borrow_qty: e.target.value}))} />

      {/* ผู้เบิก */}
      <label>ผู้เบิก</label>
      <input value={form.borrower} onChange={e => setForm(f => ({...f, borrower: e.target.value}))} />

      {/* แผนก */}
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
