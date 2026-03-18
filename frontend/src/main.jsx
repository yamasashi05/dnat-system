// จุดเริ่มต้นของแอป React (Entry Point)
// ไฟล์นี้จะถูกรันเป็นไฟล์แรกเสมอ

import React from "react"
import ReactDOM from "react-dom/client"
import App from "./App.jsx" // import component หลักของแอป

// สร้าง React root แล้วเชื่อมกับ <div id="root"> ใน index.html
// จากนั้น render component App ลงไป
ReactDOM.createRoot(document.getElementById("root")).render(
  // StrictMode: โหมดพัฒนา — ช่วยตรวจจับ bug เช่น side effects ที่ไม่ควรเกิด
  // ใช้ได้เฉพาะตอน development เท่านั้น ไม่กระทบ production build
  <React.StrictMode>
    <App />
  </React.StrictMode>
)