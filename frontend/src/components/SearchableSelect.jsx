// SearchableSelect.jsx
// วางไว้ใน src/components/ แล้ว import ใช้ใน BorrowModal

import { useState, useRef, useEffect } from "react";

/**
 * Props:
 *   options   - Array ของ { value, label }  เช่น equipment list
 *   value     - value ที่เลือกอยู่
 *   onChange  - fn(value, option) เมื่อเลือก
 *   placeholder - text เริ่มต้น
 */
export default function SearchableSelect({ options = [], value, onChange, placeholder = "-- เลือก --" }) {
  const [open, setOpen]       = useState(false);
  const [search, setSearch]   = useState("");
  const wrapRef               = useRef(null);

  // หา label ของ value ปัจจุบัน
  const selected = options.find(o => o.value === value);

  // กรองตาม search
  const filtered = options.filter(o =>
    o.label.toLowerCase().includes(search.toLowerCase())
  );

  // ปิด dropdown เมื่อคลิกนอก
  useEffect(() => {
    function handleClick(e) {
      if (wrapRef.current && !wrapRef.current.contains(e.target)) {
        setOpen(false);
        setSearch("");
      }
    }
    document.addEventListener("mousedown", handleClick);
    return () => document.removeEventListener("mousedown", handleClick);
  }, []);

  function handleSelect(opt) {
    onChange(opt.value, opt);
    setOpen(false);
    setSearch("");
  }

  return (
    <div ref={wrapRef} style={{ position: "relative", width: "100%" }}>
      {/* ปุ่มแสดงค่าที่เลือก */}
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

      {/* Dropdown */}
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
          {/* Search input */}
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

          {/* รายการ */}
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
