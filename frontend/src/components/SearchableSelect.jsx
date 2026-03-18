// ============================================================
// SearchableSelect.jsx
// Dropdown component ที่มีช่องค้นหาในตัว (แบบ standalone)
// วางไว้ใน src/components/ แล้ว import ใช้ที่ไหนก็ได้
// ============================================================

import { useState, useRef, useEffect } from "react";

/**
 * Props:
 *   options     - Array ของ { value, label } เช่น equipment list
 *   value       - value ที่เลือกอยู่ในขณะนี้
 *   onChange    - fn(value, option) เรียกเมื่อผู้ใช้เลือกรายการ
 *   placeholder - ข้อความเริ่มต้นเมื่อยังไม่ได้เลือก
 */
export default function SearchableSelect({ options = [], value, onChange, placeholder = "-- เลือก --" }) {
  const [open, setOpen]     = useState(false);   // เปิด/ปิด dropdown panel
  const [search, setSearch] = useState("");      // ข้อความที่พิมพ์ในช่องค้นหา
  const wrapRef             = useRef(null);      // ref ของ wrapper div

  // หา option ที่ตรงกับ value ปัจจุบัน (สำหรับแสดง label บนปุ่ม)
  const selected = options.find(o => o.value === value);

  // กรองรายการตาม search (case-insensitive)
  const filtered = options.filter(o =>
    o.label.toLowerCase().includes(search.toLowerCase())
  );

  // ── ปิด dropdown เมื่อคลิกนอก component ───────────────────
  useEffect(() => {
    function handleClick(e) {
      if (wrapRef.current && !wrapRef.current.contains(e.target)) {
        setOpen(false);
        setSearch(""); // reset ช่องค้นหาด้วย
      }
    }
    document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, []);

  // ── Handler: เลือกรายการ ────────────────────────────────────
  function handleSelect(opt) {
    onChange(opt.value, opt); // ส่งทั้ง value และ option object กลับให้ parent
    setOpen(false);
    setSearch("");
  }

  return (
    // wrapper: position relative เพื่อให้ dropdown วาง absolute ได้
    <div ref={wrapRef} style={{ position: "relative", width: "100%" }}>

      {/* ── ปุ่ม trigger ──────────────────────────────────────── */}
      <div
        onClick={() => setOpen(prev => !prev)}
        style={{
          padding: "8px 12px",
          background: "#1e2435",
          border: "1px solid #3a3f55",
          borderRadius: "6px",
          color: selected ? "#fff" : "#888",
          cursor: "pointer",
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <span>{selected ? selected.label : placeholder}</span>
        <span style={{ fontSize: "10px", opacity: 0.6 }}>{open ? "▲" : "▼"}</span>
      </div>

      {/* ── Dropdown panel ─────────────────────────────────────── */}
      {open && (
        <div
          style={{
            position: "absolute",
            top: "calc(100% + 4px)",
            left: 0,
            right: 0,
            background: "#1e2435",
            border: "1px solid #3a3f55",
            borderRadius: "6px",
            zIndex: 9999,
            maxHeight: "260px",
            display: "flex",
            flexDirection: "column",
            boxShadow: "0 8px 24px rgba(0,0,0,0.5)",
          }}
        >
          {/* ช่องค้นหา: autoFocus เมื่อ dropdown เปิด */}
          <div style={{ padding: "8px" }}>
            <input
              autoFocus
              placeholder="🔍 ค้นหาอุปกรณ์..."
              value={search}
              onChange={e => setSearch(e.target.value)}
              style={{
                width: "100%",
                padding: "6px 10px",
                background: "#2a2f45",
                border: "1px solid #3a3f55",
                borderRadius: "4px",
                color: "#fff",
                outline: "none",
                boxSizing: "border-box",
              }}
            />
          </div>

          {/* รายการ: scroll ได้, highlight item ที่เลือกอยู่ */}
          <div style={{ overflowY: "auto", maxHeight: "200px" }}>
            {filtered.length === 0 ? (
              <div style={{ padding: "12px", color: "#888", textAlign: "center" }}>
                ไม่พบอุปกรณ์
              </div>
            ) : (
              filtered.map(opt => (
                <div
                  key={opt.value}
                  onClick={() => handleSelect(opt)}
                  style={{
                    padding: "8px 12px",
                    cursor: "pointer",
                    color: opt.value === value ? "#60a5fa" : "#ccc",
                    background: opt.value === value ? "#2a3555" : "transparent",
                    fontSize: "13px",
                  }}
                  onMouseEnter={e => e.currentTarget.style.background = "#2a3555"}
                  onMouseLeave={e => e.currentTarget.style.background = opt.value === value ? "#2a3555" : "transparent"}
                >
                  {opt.label}
                </div>
              ))
            )}
          </div>
        </div>
      )}
    </div>
  );
}