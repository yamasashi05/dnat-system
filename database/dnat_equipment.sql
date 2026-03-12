-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: db
-- Generation Time: Mar 11, 2026 at 03:38 PM
-- Server version: 8.0.44
-- PHP Version: 8.3.30

USE defaultdb;

SET SESSION sql_require_primary_key=0;
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dnat_equipment`
--

-- --------------------------------------------------------

--
-- Table structure for table `borrow_history`
--

CREATE TABLE `borrow_history` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `doc_no` varchar(50) NOT NULL,
  `equipment_code` varchar(20) NOT NULL,
  `equipment_name` varchar(255) NOT NULL,
  `type` varchar(20) NOT NULL,
  `borrow_date` date NOT NULL,
  `borrower` varchar(100) NOT NULL,
  `department` varchar(100) NOT NULL DEFAULT '',
  `borrow_qty` int NOT NULL DEFAULT 1,
  `return_date` date DEFAULT NULL,
  `return_status` varchar(50) NOT NULL,
  `notes` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
);
--
-- Dumping data for table `borrow_history`
--

INSERT INTO `borrow_history` (`id`, `doc_no`, `equipment_code`, `equipment_name`, `type`, `borrow_date`, `borrower`, `department`, `borrow_qty`, `return_date`, `return_status`, `notes`, `created_at`) VALUES
(1, 'BRW-001', 'A093', 'เสื้อดำ SpotLight', 'เบิก', '2026-01-20', 'เจ', 'Other', 2, NULL, 'ยังไม่คืน', 'เจ ยืม คอปก XL และ คอV XL', '2026-02-26 16:36:33'),
(2, 'BRW-002', 'A320', 'กระเป๋าเทาอ่อน', 'เบิก', '2026-01-22', 'ม่อน', 'Other', 1, '2026-02-27', 'ยังไม่คืน', 'ม่อน ยืม กระเป๋า ', '2026-02-26 16:36:33');

-- --------------------------------------------------------

--
-- Table structure for table `equipment`
--

CREATE TABLE `equipment` (
  `id` int UNSIGNED NOT NULL,
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `team` varchar(100) NOT NULL,
  `category` varchar(100) NOT NULL,
  `quantity` int NOT NULL DEFAULT '0',
  `image_path` varchar(500) DEFAULT NULL,
  `status` varchar(50) NOT NULL,
  `description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `location` varchar(100) DEFAULT NULL,
  `image_data` mediumblob,
  `image_mime` varchar(100) DEFAULT NULL,
  `purchase_date` date DEFAULT NULL,
  `purchase_price` decimal(12,2) DEFAULT NULL,
  `notes` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `equipment`
--

INSERT INTO `equipment` (`id`, `code`, `name`, `team`, `category`, `quantity`, `image_path`, `status`, `description`, `created_at`, `updated_at`, `location`, `image_data`, `image_mime`, `purchase_date`, `purchase_price`, `notes`) VALUES
(1, 'A001', 'ตัวส่งสัญญาณ Hollyland (ตัวรับ)', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/1_1772163935556.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวเครื่อง 1 - เสาสัญญาณ 2', '2026-02-26 16:35:35', '2026-02-27 03:45:35', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 'A002', 'ตัวส่งสัญญาณ Hollyland (ตัวรับ+ตัวส่ง)', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/2_1772163943412.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวเครื่องรับ 1 - ตัวเครื่องส่ง 1 - ตัวต่อมอนิเตอร์ 1 - usb 1', '2026-02-26 16:35:35', '2026-02-27 03:45:43', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 'A003', 'ไมโครโฟน Wireless Hollyland', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/3_1772163949653.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวรับสัญญาณ 1 - ไมค์ 2 - สายไมค์ ( หัวแจ็ค) 2 - สาย c to lightning 1 - c to c 1 - usb a to c 1 - สายต่อกล้อง แจ็ค to แจ็ค1 - สาย usb to android', '2026-02-26 16:35:35', '2026-02-27 03:45:49', NULL, NULL, NULL, NULL, NULL, NULL),
(4, 'A004', 'ไมโครโฟน Wireless dji ไมค์1', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/4_1772163959149.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวรับสัญญาณ 1 - ไมค์ 1 - สาย jack to jack 1 - สาย usb to type c - ที่กันลม 1 - ไมค์สาย หัวjack 1 - ตัวเชื่อมโทรศัพท์ type c 1 - ตัวเชื่อมโทรศัพท์ lightning 1', '2026-02-26 16:35:35', '2026-02-27 03:45:59', NULL, NULL, NULL, NULL, NULL, NULL),
(5, 'A005', 'ไมโครโฟน Wireless dji ไมค์2', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/5_1772163965812.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไมค์ 2 - ตัวส่งสัญญาณ 1 - แม่เหล็กติดไมค์ 2 - ตัวเชื่อมโทรศัพท์ type c 1 - ตัวเชื่อมโทรศัพท์ lightning 1 - ที่กันลม 2 - สาย jack to jack - สาย usb to type c - ไมค์สาย หัวjack 1', '2026-02-26 16:35:35', '2026-02-27 03:46:05', NULL, NULL, NULL, NULL, NULL, NULL),
(6, 'A006', 'ตัวส่งสัญญาณ VRRIIS (เสายาว)', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/6_1772163978980.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวส่งสัญญาณ 2 - เสายาว 4 - หัวชาร์จ 2 - สายชาร์จ usb to type c 2 - สาย IR RX 1 - สาย IR TX 1', '2026-02-26 16:35:35', '2026-02-27 03:46:18', NULL, NULL, NULL, NULL, NULL, NULL),
(7, 'A007', 'จอมอนิเตอร์ FEELWORLD', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/7_1772163986561.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - จอมอนิเตอร์ 1 - กรอบจอมอนิเตอร์ 1 - สาย HDMI 1 - ตัวบังแสง 1 - ชุด 6 เหลี่ยมและเกรียว 1 - ขาตั้งจอ 1', '2026-02-26 16:35:35', '2026-02-27 03:46:26', NULL, NULL, NULL, NULL, NULL, NULL),
(8, 'A008', 'Dual Handgrip SmallRig', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/8_1772163993916.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ด้ามจับคู่ 2 - ด้ามจับยาว 2', '2026-02-26 16:35:35', '2026-02-27 03:46:33', NULL, NULL, NULL, NULL, NULL, NULL),
(9, 'A009', 'จอมอนิเตอร์ FEELWORLD (กล่องแดง-เขียว)', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/9_1772164004056.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - จอมอนิเตอร์เล็ก 1 - กรอบจอมอนิเตอร์ 1 - ตัวบังแสง 1 - ขาล็อกจอ 1 - สาย HDTV TO MICRO 1 - หัวปลั๊ก 1 - Hotshoe 1 - 6 เหลี่ยม 1 *มีกล่องเดียว', '2026-02-26 16:35:35', '2026-02-27 03:46:44', NULL, NULL, NULL, NULL, NULL, NULL),
(10, 'A010', 'โรนิน For Rs3 Mini', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/10_1772164011177.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวเครื่องโรนิน For Rs3 Mini 5 ชิ้น 1 - สาย Type c to type c 1 - ตัวจับด้ามยาว 1 - ตัวจับด้ามจับกลม 1 - อุปกรณ์เสริมยางซิลิโคน 1 - ชุดน็อตและ6เหลี่ยม 1', '2026-02-26 16:35:35', '2026-02-27 03:46:51', NULL, NULL, NULL, NULL, NULL, NULL),
(11, 'A011', 'ไฟสตูดิโอ YONGNUO YNLUX200', 'Production', 'แสง', 1, '/uploads/equipment/11_1772164020196.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวเครื่องไฟ 1 - ชุดปลั๊กพร้อมสาย 1 - สายปลั๊กแยก 1 - ที่ครอบไฟ 1 - ตัวจับเครื่องไฟ 1 - อะไหล่เหล็ก 1 - สายผ้า 1', '2026-02-26 16:35:35', '2026-02-27 03:47:00', NULL, NULL, NULL, NULL, NULL, NULL),
(12, 'A012', 'แบตเตอรี่ DIGITAL VIDEO F750/F770', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/12_1772164037379.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:47:17', NULL, NULL, NULL, NULL, NULL, NULL),
(13, 'A013', 'แบตเตอรี่ DIGITAL VIDEO NP-F750A', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/13_1772164053638.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:47:33', NULL, NULL, NULL, NULL, NULL, NULL),
(14, 'A014', 'แบตเตอรี่ DIGITAL VIDEO NP-F980T', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/14_1772164059688.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:47:39', NULL, NULL, NULL, NULL, NULL, NULL),
(15, 'A015', 'แบตเตอรี่ DIGITAL VIDEO NP-F770T', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/15_1772164069667.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:47:49', NULL, NULL, NULL, NULL, NULL, NULL),
(16, 'A016', 'แบตเตอรี่ DIGITAL CAMERA NP-F990', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/16_1772164076589.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:47:56', NULL, NULL, NULL, NULL, NULL, NULL),
(17, 'A017', 'แบตเตอรี่ SD-F980-DT8000', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/17_1772164086562.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:48:06', NULL, NULL, NULL, NULL, NULL, NULL),
(18, 'A018', 'แบตเตอรี่ CHARGER FOR NP-F970, FM50, QM91D', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/18_1772164093543.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวชาร์จ 1', '2026-02-26 16:35:35', '2026-02-27 03:48:13', NULL, NULL, NULL, NULL, NULL, NULL),
(19, 'A019', 'แบตเตอรี่ CHARGER (ไม่มีกล่อง)', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/19_1772164140812.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวชาร์จ 1', '2026-02-26 16:35:35', '2026-02-27 03:49:00', NULL, NULL, NULL, NULL, NULL, NULL),
(20, 'A020', 'แบตเตอรี่ (ไม่มีกล่อง)', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/20_1772164147054.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:49:07', NULL, NULL, NULL, NULL, NULL, NULL),
(21, 'A021', 'ดอลลี่', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/21_1772164160343.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ดอลลี่ 1', '2026-02-26 16:35:35', '2026-02-27 03:49:20', NULL, NULL, NULL, NULL, NULL, NULL),
(22, 'A022', 'CITYORK V Mount Replacement Battery BP-222', 'Production', 'ไฟฟ้า', 2, '/uploads/equipment/22_1772164169705.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตเตอรี่ 1 - สาย C to C 1', '2026-02-26 16:35:35', '2026-02-27 03:49:29', NULL, NULL, NULL, NULL, NULL, NULL),
(23, 'A023', 'ชุดแขนข้อต่อ Crab Claw Clamp, แคลมป์หนีบหัวบอล D5334-1', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/23_1772164177044.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ชุดแขนข้อต่อ Crab Claw Clamp 1 - แคลมป์หนีบหัวบอล 1', '2026-02-26 16:35:35', '2026-02-27 03:49:37', NULL, NULL, NULL, NULL, NULL, NULL),
(24, 'A024', 'ขาตั้งแขนจับกล้อง', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/24_1772164185846.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งแขนจับกล้อง 1', '2026-02-26 16:35:35', '2026-02-27 03:49:45', NULL, NULL, NULL, NULL, NULL, NULL),
(25, 'A025', 'คลิป/แคลมป์หนีบ', 'Production', 'ไฟฟ้า', 3, '/uploads/equipment/25_1772164195164.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - คลิป/แคลมป์หนีบ 3', '2026-02-26 16:35:35', '2026-02-27 03:49:55', NULL, NULL, NULL, NULL, NULL, NULL),
(26, 'A026', 'ข้อต่อเกลียว', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/26_1772164202915.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ข้อต่อเกลียว 1', '2026-02-26 16:35:35', '2026-02-27 03:50:02', NULL, NULL, NULL, NULL, NULL, NULL),
(27, 'A027', 'ชุดข้อต่อ', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/27_1772164210333.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Magic arm 1 - SmallRig 1 - Magic arm ball head 1 - Hot Shoe mount addapter 2 - Hot Shoe mount 1/4 1 - ชุด 6 เหลี่ยมและน๊อต', '2026-02-26 16:35:35', '2026-02-27 03:50:10', NULL, NULL, NULL, NULL, NULL, NULL),
(28, 'A028', 'ชุดข้อต่อ2', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/28_1772164219530.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ที่หนีบแท่งเหล็ก 3 - Mini ball head 2 - Head Clip 3', '2026-02-26 16:35:35', '2026-02-27 03:50:19', NULL, NULL, NULL, NULL, NULL, NULL),
(29, 'A029', 'Intercom Hollyland', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/29_1772164227810.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Intercom 6 - แบตหลัก 8 - แบตสำรอง 4 - แท่นชาร์จ 1 - ฟองน้ำหูฟังสำรอง 6 - ปลั๊กเสียบแบต 2 ( ชำรุด1) -ฟองน้ำหูฟัง 5 (ชำรุด5)', '2026-02-26 16:35:35', '2026-02-27 03:50:27', NULL, NULL, NULL, NULL, NULL, NULL),
(30, 'A030', 'สาย 3.5 TO 3.5 2ขีด', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/30_1772164249136.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 to 3.5 7 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:50:49', NULL, NULL, NULL, NULL, NULL, NULL),
(31, 'A031', 'สาย 3.5 TO 3.5 3 ขีด', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/31_1772164260742.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 to 3.5 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:51:00', NULL, NULL, NULL, NULL, NULL, NULL),
(32, 'A032', 'สาย 3.5 TO 3.5 3 ขีด (เมีย)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/32_1772164269168.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 to 3.5 เมีย 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:51:09', NULL, NULL, NULL, NULL, NULL, NULL),
(33, 'A033', 'สาย 3.5 ออก 2 3ขีด', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/33_1772164295029.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 ออก 2 3ขีด 1เส้น', '2026-02-26 16:35:35', '2026-02-27 03:51:35', NULL, NULL, NULL, NULL, NULL, NULL),
(34, 'A034', 'สาย 3.5 ออก 2 2ขีด', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/34_1772164303925.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 ออก 2 2ขีด 2เส้น', '2026-02-26 16:35:35', '2026-02-27 03:51:43', NULL, NULL, NULL, NULL, NULL, NULL),
(35, 'A035', 'สาย 3.5 to XLR (ผู้)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/35_1772164317187.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 to XLR (ผู้) 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:51:57', NULL, NULL, NULL, NULL, NULL, NULL),
(36, 'A036', 'สาย 3.5 to XLR (ผู้) (ออกคู่)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/36_1772164396942.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 to XLR (ผู้) (ออกคู่) 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:53:16', NULL, NULL, NULL, NULL, NULL, NULL),
(37, 'A037', 'สาย 3.5 (2ขีด) to XLR (เมีย)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/37_1772164388158.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (2ขีด) to XLR (เมีย) 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:53:08', NULL, NULL, NULL, NULL, NULL, NULL),
(38, 'A038', 'สาย 3.5 (2ขีด) to canon (1ขีด)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/38_1772164352012.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (2ขีด) to canon (1ขีด) 4 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:52:32', NULL, NULL, NULL, NULL, NULL, NULL),
(39, 'A039', 'สาย 3.5 (2ขีด) to canon (1ขีด) ออก2', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/39_1772164361072.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (2ขีด) to canon (1ขีด) ออก2 2เส้น', '2026-02-26 16:35:35', '2026-02-27 03:52:41', NULL, NULL, NULL, NULL, NULL, NULL),
(40, 'A040', 'สาย 3.5 (2ขีด) to canon (2ขีด)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/40_1772164373422.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (2ขีด) to canon (2ขีด) 7 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:52:53', NULL, NULL, NULL, NULL, NULL, NULL),
(41, 'A041', 'สาย XLR (ผู้) to XLR (เมีย)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/41_1772164408966.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย XLR (ผู้) to XLR (เมีย) 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:53:28', NULL, NULL, NULL, NULL, NULL, NULL),
(42, 'A042', 'สาย 3.5 (2ขีด) to canon (เมีย)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/42_1772164418232.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (2ขีด) to canon (เมีย) 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:53:38', NULL, NULL, NULL, NULL, NULL, NULL),
(43, 'A043', 'สาย 3.5 (เมีย) to XLR (ผู้)', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/43_1772164433011.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย 3.5 (เมีย) to XLR (ผู้) 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:53:53', NULL, NULL, NULL, NULL, NULL, NULL),
(44, 'A044', 'ตัวแปลง หัว to canon', 'Event', 'อื่นๆ', 1, '/uploads/equipment/44_1772164445595.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง หัว to canon 5 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 03:54:05', NULL, NULL, NULL, NULL, NULL, NULL),
(45, 'A045', 'ตัวแปลง 3.5 (เมีย) to XLR (คู่)', 'Event', 'อื่นๆ', 1, '/uploads/equipment/45_1772164477297.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง 3.5 (เมีย) to XLR (คู่) 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 03:54:37', NULL, NULL, NULL, NULL, NULL, NULL),
(46, 'A046', 'ตัวแปลง canon (เมีย) to 3.5', 'Event', 'อื่นๆ', 1, '/uploads/equipment/46_1772164487814.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง canon (เมีย) to 3.5 1ชิ้น', '2026-02-26 16:35:35', '2026-02-27 03:54:47', NULL, NULL, NULL, NULL, NULL, NULL),
(47, 'A047', 'ตัวแปลง 3.5 to canon', 'Event', 'อื่นๆ', 1, '/uploads/equipment/47_1772164495122.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง 3.5 to canon 4 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 03:54:55', NULL, NULL, NULL, NULL, NULL, NULL),
(48, 'A048', 'ตัวแปลง 3.5 to canon (2ขีด)', 'Event', 'อื่นๆ', 1, '/uploads/equipment/48_1772164502068.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง 3.5 to canon (2ขีด) 2 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 03:55:02', NULL, NULL, NULL, NULL, NULL, NULL),
(49, 'A049', 'สาย Hdmi to hdmi ugreen 5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/49_1772164510107.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น สาย Hdmi to hdmi ugreen 5 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:55:10', NULL, NULL, NULL, NULL, NULL, NULL),
(50, 'A050', 'สาย Hdmi to hdmi สีดำแดง 1.5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/50_1772164517641.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำแดง 1.5 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:55:17', NULL, NULL, NULL, NULL, NULL, NULL),
(51, 'A051', 'สาย Hdmi to hdmi สีดำแดง 5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/51_1772164528630.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำแดง 5 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:55:28', NULL, NULL, NULL, NULL, NULL, NULL),
(52, 'A052', 'สาย Hdmi to hdmi สีดำแดง 1 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/52_1772164537806.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำแดง 1 m. 3 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:55:37', NULL, NULL, NULL, NULL, NULL, NULL),
(53, 'A053', 'สาย Hdmi to hdmi สีดำ ล้วน 3 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/53_1772164547367.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำ ล้วน 3 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:55:47', NULL, NULL, NULL, NULL, NULL, NULL),
(54, 'A054', 'สาย Hdmi to hdmi สีดำ ล้วน 1.5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/54_1772164562350.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำ ล้วน 1.5 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:02', NULL, NULL, NULL, NULL, NULL, NULL),
(55, 'A055', 'สาย Hdmi to hdmi สีดำ Samsung 1.5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/55_1772164570821.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำ Samsung 1.5 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:10', NULL, NULL, NULL, NULL, NULL, NULL),
(56, 'A056', 'สาย Hdmi to hdmi สีดำ 1m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/56_1772164578483.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำ 1m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:18', NULL, NULL, NULL, NULL, NULL, NULL),
(57, 'A057', 'สาย Hdmi to hdmi ugreen 1 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/57_1772164588822.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi ugreen 1 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:28', NULL, NULL, NULL, NULL, NULL, NULL),
(58, 'A058', 'สาย Hdmi to hdmi สายยืด 2.4 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/58_1772164596087.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สายยืด 2.4 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:36', NULL, NULL, NULL, NULL, NULL, NULL),
(59, 'A059', 'สาย Hdmi to hdtv 8k 0.5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/59_1772164604608.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdtv 8k 0.5 m. บน 1 เส้น - สาย Hdmi to hdtv 8k 0.5 m. ซ้าย 1 เส้น - สาย Hdmi to hdtv 8k 0.5 m. ขวา 1เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:44', NULL, NULL, NULL, NULL, NULL, NULL),
(60, 'A060', 'สาย Hdmi unitek 2 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/60_1772164613526.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi unitek 2 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:56:53', NULL, NULL, NULL, NULL, NULL, NULL),
(61, 'A061', 'สาย Hdmi ดำ ขาว 2 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/61_1772164625355.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi ดำ ขาว 2 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:05', NULL, NULL, NULL, NULL, NULL, NULL),
(62, 'A062', 'สาย HDTV to HDTV 2.0v 3 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/62_1772164634806.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย HDTV to HDTV 2.0v 3 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:14', NULL, NULL, NULL, NULL, NULL, NULL),
(63, 'A063', 'สาย HDTV to mini 4k 2 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/63_1772164643312.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย HDTV to mini 4k 2 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:23', NULL, NULL, NULL, NULL, NULL, NULL),
(64, 'A064', 'สาย HDTV to micro 2.4 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/64_1772164652515.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย HDTV to micro 2.4 m. 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:32', NULL, NULL, NULL, NULL, NULL, NULL),
(65, 'A065', 'สาย HDTV to micro 4k ซ้าย 0.5m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/65_1772164663161.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย HDTV to micro 4k ซ้าย 0.5m. 3 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:43', NULL, NULL, NULL, NULL, NULL, NULL),
(66, 'A066', 'สาย Micro m to HD F ซ้าย 0.2 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/66_1772164671136.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Micro m to HD F ซ้าย 0.2 m. 3 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:57:51', NULL, NULL, NULL, NULL, NULL, NULL),
(67, 'A067', 'สาย HDTV to mini 1 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/67_1772164686021.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย HDTV to mini 1 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:58:06', NULL, NULL, NULL, NULL, NULL, NULL),
(68, 'A068', 'สาย HDTV to mini 2.4 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/68_1772164696065.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น สาย HDTV to mini 2.4 m. 4 เส้น', '2026-02-26 16:35:35', '2026-02-27 03:58:16', NULL, NULL, NULL, NULL, NULL, NULL),
(69, 'A069', 'สาย Micro hdmi 4k cable 1 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/69_1772164724827.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Micro hdmi 4k cable 1 m. 1เส้น', '2026-02-26 16:35:35', '2026-02-27 03:58:44', NULL, NULL, NULL, NULL, NULL, NULL),
(70, 'A070', 'สาย Hdmi switch', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/70_1772164733645.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi switch 1 เส้น (ชำรุด)', '2026-02-26 16:35:35', '2026-02-27 03:58:53', NULL, NULL, NULL, NULL, NULL, NULL),
(71, 'A071', '2 port switcher ugreen', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/71_1772164745082.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - 2 port switcher ugreen 1 อัน', '2026-02-26 16:35:35', '2026-02-27 03:59:05', NULL, NULL, NULL, NULL, NULL, NULL),
(72, 'A072', 'สายแปลง to hdmi', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/72_1772164924715.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายแปลง to hdmi 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:02:04', NULL, NULL, NULL, NULL, NULL, NULL),
(73, 'A073', 'สายHDTV to micro 03 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/73_1772164962857.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายHDTV to micro 03 m. 2 เส้น (ชำรุด)', '2026-02-26 16:35:35', '2026-02-27 04:02:42', NULL, NULL, NULL, NULL, NULL, NULL),
(74, 'A074', 'สาย Hdmi to hdmi สีดำแดง 1.5 m.', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/74_1772164972875.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Hdmi to hdmi สีดำแดง 1.5 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:02:52', NULL, NULL, NULL, NULL, NULL, NULL),
(75, 'A075', 'ป้าย ปก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/75_1772164981238.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ป้าย ปกอ่อน 30 ชิ้น - ป้าย ปกแข็ง 15 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 04:03:01', NULL, NULL, NULL, NULL, NULL, NULL),
(76, 'A076', 'สายคล้องคอ', 'Other', 'ไฟฟ้า', 1, '/uploads/equipment/76_1772164988343.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายคล้องคอ น้ำเงินอ่อน 29 ชิ้น - สายคล้องคอ น้ำเงินเข้ม 16 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 04:03:08', NULL, NULL, NULL, NULL, NULL, NULL),
(77, 'A077', 'จอมอนิเตอร์', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/77_1772164997716.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - จอมอนิเตอร์ (ชำรุด)', '2026-02-26 16:35:35', '2026-02-27 04:03:17', NULL, NULL, NULL, NULL, NULL, NULL),
(78, 'A078', 'ก้อนแบต NP', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/78_1772165007339.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด -ก้อนแบต NP 3ก้อน (ชำรุด)', '2026-02-26 16:35:35', '2026-02-27 04:03:27', NULL, NULL, NULL, NULL, NULL, NULL),
(79, 'A079', 'สายปลั๊ก', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/79_1772165035423.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายปลั๊ก 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:03:55', NULL, NULL, NULL, NULL, NULL, NULL),
(80, 'A080', 'ปลั๊กพ่วง', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/80_1772165026728.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ปลั๊กพ่วง ดำ 2 อัน - ปลั๊กพ่วง ขาว 2 อัน - ปลั๊กพ่วง ฟ้า 1 อัน - ปลั๊กพ่วง ลายสี 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:03:46', NULL, NULL, NULL, NULL, NULL, NULL),
(81, 'A081', 'ไฟตกแต่ง 10 m.', 'Other', 'อื่นๆ', 1, '/uploads/equipment/81_1772165042629.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไฟตกแต่ง 10 m. 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:04:02', NULL, NULL, NULL, NULL, NULL, NULL),
(82, 'A082', 'ปากกาเมจิก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/82_1772165049734.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ปากกาเมจิก น้ำเงิน 15 ด้าม - ปากกาเมจิก แดง 7 ด้าม - ปากกาเมจิก ดำ 3 ด้าม', '2026-02-26 16:35:35', '2026-02-27 04:04:09', NULL, NULL, NULL, NULL, NULL, NULL),
(83, 'A083', 'ปากกาดำ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/83_1772165058594.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ปากกาดำ 3 ด้าม', '2026-02-26 16:35:35', '2026-02-27 04:04:18', NULL, NULL, NULL, NULL, NULL, NULL),
(84, 'A084', 'เทปกาว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/84_1772165066860.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เทปกาวหย่น แบบใหม่ 4 อัน แบบเก่า 3 อัน - เทปกาวหย่นสีดำ 1 Size S - เทปกาวหย่นสีเขียว 2 Size L - เทปกระดาษกาวหย่น Size M แบบใหม่ 13 อัน - เทปกระดาษกาวหย่น Size M แบบเก่า 5 อัน - เทปกระดาษกาวหย่น Size S แบบเก่า 2 อัน - เทปกระดาษกาวหย่น Size L แบบเก่า 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:04:26', NULL, NULL, NULL, NULL, NULL, NULL),
(85, 'A085', 'Powerbank', 'Other', 'ไฟฟ้า', 1, '/uploads/equipment/85_1772165075471.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Powerbank 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:04:35', NULL, NULL, NULL, NULL, NULL, NULL),
(86, 'A086', 'อะไหล่', 'Other', 'อื่นๆ', 1, '/uploads/equipment/86_1772165093333.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - อะไหล่ขอตั้งกล้อง 1 อัน - อะไหล่ที่จับโทรศัพท์ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:04:53', NULL, NULL, NULL, NULL, NULL, NULL),
(87, 'A087', 'ผ้าไมโครไฟเบอร์', 'Other', 'อื่นๆ', 1, '/uploads/equipment/87_1772165101973.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ผ้าไมโครไฟเบอร์ 5 ผืน', '2026-02-26 16:35:35', '2026-02-27 04:05:01', NULL, NULL, NULL, NULL, NULL, NULL),
(88, 'A088', 'หมึกเครื่องปริ้น', 'Other', 'อื่นๆ', 1, '/uploads/equipment/88_1772165426697.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หมึกเครื่องปริ้น สีเหลือง แบบเก่า 1 อัน , แบบใหม่ 11 อัน - หมึกเครื่องปริ้น สีชมพู แบบใหม่ 10 อัน - หมึกเครื่องปริ้น สีฟ้า แบบเก่า 1 อัน , แบบใหม่ 10 อัน - หมึกเครื่องปริ้น สีดำ แบบเก่า 19 อัน , แบบใหม่ 8 อัน', '2026-02-26 16:35:35', '2026-02-27 04:10:26', NULL, NULL, NULL, NULL, NULL, NULL),
(89, 'A089', 'เสื้อน้ำตาล STAFF', 'Other', 'อื่นๆ', 1, '/uploads/equipment/89_1772165454160.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คอV Size L 6 ตัว - คอV Size M 1 ตัว - คอV Size XL 8 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:10:54', NULL, NULL, NULL, NULL, NULL, NULL),
(90, 'A090', 'เสื้อม่วง STAFF', 'Other', 'อื่นๆ', 1, '/uploads/equipment/90_1772165463679.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คอV Size L 6 ตัว - คอV Size XL 1 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:11:03', NULL, NULL, NULL, NULL, NULL, NULL),
(91, 'A091', 'เสื้อเหลือง DNAT', 'Other', 'อื่นๆ', 1, '/uploads/equipment/91_1772165494358.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คอV Size L 2 ตัว - คอV Size M 1 ตัว - คอV Size S 1 ตัว - คอV Size SS 2 ตัว - คอV Size XL 1 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:11:34', NULL, NULL, NULL, NULL, NULL, NULL),
(92, 'A092', 'เสื้อดำ DNAT', 'Other', 'อื่นๆ', 1, '/uploads/equipment/92_1772165506393.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คอปก Size 2XL 4 (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:11:46', NULL, NULL, NULL, NULL, NULL, NULL),
(93, 'A093', 'เสื้อดำ SpotLight', 'Other', 'อื่นๆ', 8, '/uploads/equipment/93_1772165524187.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คอV Size M 6 ตัว - คอV Size XL 1 ตัว - คอปก Size 2XL 1 ตัว - คอปก Size ?? ? ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 09:23:05', NULL, NULL, NULL, NULL, NULL, NULL),
(94, 'A094', 'เสิ้อSuitดำ แบบบาง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/94_1772165545726.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม่มี Size 2 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:12:25', NULL, NULL, NULL, NULL, NULL, NULL),
(95, 'A095', 'เสิ้อSuitฟ้า แบบบาง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/95_1772165555551.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม่มี Size 3 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:12:35', NULL, NULL, NULL, NULL, NULL, NULL),
(96, 'A096', 'เสิ้อเชิ้ตดำ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/96_1772165564216.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size M 3 ตัว (กล่อง 1)', '2026-02-26 16:35:35', '2026-02-27 04:12:44', NULL, NULL, NULL, NULL, NULL, NULL),
(97, 'A097', 'กางเกงน้ำเงินเข้ม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/97_1772165573995.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม่มี Size 7 ตัว (กล่อง 2)', '2026-02-26 16:35:35', '2026-02-27 04:12:53', NULL, NULL, NULL, NULL, NULL, NULL),
(98, 'A098', 'เสิ้อSuitน้ำเงิน', 'Other', 'อื่นๆ', 1, '/uploads/equipment/98_1772165591078.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม่มี Size 6 ตัว (กล่อง 2)', '2026-02-26 16:35:35', '2026-02-27 04:13:11', NULL, NULL, NULL, NULL, NULL, NULL),
(99, 'A099', 'เสิ้อไหมพรม สีครีม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/99_1772165662094.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม่มี Size 7 ตัว (กล่อง 2)', '2026-02-26 16:35:35', '2026-02-27 04:14:22', NULL, NULL, NULL, NULL, NULL, NULL),
(100, 'A100', 'เสิ้อSuitครีม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/100_1772165674705.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size M 6 ตัว - Size L 2 ตัว (กล่อง 2)', '2026-02-26 16:35:35', '2026-02-27 04:14:34', NULL, NULL, NULL, NULL, NULL, NULL),
(101, 'A101', 'เสื้อกินเที่ยว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/101_1772165689341.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size 2XL 1 ตัว - Size M 3 ตัว - Size L 1 ตัว (กล่อง 2)', '2026-02-26 16:35:35', '2026-02-27 04:14:49', NULL, NULL, NULL, NULL, NULL, NULL),
(102, 'A102', 'เสื้อเหลือง SportLight', 'Other', 'อื่นๆ', 1, '/uploads/equipment/102_1772165700757.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size 2XL 2 ตัว - Size L 1 ตัว (กล่อง 3)', '2026-02-26 16:35:35', '2026-02-27 04:15:00', NULL, NULL, NULL, NULL, NULL, NULL),
(103, 'A103', 'กางเกงครีม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/103_1772165711352.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size M 1 ตัว - Size L 2 ตัว - Size XL 2 ตัว - Size 2XL 1 ตัว (กล่อง 3)', '2026-02-26 16:35:35', '2026-02-27 04:15:11', NULL, NULL, NULL, NULL, NULL, NULL),
(104, 'A104', 'เสื้อกั้กสีดำ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/104_1772165723702.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Size M 1 ตัว - Size L 1 ตัว - Size XL 1 ตัว - Size 2XL 1 ตัว (กล่อง 3)', '2026-02-26 16:35:35', '2026-02-27 04:15:23', NULL, NULL, NULL, NULL, NULL, NULL),
(105, 'A105', 'Adapter Asus', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/105_1772165732102.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Adapter Asus 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:15:32', NULL, NULL, NULL, NULL, NULL, NULL),
(106, 'A106', 'blackmagic switching ตัวเก่า', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/106_1772165747473.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - blackmagic switching ตัวเก่า 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:15:47', NULL, NULL, NULL, NULL, NULL, NULL),
(107, 'A107', 'blue screen', 'Event', 'อื่นๆ', 1, '/uploads/equipment/107_1772165764227.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - blue screen 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:04', NULL, NULL, NULL, NULL, NULL, NULL),
(108, 'A108', 'green screen', 'Event', 'อื่นๆ', 1, '/uploads/equipment/108_1772165772788.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - green screen 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:12', NULL, NULL, NULL, NULL, NULL, NULL),
(109, 'A109', 'Hdmi wireless 1', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/109_1772165784012.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hdmi wireless 1 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:24', NULL, NULL, NULL, NULL, NULL, NULL),
(110, 'A110', 'Hdmi wireless 2', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/110_1772165792587.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hdmi wireless 2 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:32', NULL, NULL, NULL, NULL, NULL, NULL),
(111, 'A111', 'Intercom ชุด 9 หู', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/111_1772165800630.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Intercom ชุด 9 หู 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:40', NULL, NULL, NULL, NULL, NULL, NULL),
(112, 'A112', 'ไมค์ ISOMAX', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/112_1772165808861.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไมค์ ISOMAX 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:16:48', NULL, NULL, NULL, NULL, NULL, NULL),
(113, 'A113', 'ไมค์ Handheld Shure', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/113_1772165871332.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไมค์ Handheld Shure 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:17:51', NULL, NULL, NULL, NULL, NULL, NULL),
(114, 'A114', 'ไมค์ สัมภาษณ์', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/114_1772165879969.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไมค์ สัมภาษณ์ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:17:59', NULL, NULL, NULL, NULL, NULL, NULL),
(115, 'A115', 'ลำโพงเคลื่อนที่ Sheman', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/115_1772165888602.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ลำโพงเคลื่อนที่ Sheman 1 ชุด - ไมค์ 1 ตัว', '2026-02-26 16:35:35', '2026-02-27 04:18:08', NULL, NULL, NULL, NULL, NULL, NULL),
(116, 'A116', 'วิทยุสื่อสารสีแดง', 'Production', 'เสียง', 1, '/uploads/equipment/116_1772165896087.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - วิทยุสื่อสารสีแดง 9 ตัว', '2026-02-26 16:35:35', '2026-02-27 04:18:16', NULL, NULL, NULL, NULL, NULL, NULL),
(117, 'A117', 'Reflex เล็ก', 'Production', 'แสง', 1, '/uploads/equipment/117_1772165904338.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Reflex เล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:18:24', NULL, NULL, NULL, NULL, NULL, NULL),
(118, 'A118', 'Reflex กลาง', 'Production', 'แสง', 1, '/uploads/equipment/118_1772165915144.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Reflex กลาง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:18:35', NULL, NULL, NULL, NULL, NULL, NULL),
(119, 'A119', 'Reflex ใหญ่', 'Production', 'แสง', 1, '/uploads/equipment/119_1772165923872.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Reflex ใหญ่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:18:43', NULL, NULL, NULL, NULL, NULL, NULL),
(120, 'A120', 'Slate', 'Production', 'อื่นๆ', 1, '/uploads/equipment/120_1772165933509.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Slate 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:18:53', NULL, NULL, NULL, NULL, NULL, NULL),
(121, 'A121', 'Soft box อันเก่า', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/121_1772165942240.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Soft box อันเก่า 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:19:02', NULL, NULL, NULL, NULL, NULL, NULL),
(122, 'A122', 'Soft box อันใหม่', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/122_1772165953732.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Soft box อันใหม่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:19:13', NULL, NULL, NULL, NULL, NULL, NULL),
(123, 'A123', 'Switching อันใหม่', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/123_1772166194723.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Switching อันใหม่ 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:23:14', NULL, NULL, NULL, NULL, NULL, NULL),
(124, 'A124', 'Ronin Dji sc', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/124_1772166206640.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Ronin Dji sc 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:23:26', NULL, NULL, NULL, NULL, NULL, NULL),
(125, 'A125', 'USB เครื่องอัดเสียง', 'Production', 'เสียง', 1, '/uploads/equipment/125_1772166216140.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - USB เครื่องอัดเสียง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:23:36', NULL, NULL, NULL, NULL, NULL, NULL),
(126, 'A126', 'ขาตั้ง MONO อันเล็ก', 'Production', 'อื่นๆ', 1, '/uploads/equipment/126_1772166230259.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง MONO อันเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:23:50', NULL, NULL, NULL, NULL, NULL, NULL),
(127, 'A127', 'ขาตั้ง MONO 1', 'Production', 'อื่นๆ', 1, '/uploads/equipment/127_1772166245253.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง MONO 1 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:24:05', NULL, NULL, NULL, NULL, NULL, NULL),
(128, 'A128', 'ขาตั้ง MONO 2', 'Production', 'อื่นๆ', 1, '/uploads/equipment/128_1772166263340.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง MONO 2 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:24:23', NULL, NULL, NULL, NULL, NULL, NULL),
(129, 'A129', 'ขาตั้ง', 'Production', 'อื่นๆ', 1, '/uploads/equipment/129_1772166275191.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:24:35', NULL, NULL, NULL, NULL, NULL, NULL),
(130, 'A130', 'ขาตั้ง 1', 'Production', 'อื่นๆ', 1, '/uploads/equipment/130_1772166286278.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง1 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:24:46', NULL, NULL, NULL, NULL, NULL, NULL),
(131, 'A131', 'ขาตั้ง 2', 'Production', 'อื่นๆ', 1, '/uploads/equipment/131_1772166296210.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง2 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:24:56', NULL, NULL, NULL, NULL, NULL, NULL),
(132, 'A132', 'ขาตั้ง Mini Studio', 'Production', 'อื่นๆ', 1, '/uploads/equipment/132_1772166305009.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง Mini Studio 1ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:05', NULL, NULL, NULL, NULL, NULL, NULL),
(133, 'A133', 'ขาตั้ง 3 ขา สีดำ', 'Production', 'อื่นๆ', 1, '/uploads/equipment/133_1772166314113.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 3 ขา สีดำ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:14', NULL, NULL, NULL, NULL, NULL, NULL),
(134, 'A134', 'ขาตั้ง 3 ขา สีฟ้า', 'Production', 'อื่นๆ', 1, '/uploads/equipment/134_1772166322994.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 3 ขา สีฟ้า1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:22', NULL, NULL, NULL, NULL, NULL, NULL),
(135, 'A135', 'ขาตั้ง 3 ขา สีเทา', 'Production', 'อื่นๆ', 1, '/uploads/equipment/135_1772166331634.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 3 ขา สีเทา1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:31', NULL, NULL, NULL, NULL, NULL, NULL),
(136, 'A136', 'ขาตั้งจอ', 'Production', 'อื่นๆ', 1, '/uploads/equipment/136_1772166342230.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งจอ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:42', NULL, NULL, NULL, NULL, NULL, NULL),
(137, 'A137', 'ขาตั้ง I Pad', 'Production', 'อื่นๆ', 1, '/uploads/equipment/137_1772166353544.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง I Pad 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:25:53', NULL, NULL, NULL, NULL, NULL, NULL),
(138, 'A138', 'ขาตั้ง 3 ขา อันเล็ก', 'Production', 'อื่นๆ', 1, '/uploads/equipment/138_1772166366315.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 3 ขา อันเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:26:06', NULL, NULL, NULL, NULL, NULL, NULL),
(139, 'A139', 'ขาตั้ง Sony', 'Production', 'อื่นๆ', 1, '/uploads/equipment/139_1772166381495.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง Sony 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:26:21', NULL, NULL, NULL, NULL, NULL, NULL),
(140, 'A140', 'ขาตั้ง Screen', 'Production', 'อื่นๆ', 1, '/uploads/equipment/140_1772166394030.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง Screen 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:26:34', NULL, NULL, NULL, NULL, NULL, NULL),
(141, 'A141', 'ชุดตั้งไฟเป่าลม', 'Production', 'อื่นๆ', 1, '/uploads/equipment/141_1772166415448.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 1 ชุด - ไฟเป่าลม 1 ชุด - สายไฟ 1 ชุด - ข้อต่อ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:26:55', NULL, NULL, NULL, NULL, NULL, NULL),
(142, 'A142', 'ขาตั้งเล็ก', 'Production', 'อื่นๆ', 1, '/uploads/equipment/142_1772166668278.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งอันเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:31:08', NULL, NULL, NULL, NULL, NULL, NULL),
(143, 'A143', 'ขาตั้งใหญ่', 'Production', 'อื่นๆ', 1, '/uploads/equipment/143_1772166677819.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งอันใหญ่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:31:17', NULL, NULL, NULL, NULL, NULL, NULL),
(144, 'A144', 'ขาตั้งสีดำอันใหญ่', 'Production', 'อื่นๆ', 1, '/uploads/equipment/144_1772166695477.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งสีดำอันใหญ่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:31:35', NULL, NULL, NULL, NULL, NULL, NULL),
(145, 'A145', 'ขาตั้งสีเทา', 'Production', 'อื่นๆ', 1, '/uploads/equipment/145_1772166704043.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งสีเทา มี 2 อัน', '2026-02-26 16:35:35', '2026-02-27 04:31:44', NULL, NULL, NULL, NULL, NULL, NULL),
(146, 'A146', 'เครื่อง Mix ตัวเล็ก', 'Production', 'เสียง', 1, '/uploads/equipment/146_1772166715378.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เครื่อง Mix ตัวเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:31:55', NULL, NULL, NULL, NULL, NULL, NULL),
(147, 'A147', 'เครื่อง Mix ตัวใหญ่', 'Production', 'เสียง', 1, '/uploads/equipment/147_1772166732066.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เครื่อง Mix ตัวใหญ่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:32:12', NULL, NULL, NULL, NULL, NULL, NULL),
(148, 'A148', 'เครื่อง อัดเสียง ตัวเล็ก', 'Production', 'เสียง', 1, '/uploads/equipment/148_1772166742655.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เครื่อง อัดเสียง ตัวเล็ก 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:32:22', NULL, NULL, NULL, NULL, NULL, NULL),
(149, 'A149', 'เครื่อง อัดเสียง ตัวใหญ่', 'Production', 'เสียง', 1, '/uploads/equipment/149_1772166751241.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เครื่อง อัดเสียง ตัวใหญ่ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:32:31', NULL, NULL, NULL, NULL, NULL, NULL),
(150, 'A150', 'จอ Monitor ตั้งโต็ะ', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/150_1772166760341.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - จอ Monitor ตั้งโต็ะ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:32:40', NULL, NULL, NULL, NULL, NULL, NULL),
(151, 'A151', 'จอ Monitor ผู้กำกับ', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/151_1772166768468.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - จอ Monitor ผู้กำกับ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:32:48', NULL, NULL, NULL, NULL, NULL, NULL),
(152, 'A152', 'จอ TV 32 นิ้ว', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/152_1772166823296.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - จอ TV 32 นิ้ว 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:33:43', NULL, NULL, NULL, NULL, NULL, NULL),
(153, 'A153', 'จอ TV อันเล็ก', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/153_1772166835246.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - จอ TV อันเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:33:55', NULL, NULL, NULL, NULL, NULL, NULL),
(154, 'A154', 'หูฟัง', 'Event', 'เสียง', 9, '/uploads/equipment/154_1772166846375.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หูฟัง 9 อัน', '2026-02-26 16:35:35', '2026-02-27 04:46:46', NULL, NULL, NULL, NULL, NULL, NULL),
(155, 'A155', 'ไฟ ยี่ห้อ UIauzi บานเดอร์', 'Production', 'แสง', 1, '/uploads/equipment/155_1772166906053.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟ ยี่ห้อ UIauzi บานเดอร์ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:35:06', NULL, NULL, NULL, NULL, NULL, NULL),
(156, 'A156', 'ไฟ ยี่ห้อ UIauzi อันเล็ก', 'Production', 'แสง', 1, '/uploads/equipment/156_1772166915197.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟ ยี่ห้อ UIauzi อันเล็ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:35:15', NULL, NULL, NULL, NULL, NULL, NULL),
(157, 'A157', 'ไฟกล่องเขียว', 'Production', 'แสง', 1, '/uploads/equipment/157_1772166922382.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟกล่องเขียว 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:35:22', NULL, NULL, NULL, NULL, NULL, NULL),
(158, 'A158', 'ไฟดาบ', 'Production', 'แสง', 1, '/uploads/equipment/158_1772166935132.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟดาบ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:35:35', NULL, NULL, NULL, NULL, NULL, NULL),
(159, 'A159', 'ไฟดาบ 2', 'Production', 'แสง', 1, '/uploads/equipment/159_1772167029547.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟดาบ 2 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:37:09', NULL, NULL, NULL, NULL, NULL, NULL),
(160, 'A160', 'ไฟไฟAuto เสียบปลั้ก', 'Production', 'แสง', 1, '/uploads/equipment/160_1772167039053.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟไฟAuto เสียบปลั้ก 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:37:19', NULL, NULL, NULL, NULL, NULL, NULL),
(161, 'A161', 'ไฟ Yongnuo ใช้คู่ Soft box ใหม่', 'Production', 'แสง', 1, '/uploads/equipment/161_1772167047024.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟ Yongnuo ใช้คู่ Soft box ใหม่ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:37:27', NULL, NULL, NULL, NULL, NULL, NULL),
(162, 'A162', 'แท่นชาร์จ Monitor', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/162_1772167056069.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แท่นชาร์จ Monitor 3 อัน', '2026-02-26 16:35:35', '2026-02-27 04:37:36', NULL, NULL, NULL, NULL, NULL, NULL),
(163, 'A163', 'ชุดแท่นชาร์จ', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/163_1772167074120.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แท่นชาร์จ พร้อมสาย 10 อัน - หูฟัง 10 อัน - ปลั้กพ่วง 2 อัน', '2026-02-26 16:35:35', '2026-02-27 04:37:54', NULL, NULL, NULL, NULL, NULL, NULL),
(164, 'A164', 'Name Tag', 'Other', 'อื่นๆ', 1, '/uploads/equipment/164_1772167086733.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ป้าย ชื่อ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:38:06', NULL, NULL, NULL, NULL, NULL, NULL),
(165, 'A165', 'กรอบใส่รูป', 'Other', 'อื่นๆ', 1, '/uploads/equipment/165_1772167118646.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กรอบ ใหญ่ 1 อัน - กรอบ เล็ก 7 อัน', '2026-02-26 16:35:35', '2026-02-27 04:38:38', NULL, NULL, NULL, NULL, NULL, NULL),
(166, 'A166', 'จาน', 'Other', 'อื่นๆ', 1, '/uploads/equipment/166_1772167280409.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - จาน 80 อัน', '2026-02-26 16:35:35', '2026-02-27 04:41:20', NULL, NULL, NULL, NULL, NULL, NULL),
(167, 'A167', 'ถ้วย', 'Other', 'อื่นๆ', 1, '/uploads/equipment/167_1772167268959.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถ้วย เล็ก 10 อัน - ถ้วย กลาง 5 อัน', '2026-02-26 16:35:35', '2026-02-27 04:41:08', NULL, NULL, NULL, NULL, NULL, NULL),
(168, 'A168', 'หลอด', 'Other', 'อื่นๆ', 1, '/uploads/equipment/168_1772167325591.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หลอด 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:42:05', NULL, NULL, NULL, NULL, NULL, NULL),
(169, 'A169', 'ถุงกระดาษ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/169_1772167338095.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงกระดาษ 25 ถุง', '2026-02-26 16:35:35', '2026-02-27 04:42:18', NULL, NULL, NULL, NULL, NULL, NULL),
(170, 'A170', 'ถุงขยะ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/170_1772167347952.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงขยะ 1 ม้วน', '2026-02-26 16:35:35', '2026-02-27 04:42:27', NULL, NULL, NULL, NULL, NULL, NULL),
(171, 'A171', 'ถุงซิปล็อค', 'Other', 'อื่นๆ', 1, '/uploads/equipment/171_1772167360910.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงถุงซิปล็อค 2 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:42:40', NULL, NULL, NULL, NULL, NULL, NULL),
(172, 'A172', 'แมส', 'Other', 'อื่นๆ', 1, '/uploads/equipment/172_1772167374979.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แมส 3 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:42:54', NULL, NULL, NULL, NULL, NULL, NULL),
(173, 'A173', 'ธง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/173_1772167394460.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ธง 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:43:14', NULL, NULL, NULL, NULL, NULL, NULL),
(174, 'A174', 'ยาแก้เมารถ', 'Other', 'อื่นๆ', 44, '/uploads/equipment/174_1772167417456.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ยาแก้เมารถ 44 ซอง', '2026-02-26 16:35:35', '2026-02-27 04:46:19', NULL, NULL, NULL, NULL, NULL, NULL),
(175, 'A175', 'หูใส่ตกแต่ง Chirstmas', 'Other', 'อื่นๆ', 1, '/uploads/equipment/175_1772167477245.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หูใส่ตกแต่ง Chirstmas 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:44:37', NULL, NULL, NULL, NULL, NULL, NULL),
(176, 'A176', 'ไฟฉาย', 'Other', 'อื่นๆ', 10, '/uploads/equipment/176_1772167486974.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไฟฉาย พกพา 10 อัน', '2026-02-26 16:35:35', '2026-02-27 04:45:59', NULL, NULL, NULL, NULL, NULL, NULL),
(177, 'A177', 'พาสเตอร์', 'Other', 'อื่นๆ', 20, '/uploads/equipment/177_1772167651538.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - พาสเตอร์ 20 อัน', '2026-02-26 16:35:35', '2026-02-27 04:47:31', NULL, NULL, NULL, NULL, NULL, NULL),
(178, 'A178', 'ฉากกระดาษ', 'Other', 'อื่นๆ', 3, '/uploads/equipment/178_1772167668219.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ฉากกระดาษ 3 ม้วน', '2026-02-26 16:35:35', '2026-02-27 04:48:00', NULL, NULL, NULL, NULL, NULL, NULL),
(179, 'A179', 'ช้อนซ้อม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/179_1772167713007.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ช้อน 80 อัน - ซ้อน 80 อัน', '2026-02-26 16:35:35', '2026-02-27 04:48:33', NULL, NULL, NULL, NULL, NULL, NULL),
(180, 'A180', 'แก้ว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/180_1772167728327.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แก้ว 2 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:48:48', NULL, NULL, NULL, NULL, NULL, NULL),
(181, 'A181', 'ยาแก้ไข้', 'Other', 'อื่นๆ', 1, '/uploads/equipment/181_1772167761288.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไทลินนอล 19 ซอง - น้อกซี่ 7 ซอง', '2026-02-26 16:35:35', '2026-02-27 04:49:21', NULL, NULL, NULL, NULL, NULL, NULL),
(182, 'A182', 'ที่คนกาแฟ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/182_1772167775633.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่คนกาแฟ 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 04:49:35', NULL, NULL, NULL, NULL, NULL, NULL),
(183, 'A183', 'โดรน', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/183_1772167785541.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - โดรน 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 04:49:45', NULL, NULL, NULL, NULL, NULL, NULL),
(184, 'A184', 'แบต NP ก้อนใหม่', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/184_1772167811052.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบต ใหม่ 4 ก้อน', '2026-02-26 16:35:35', '2026-02-27 04:50:11', NULL, NULL, NULL, NULL, NULL, NULL),
(185, 'A185', 'แบต vmont', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/185_1772167827008.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบต 4 ก้อน', '2026-02-26 16:35:35', '2026-02-27 04:50:27', NULL, NULL, NULL, NULL, NULL, NULL),
(186, 'A186', 'ชุดแบต NP', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/186_1772167841977.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบต 4 ก้อน - สาย Type C 4 เส้น - แท่นชาร์จ 1 อัน - สาย 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:50:41', NULL, NULL, NULL, NULL, NULL, NULL),
(187, 'A187', 'แบตใบ้', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/187_1772167851040.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบตใบ้ 2 อัน - แบตใบ้ Canon rp1 1 อัน - แบตใบ้ Canon rp2 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:50:51', NULL, NULL, NULL, NULL, NULL, NULL),
(188, 'A188', 'สาย USB to Micro', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/188_1772167859952.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย USB to Micro 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:50:59', NULL, NULL, NULL, NULL, NULL, NULL),
(189, 'A189', 'สาย Type C to Type C', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/189_1772167866751.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Type C to Type C 3 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:51:06', NULL, NULL, NULL, NULL, NULL, NULL),
(190, 'A190', 'สาย USB To Type C', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/190_1772167875642.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย USB To Type C 19 เส้น', '2026-02-26 16:35:35', '2026-02-27 04:51:15', NULL, NULL, NULL, NULL, NULL, NULL),
(191, 'A191', 'Adapter 120 W', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/191_1772167884040.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Adapter 120 W 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:51:24', NULL, NULL, NULL, NULL, NULL, NULL),
(192, 'A192', 'แท่นชาร์จแบตกล้อง Canon RP', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/192_1772167892051.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบตกล้อง Canon RP 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:51:32', NULL, NULL, NULL, NULL, NULL, NULL),
(193, 'A193', 'แท่นชาร์จแบตกล้อง Canon R6', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/193_1772167901804.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบต ก้อน Canon R6 2 อัน', '2026-02-26 16:35:35', '2026-02-27 04:51:41', NULL, NULL, NULL, NULL, NULL, NULL),
(194, 'A194', 'แท่นชาร์จแบตกล้อง Sony mark 1', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/194_1772167913768.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบต ก้อน Sony mark 1 1 อัน', '2026-02-26 16:35:35', '2026-02-27 04:51:53', NULL, NULL, NULL, NULL, NULL, NULL),
(195, 'A195', 'แท่นชาร์จแบตกล้อง Sony mark 2', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/195_1772167922233.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบต ก้อน Sony mark 2 2 อัน', '2026-02-26 16:35:35', '2026-02-27 04:52:02', NULL, NULL, NULL, NULL, NULL, NULL),
(196, 'A196', 'Intercom ชุดสีเขียว', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/196_1772177126977.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Intercom ชุดสีเขียว 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 07:25:26', NULL, NULL, NULL, NULL, NULL, NULL),
(197, 'A197', 'Intercom ชุดสีส้ม', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/197_1772183067612.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Intercom ชุดสีส้ม 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 09:04:27', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `equipment` (`id`, `code`, `name`, `team`, `category`, `quantity`, `image_path`, `status`, `description`, `created_at`, `updated_at`, `location`, `image_data`, `image_mime`, `purchase_date`, `purchase_price`, `notes`) VALUES
(198, 'A198', 'ขาตั้ง 3 ขา KingJoy', 'Production', 'อื่นๆ', 1, '/uploads/equipment/198_1772183098835.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้ง 3 ขา KingJoy 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 09:04:58', NULL, NULL, NULL, NULL, NULL, NULL),
(199, 'A199', 'Direct Print', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/199_1772183113423.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Direct Print 2 เครื่อง', '2026-02-26 16:35:35', '2026-02-27 09:05:13', NULL, NULL, NULL, NULL, NULL, NULL),
(200, 'A200', 'ฉากสีขาว', 'Event', 'อื่นๆ', 1, '/uploads/equipment/200_1772183134177.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ฉากสีขาว 2 อัน', '2026-02-26 16:35:35', '2026-02-27 09:05:34', NULL, NULL, NULL, NULL, NULL, NULL),
(201, 'A201', 'ถุงขยะ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/201_1772183144829.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงขยะ 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 09:05:44', NULL, NULL, NULL, NULL, NULL, NULL),
(202, 'A202', 'กล้อง Canon RP', 'Production', 'กล้อง', 1, '/uploads/equipment/202_1772171804099.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - กล้อง Canon RP 1 ตัว', '2026-02-26 16:35:35', '2026-02-27 05:56:44', NULL, NULL, NULL, NULL, NULL, NULL),
(203, 'A203', 'กล้อง Canon R6', 'Production', 'กล้อง', 1, '/uploads/equipment/203_1772175908407.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - กล้อง Canon R6 1 ตัว', '2026-02-26 16:35:35', '2026-02-27 07:05:08', NULL, NULL, NULL, NULL, NULL, NULL),
(204, 'A204', 'กล้อง Sony mk1', 'Production', 'กล้อง', 1, '/uploads/equipment/204_1772175922392.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - กล้อง Sony mk1 1 ตัว', '2026-02-26 16:35:35', '2026-02-27 07:05:22', NULL, NULL, NULL, NULL, NULL, NULL),
(205, 'A205', 'กล้อง Sony mk2', 'Production', 'กล้อง', 1, '/uploads/equipment/205_1772175939242.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - กล้อง Sony mk2 สีดำ 1 ตัว - กล้อง Sony mk2 สีขาว 1 ตัว', '2026-02-26 16:35:35', '2026-02-27 07:05:39', NULL, NULL, NULL, NULL, NULL, NULL),
(206, 'A206', 'เลนศ์ Sigma 30 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/206_1772175964850.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Sigma 30 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:06:04', NULL, NULL, NULL, NULL, NULL, NULL),
(207, 'A207', 'เลนศ์ Sigma 18 - 85 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/207_1772175973709.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Sigma 18-85 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:06:13', NULL, NULL, NULL, NULL, NULL, NULL),
(208, 'A208', 'เลนศ์ Sony 35 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/208_1772175986449.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Sony 35 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:06:26', NULL, NULL, NULL, NULL, NULL, NULL),
(209, 'A209', 'เลนศ์ Sigma 24 - 70 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/209_1772176015877.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Sigma 24 - 70 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:06:55', NULL, NULL, NULL, NULL, NULL, NULL),
(210, 'A210', 'เลนศ์ Tamron 70 - 180 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/210_1772179983696.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Tamron 70 - 180 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:13:03', NULL, NULL, NULL, NULL, NULL, NULL),
(211, 'A211', 'เลนศ์ Canon 16 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/211_1772176081704.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด เลนศ์ Canon 16 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:08:01', NULL, NULL, NULL, NULL, NULL, NULL),
(212, 'A212', 'เลนศ์ Canon 85 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/212_1772176104237.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Canon 85 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:08:24', NULL, NULL, NULL, NULL, NULL, NULL),
(213, 'A213', 'เลนศ์ Canon 70 - 200 MM + Mount', 'Production', 'กล้อง', 1, '/uploads/equipment/213_1772176115233.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Canon 70 - 200 MM + Mount 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:08:35', NULL, NULL, NULL, NULL, NULL, NULL),
(214, 'A214', 'เลนศ์ 16 - 50 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/214_1772176124549.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ 16 - 50 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:08:44', NULL, NULL, NULL, NULL, NULL, NULL),
(215, 'A215', 'เลนศ์ 16 - 35 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/215_1772176134214.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ 16 - 35 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:08:54', NULL, NULL, NULL, NULL, NULL, NULL),
(216, 'A216', 'เลนศ์ Samyang 85 MM', 'Production', 'กล้อง', 1, '/uploads/equipment/216_1772176143766.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - เลนศ์ Samyang 85 MM 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:09:03', NULL, NULL, NULL, NULL, NULL, NULL),
(217, 'A217', 'สายคล้องกล้อง', 'Production', 'กล้อง', 1, '/uploads/equipment/217_1772176159000.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - สายคล้องกล้อง 2 เส้น', '2026-02-26 16:35:35', '2026-02-27 07:09:19', NULL, NULL, NULL, NULL, NULL, NULL),
(218, 'A218', 'อุปกรณ์เสริมต่อกับขาตั้ง', 'Production', 'อื่นๆ', 1, '/uploads/equipment/218_1772176172798.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ตัวยึดขากล้อง 2 อัน - ตัวยึดขากล้องสีดำล้วน 4 อัน - อะไหล่ 10 อัน - แท่งจับ 2 อัน', '2026-02-26 16:35:35', '2026-02-27 07:09:32', NULL, NULL, NULL, NULL, NULL, NULL),
(219, 'A219', 'AD/AC Adepter', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/219_1772176188134.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - AD/AC Adepter 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:09:48', NULL, NULL, NULL, NULL, NULL, NULL),
(220, 'A220', 'แผ่นแปะกันรองเท้ากัด', 'Event', 'อื่นๆ', 1, '/uploads/equipment/220_1772176201533.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แผ่นแปะกันรองเท้ากัด 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:10:01', NULL, NULL, NULL, NULL, NULL, NULL),
(221, 'A221', 'สายคล้องกล้อง', 'Event', 'กล้อง', 1, '/uploads/equipment/221_1772176765625.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายคล้องกล้อง 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:19:25', NULL, NULL, NULL, NULL, NULL, NULL),
(222, 'A222', 'ไมค์ติดโทรศัพท์/เดี่ยว Type C', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/222_1772176774458.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไมค์ติดโทรศัพท์/เดี่ยว Type C 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:19:34', NULL, NULL, NULL, NULL, NULL, NULL),
(223, 'A223', 'ไมค์ติดโทรศัพท์/คู่ Lightning', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/223_1772176844703.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไมค์ติดโทรศัพท์/คู่ Lightning 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:20:44', NULL, NULL, NULL, NULL, NULL, NULL),
(224, 'A224', 'ไมค์ติดโทรศัพท์/คู่ Lightning 2', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/224_1772176860223.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไมค์ติดโทรศัพท์/คู่ Lightning2 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:21:00', NULL, NULL, NULL, NULL, NULL, NULL),
(225, 'A225', 'ที่ครอบ intercom', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/225_1772176880289.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่ครอบ intercom 10 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 07:21:20', NULL, NULL, NULL, NULL, NULL, NULL),
(226, 'A226', 'ขาตั้ง', 'Event', 'อื่นๆ', 1, '/uploads/equipment/226_1772177179884.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ขาตั้ง 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:26:19', NULL, NULL, NULL, NULL, NULL, NULL),
(227, 'A227', 'ที่จับโทรศัพท์', 'Event', 'อื่นๆ', 1, '/uploads/equipment/227_1772177192439.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่จับโทรศัพท์ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:26:32', NULL, NULL, NULL, NULL, NULL, NULL),
(228, 'A228', 'Hdmi bi-directional switch', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/228_1772177204814.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hdmi bi-directional switch 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:26:44', NULL, NULL, NULL, NULL, NULL, NULL),
(229, 'A229', 'แท่นชาร์จแบต', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/229_1772177212255.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบต 1 อัน', '2026-02-26 16:35:35', '2026-02-27 07:26:52', NULL, NULL, NULL, NULL, NULL, NULL),
(230, 'A230', 'กระเป๋าโรนิน S4', 'Event', 'อื่นๆ', 1, '/uploads/equipment/230_1772177219254.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าโรนิน S4 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 07:26:59', NULL, NULL, NULL, NULL, NULL, NULL),
(231, 'A231', 'Set กล้อง Fuji xt-10', 'Event', 'กล้อง', 1, '/uploads/equipment/231_1772177227640.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋า 1 ใบ - เลนส์23 1 อัน - แท่นชาร์จ 1 อัน - สายชาร์จ 2 เส้น - แบต 5 ก้อน - SD Card 3 อัน - สาย Hdmi 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 07:27:07', NULL, NULL, NULL, NULL, NULL, NULL),
(232, 'A232', 'วอสีดำ', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/232_1772177237089.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - วอสีดำ 8 อัน', '2026-02-26 16:35:35', '2026-02-27 07:27:17', NULL, NULL, NULL, NULL, NULL, NULL),
(233, 'A233', 'จอ Projector', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/233_1772177864718.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - จอ Projector 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 07:37:44', NULL, NULL, NULL, NULL, NULL, NULL),
(234, 'A234', 'กระเป๋าสีดำ1', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/234_1772179680841.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:08:00', NULL, NULL, NULL, NULL, NULL, NULL),
(235, 'A235', 'Hand Strap', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/235_1772179692573.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hand Strap 2 ชิ้น', '2026-02-26 16:35:35', '2026-02-27 08:08:12', NULL, NULL, NULL, NULL, NULL, NULL),
(236, 'A236', 'Lavalier', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/236_1772179702814.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Lavalier 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:08:22', NULL, NULL, NULL, NULL, NULL, NULL),
(237, 'A237', 'นาฬิกา garmin', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/237_1772179713610.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - นาฬิกา garmin 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:08:33', NULL, NULL, NULL, NULL, NULL, NULL),
(238, 'A238', 'Multi-Function', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/238_1772179723822.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Multi-Function 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:08:43', NULL, NULL, NULL, NULL, NULL, NULL),
(239, 'A239', 'หูฟัง Sing Karaoke headset', 'Event', 'เสียง', 1, '/uploads/equipment/239_1772179745059.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หูฟัง Sing Karaoke headset 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:09:05', NULL, NULL, NULL, NULL, NULL, NULL),
(240, 'A240', 'Flash Drive HP', 'Event', 'อื่นๆ', 1, '/uploads/equipment/240_1772179759233.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Flash Drive HP 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:09:19', NULL, NULL, NULL, NULL, NULL, NULL),
(241, 'A241', 'Hand free shoulder pad', 'Event', 'อื่นๆ', 1, '/uploads/equipment/241_1772179766592.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hand free shoulder pad 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:09:26', NULL, NULL, NULL, NULL, NULL, NULL),
(242, 'A242', 'Mono pad', 'Event', 'อื่นๆ', 1, '/uploads/equipment/242_1772179806626.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Mono pad 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:10:06', NULL, NULL, NULL, NULL, NULL, NULL),
(243, 'A243', 'กระเป๋าใส่เลนส์', 'Event', 'อื่นๆ', 1, '/uploads/equipment/243_1772179819207.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าใส่เลนส์ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:10:19', NULL, NULL, NULL, NULL, NULL, NULL),
(244, 'A244', 'ที่แขวนราว', 'Event', 'อื่นๆ', 1, '/uploads/equipment/244_1772179829985.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่แขวนราว 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:10:29', NULL, NULL, NULL, NULL, NULL, NULL),
(245, 'A245', 'แท่นชาร์จแบตMaxเทียบ', 'Event', 'อื่นๆ', 1, '/uploads/equipment/245_1772179841280.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นชาร์จแบตMaxเทียบ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:10:41', NULL, NULL, NULL, NULL, NULL, NULL),
(246, 'A246', 'เมาศ์ Microsoft', 'Event', 'อื่นๆ', 1, '/uploads/equipment/246_1772179849308.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เมาศ์ Microsoft 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:10:49', NULL, NULL, NULL, NULL, NULL, NULL),
(247, 'A247', 'เมาศ์ JIB', 'Event', 'อื่นๆ', 1, '/uploads/equipment/247_1772179858753.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เมาศ์ JIB 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:10:58', NULL, NULL, NULL, NULL, NULL, NULL),
(248, 'A248', 'เมาศ์ Microsoft แบน', 'Event', 'อื่นๆ', 1, '/uploads/equipment/248_1772179878602.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เมาศ์ Microsoft แบน 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:11:18', NULL, NULL, NULL, NULL, NULL, NULL),
(249, 'A249', 'เมาศ์ Nuewo', 'Event', 'อื่นๆ', 1, '/uploads/equipment/249_1772179888053.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เมาศ์ Nuewo 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:11:28', NULL, NULL, NULL, NULL, NULL, NULL),
(250, 'A250', 'ลำโพง Sony ฟ้า', 'Event', 'เสียง', 1, '/uploads/equipment/250_1772179895854.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ลำโพง Sony ฟ้า 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:11:35', NULL, NULL, NULL, NULL, NULL, NULL),
(251, 'A251', 'เครื่องอัดเสียง', 'Event', 'เสียง', 1, '/uploads/equipment/251_1772179903613.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เครื่องอัดเสียง 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:11:43', NULL, NULL, NULL, NULL, NULL, NULL),
(252, 'A252', 'ไฟ USB', 'Event', 'อื่นๆ', 1, '/uploads/equipment/252_1772179911984.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไฟ USB 2 อัน', '2026-02-26 16:35:35', '2026-02-27 08:11:51', NULL, NULL, NULL, NULL, NULL, NULL),
(253, 'A253', 'แท่นวางโทรศัพท์ Magnet', 'Event', 'กล้อง', 1, '/uploads/equipment/253_1772179923366.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แท่นวางโทรศัพท์ Magnet 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:12:03', NULL, NULL, NULL, NULL, NULL, NULL),
(254, 'A254', 'กล้อง Gropo', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/254_1772179930407.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กล้อง Gropo 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:12:10', NULL, NULL, NULL, NULL, NULL, NULL),
(255, 'A255', 'หัวปลั้กหัวแบน USB', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/255_1772179939102.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หัวปลั้กหัวแบน USB 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:12:19', NULL, NULL, NULL, NULL, NULL, NULL),
(256, 'A256', 'สาย USB to Micro', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/256_1772179947159.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย USB to Micro 3 เส้น', '2026-02-26 16:35:35', '2026-02-27 08:12:27', NULL, NULL, NULL, NULL, NULL, NULL),
(257, 'A257', 'แบต Canon rp เทียบ', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/257_1772180165862.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แบต Canon rp เทียบ 2 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:05', NULL, NULL, NULL, NULL, NULL, NULL),
(258, 'A258', 'Slate อันใหญ่', 'Production', 'อื่นๆ', 1, '/uploads/equipment/258_1772180172935.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Slate อันใหญ่ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:12', NULL, NULL, NULL, NULL, NULL, NULL),
(259, 'A259', 'head กันแสง', 'Production', 'กล้อง', 1, '/uploads/equipment/259_1772180178672.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - head กันแสง 6 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:18', NULL, NULL, NULL, NULL, NULL, NULL),
(260, 'A260', 'ฝากล้อง', 'Production', 'กล้อง', 1, '/uploads/equipment/260_1772180187250.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฝากล้อง 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:27', NULL, NULL, NULL, NULL, NULL, NULL),
(261, 'A261', 'ฝาปิดเลนส์', 'Production', 'กล้อง', 1, '/uploads/equipment/261_1772180195813.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฝาปิดเลนส์ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:35', NULL, NULL, NULL, NULL, NULL, NULL),
(262, 'A262', 'Small rig', 'Production', 'กล้อง', 1, '/uploads/equipment/262_1772180209164.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Small rig 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:49', NULL, NULL, NULL, NULL, NULL, NULL),
(263, 'A263', 'ฉาก อคิลิค ขาว ล้วน', 'Production', 'อื่นๆ', 1, '/uploads/equipment/263_1772180218030.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฉาก อคิลิค ขาว ล้วน 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:16:58', NULL, NULL, NULL, NULL, NULL, NULL),
(264, 'A264', 'ฉาก อคิลิค ดำ ล้วน', 'Production', 'อื่นๆ', 1, '/uploads/equipment/264_1772180225534.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฉาก อคิลิค ดำ ล้วน 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:17:05', NULL, NULL, NULL, NULL, NULL, NULL),
(265, 'A265', 'ฉากไม้อัด', 'Production', 'อื่นๆ', 1, '/uploads/equipment/265_1772180241017.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฉากไม้อัด 3 อัน', '2026-02-26 16:35:35', '2026-02-27 08:17:21', NULL, NULL, NULL, NULL, NULL, NULL),
(266, 'A266', 'ฐานตั้ง เล็ก', 'Production', 'อื่นๆ', 1, '/uploads/equipment/266_1772180248931.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฐานตั้ง เล็ก 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:17:28', NULL, NULL, NULL, NULL, NULL, NULL),
(267, 'A267', 'ฐานตั้ง ใหญ่', 'Production', 'อื่นๆ', 1, '/uploads/equipment/267_1772180282076.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ฐานตั้ง ใหญ่ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:18:02', NULL, NULL, NULL, NULL, NULL, NULL),
(268, 'A268', 'ขาตั้งสีดำแดง อันเล็ก', 'Production', 'อื่นๆ', 1, '/uploads/equipment/268_1772180290865.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาตั้งสีดำแดง อันเล็ก 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:18:10', NULL, NULL, NULL, NULL, NULL, NULL),
(269, 'A269', 'Splitter HDTV 4K x 2K', 'Production', 'ไฟฟ้า', 1, '/uploads/equipment/269_1772180298590.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - Splitter HDTV 4K x 2K 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:18:18', NULL, NULL, NULL, NULL, NULL, NULL),
(270, 'A270', 'ไมค์ไกด์', 'Production', 'เสียง', 1, '/uploads/equipment/270_1772180316098.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไมค์ไกด์ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:18:36', NULL, NULL, NULL, NULL, NULL, NULL),
(271, 'A271', 'ไฟติดหัวกล้อง', 'Production', 'แสง', 1, '/uploads/equipment/271_1772180323374.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ไฟติดหัวกล้อง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:18:43', NULL, NULL, NULL, NULL, NULL, NULL),
(272, 'A272', 'ขาจับโทรศัพท์', 'Production', 'อื่นๆ', 1, '/uploads/equipment/272_1772180330211.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ขาจับโทรศัพท์ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:18:50', NULL, NULL, NULL, NULL, NULL, NULL),
(273, 'A273', 'แม่เหล็กติดไมค์', 'Production', 'อื่นๆ', 1, '/uploads/equipment/273_1772180337846.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - แม่เหล็กติดไมค์ DJI 1 ชุด - แม่เหล็กติดไมค์ Hollyland 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:18:57', NULL, NULL, NULL, NULL, NULL, NULL),
(274, 'A274', 'หัวบอล ขาตั้งกล้อง สีดำทอง', 'Production', 'อื่นๆ', 1, '/uploads/equipment/274_1772180345922.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - หัวบอล ขาตั้งกล้อง สีดำทอง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:19:05', NULL, NULL, NULL, NULL, NULL, NULL),
(275, 'A275', 'หัวบอล ขาตั้งกล้อง สีดำส้ม', 'Production', 'อื่นๆ', 1, '/uploads/equipment/275_1772180352015.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - หัวบอล ขาตั้งกล้อง สีดำส้ม 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:19:12', NULL, NULL, NULL, NULL, NULL, NULL),
(276, 'A276', 'ชุด โรนิน ใช้กับโทรศัพท์', 'Production', 'กล้อง', 1, '/uploads/equipment/276_1772180359123.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด - ชุด โรนิน ใช้กับโทรศัพท์ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:19:19', NULL, NULL, NULL, NULL, NULL, NULL),
(277, 'A277', 'สาย Type C to Type C', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/277_1772180372515.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สาย Type C to Type C 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 08:19:32', NULL, NULL, NULL, NULL, NULL, NULL),
(278, 'A278', 'Clicker', 'Event', 'อื่นๆ', 1, '/uploads/equipment/278_1772180380064.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Clicker 2 อัน', '2026-02-26 16:35:35', '2026-02-27 08:19:40', NULL, NULL, NULL, NULL, NULL, NULL),
(279, 'A279', 'แฟลชไดฟ์ Karaoke', 'Event', 'อื่นๆ', 1, '/uploads/equipment/279_1772180386077.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แฟลชไดฟ์ Karaoke 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:19:46', NULL, NULL, NULL, NULL, NULL, NULL),
(280, 'A280', 'ลำโพง T&G', 'Event', 'เสียง', 1, '/uploads/equipment/280_1772180396015.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ลำโพง T&G 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:19:56', NULL, NULL, NULL, NULL, NULL, NULL),
(281, 'A281', 'Mini Laser Distance Meter', 'Event', 'อื่นๆ', 1, '/uploads/equipment/281_1772180404669.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Mini Laser Distance Meter 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:20:04', NULL, NULL, NULL, NULL, NULL, NULL),
(282, 'A282', 'Filter ring Adapter', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/282_1772180417302.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Filter ring Adapter 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:20:17', NULL, NULL, NULL, NULL, NULL, NULL),
(283, 'A283', 'Filter ring Adapter K&F Concept', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/283_1772180427991.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Filter ring Adapter K&F Concept 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:20:27', NULL, NULL, NULL, NULL, NULL, NULL),
(284, 'A284', 'อุปกรณ์ของ Ulanzi', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/284_1772180438717.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - อุปกรณ์ของ Ulanzi 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:20:38', NULL, NULL, NULL, NULL, NULL, NULL),
(285, 'A285', 'ตัวปล่อย Wifi 4G / 5G', 'Event', 'อื่นๆ', 1, '/uploads/equipment/285_1772180449162.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวปล่อย Wifi 4G / 5G 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:20:49', NULL, NULL, NULL, NULL, NULL, NULL),
(286, 'A286', 'แฟลชไดฟ์ไฟ', 'Event', 'อื่นๆ', 1, '/uploads/equipment/286_1772180457553.jpg', 'ชำรุด', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แฟลชไดฟ์ไฟ 1 อัน (ชำรุด)', '2026-02-26 16:35:35', '2026-02-27 08:20:57', NULL, NULL, NULL, NULL, NULL, NULL),
(287, 'A287', 'ที่จับ I Pad', 'Event', 'อื่นๆ', 1, '/uploads/equipment/287_1772180478515.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่จับ I Pad 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:21:18', NULL, NULL, NULL, NULL, NULL, NULL),
(288, 'A288', 'อุปกรณ์เสริมของไมค์ ยี่ห้อ Lavalier', 'Event', 'ไฟฟ้า', 2, '/uploads/equipment/288_1772180491420.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - อุปกรณ์เสริมของไมค์ ยี่ห้อ Lavalier 2 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:21:31', NULL, NULL, NULL, NULL, NULL, NULL),
(289, 'A289', 'สายแปลง Hdmi Asus', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/289_1772180500799.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สายแปลง Hdmi Asus 1 เส้น', '2026-02-26 16:35:35', '2026-02-27 08:21:40', NULL, NULL, NULL, NULL, NULL, NULL),
(290, 'A290', 'กล้องต่อ Notebook', 'Event', 'กล้อง', 1, '/uploads/equipment/290_1772180508278.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กล้องต่อ Notebook 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:21:48', NULL, NULL, NULL, NULL, NULL, NULL),
(291, 'A291', 'ตัวแปลง Hdmi', 'Event', 'อื่นๆ', 1, '/uploads/equipment/291_1772180516520.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลง Lightning to Hdmi 1 อัน - สายแปลง Type C 2 อัน - ตัวแปลง Jack3.5 to Lightning 1 อัน - ตัวแปลง Lightning to Card 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:21:56', NULL, NULL, NULL, NULL, NULL, NULL),
(292, 'A292', 'ปากกา Notebook', 'Event', 'อื่นๆ', 1, '/uploads/equipment/292_1772180525053.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ปากกา Notebook 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:22:05', NULL, NULL, NULL, NULL, NULL, NULL),
(293, 'A293', 'Card Reader', 'Event', 'อื่นๆ', 1, '/uploads/equipment/293_1772180540993.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Card Reader 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:22:20', NULL, NULL, NULL, NULL, NULL, NULL),
(294, 'A294', 'จอต่อ Notebook ยี่ห้อ OFIYAA', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/294_1772180547020.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - จอต่อ Notebook ยี่ห้อ OFIYAA 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:22:27', NULL, NULL, NULL, NULL, NULL, NULL),
(295, 'A295', 'กระดาษ A3', 'Other', 'อื่นๆ', 1, '/uploads/equipment/295_1772180558143.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระดาษ A3 1 แพ็ค - กระดาษ A3 ป่าวๆ อีก 9 แผ่น', '2026-02-26 16:35:35', '2026-02-27 08:22:38', NULL, NULL, NULL, NULL, NULL, NULL),
(296, 'A296', 'สีอคิลิค', 'Other', 'อื่นๆ', 1, '/uploads/equipment/296_1772180569467.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สีอคิลิค 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:22:49', NULL, NULL, NULL, NULL, NULL, NULL),
(297, 'A297', 'ไพ่', 'Other', 'อื่นๆ', 1, '/uploads/equipment/297_1772180581785.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไพ่ 1 สำหรับ', '2026-02-26 16:35:35', '2026-02-27 08:23:01', NULL, NULL, NULL, NULL, NULL, NULL),
(298, 'A298', 'นามบัตร บริษัท', 'Other', 'อื่นๆ', 1, '/uploads/equipment/298_1772180592793.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - นามบัตร บริษัท 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:23:12', NULL, NULL, NULL, NULL, NULL, NULL),
(299, 'A299', 'ขวดโหล', 'Other', 'อื่นๆ', 9, '/uploads/equipment/299_1772180606829.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ขวดโหล 9 อัน', '2026-02-26 16:35:35', '2026-02-27 08:23:26', NULL, NULL, NULL, NULL, NULL, NULL),
(300, 'A300', 'ลุกปิงปอง', 'Other', 'อื่นๆ', 9, '/uploads/equipment/300_1772180625306.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ลุกปิงปอง 9 ลูก', '2026-02-26 16:35:35', '2026-02-27 08:23:45', NULL, NULL, NULL, NULL, NULL, NULL),
(301, 'A301', 'ลูกโป่ง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/301_1772180635961.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ลูกโป่ง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:23:55', NULL, NULL, NULL, NULL, NULL, NULL),
(302, 'A302', 'ที่ตักไข่', 'Other', 'อื่นๆ', 3, '/uploads/equipment/302_1772180963539.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่ตักไข่ 3 อัน', '2026-02-26 16:35:35', '2026-02-27 08:29:23', NULL, NULL, NULL, NULL, NULL, NULL),
(303, 'A303', 'แก้ว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/303_1772180974356.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แก้ว 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:29:34', NULL, NULL, NULL, NULL, NULL, NULL),
(304, 'A304', 'ตู้ATMของเล่น', 'Other', 'อื่นๆ', 4, '/uploads/equipment/304_1772180985536.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตู้ATMของเล่น 4 อัน', '2026-02-26 16:35:35', '2026-02-27 08:29:54', NULL, NULL, NULL, NULL, NULL, NULL),
(305, 'A305', 'เชือกฟาง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/305_1772181013725.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เชือกฟาง สีน้ำเงิน 1 แพ็ค - เชือกฟาง สีแดง 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:30:13', NULL, NULL, NULL, NULL, NULL, NULL),
(306, 'A306', 'เชือก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/306_1772181021249.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เชือก สีน้ำตาล 2 แพ็ค - เชือก สีเขียว 1 แพ็ค - เชือก สีขาว 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:30:21', NULL, NULL, NULL, NULL, NULL, NULL),
(307, 'A307', 'ป้ายปกใสอันเล็ก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/307_1772181195261.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ป้ายปกใสอันเล็ก 1 อัน - ป้ายปกใสอันเล็ก + สายห้อยสีเทา 10 อัน - ป้ายปกใสอันเล็ก + สายห้อยสีน้ำเงิน 3 อัน - ป้ายปกใสอันเล็ก + สายห้อยสีเหลือง 3 อัน - ป้ายปกใสอันเล็ก + สายห้อยสีแดง 3 อัน', '2026-02-26 16:35:35', '2026-02-27 08:33:15', NULL, NULL, NULL, NULL, NULL, NULL),
(308, 'A308', 'เต้นเปลี่ยนเสื้อผ้า', 'Other', 'อื่นๆ', 1, '/uploads/equipment/308_1772181133957.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เต้นเปลี่ยนเสื้อผ้า 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:32:13', NULL, NULL, NULL, NULL, NULL, NULL),
(309, 'A309', 'กระเป๋า Universal', 'Other', 'อื่นๆ', 1, '/uploads/equipment/309_1772181152475.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:32:32', NULL, NULL, NULL, NULL, NULL, NULL),
(310, 'A310', 'กระเป๋า INDEPMAN', 'Other', 'อื่นๆ', 1, '/uploads/equipment/310_1772181159269.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:32:39', NULL, NULL, NULL, NULL, NULL, NULL),
(311, 'A311', 'กระเป๋า Snigjat', 'Other', 'อื่นๆ', 1, '/uploads/equipment/311_1772181170353.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทาอ่อน 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:32:50', NULL, NULL, NULL, NULL, NULL, NULL),
(312, 'A312', 'กระเป๋า Lowepro', 'Other', 'อื่นๆ', 1, '/uploads/equipment/312_1772181240258.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทาเข้ม 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:00', NULL, NULL, NULL, NULL, NULL, NULL),
(313, 'A313', 'กระเป๋าสี่เหลี่ยม A', 'Other', 'อื่นๆ', 1, '/uploads/equipment/313_1772181247973.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:07', NULL, NULL, NULL, NULL, NULL, NULL),
(314, 'A314', 'กระเป๋าดำ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/314_1772181255162.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:15', NULL, NULL, NULL, NULL, NULL, NULL),
(315, 'A315', 'กระเป๋า CADEN', 'Other', 'อื่นๆ', 1, '/uploads/equipment/315_1772181262924.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทาเข้ม 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:22', NULL, NULL, NULL, NULL, NULL, NULL),
(316, 'A316', 'กระเป๋า BOONA', 'Other', 'อื่นๆ', 1, '/uploads/equipment/316_1772181272220.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:32', NULL, NULL, NULL, NULL, NULL, NULL),
(317, 'A317', 'กระเป๋าคาดเอว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/317_1772181284566.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทา 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:44', NULL, NULL, NULL, NULL, NULL, NULL),
(318, 'A318', 'กระเป๋าดำคาดเอว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/318_1772181293144.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:34:53', NULL, NULL, NULL, NULL, NULL, NULL),
(319, 'A319', 'กระเป๋า YASCIQ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/319_1772181321722.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:35:21', NULL, NULL, NULL, NULL, NULL, NULL),
(320, 'A320', 'กระเป๋าเทาอ่อน', 'Other', 'อื่นๆ', 1, '/uploads/equipment/320_1772181330785.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น', '2026-02-26 16:35:35', '2026-02-27 08:35:30', NULL, NULL, NULL, NULL, NULL, NULL),
(321, 'A321', 'กระเป๋าดำขาว', 'Other', 'อื่นๆ', 1, '/uploads/equipment/321_1772181340881.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:35:40', NULL, NULL, NULL, NULL, NULL, NULL),
(322, 'A322', 'กระเป๋าครีม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/322_1772181348790.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีครีม 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:35:48', NULL, NULL, NULL, NULL, NULL, NULL),
(323, 'A323', 'กระเป๋า UGREEN', 'Other', 'อื่นๆ', 1, '/uploads/equipment/323_1772181356847.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทา 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:35:56', NULL, NULL, NULL, NULL, NULL, NULL),
(324, 'A324', 'กระเป๋า BOONA เล็ก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/324_1772181371368.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทา 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:36:11', NULL, NULL, NULL, NULL, NULL, NULL),
(325, 'A325', 'กระเป๋ากล้อง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/325_1772181382537.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีเทาเข้ม 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:36:22', NULL, NULL, NULL, NULL, NULL, NULL),
(326, 'A326', 'กระเป๋าดำ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/326_1772181391463.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:36:31', NULL, NULL, NULL, NULL, NULL, NULL),
(327, 'A327', 'กระเป๋าดำแข็ง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/327_1772181400496.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ Size เล็ก 1 ใบ - กระเป๋าสีดำ Size กลาง 1 ใบ - กระเป๋าสีดำ Size ใหญ่ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:36:40', NULL, NULL, NULL, NULL, NULL, NULL),
(328, 'A328', 'กระเป๋าหลากสี', 'Other', 'อื่นๆ', 1, '/uploads/equipment/328_1772181417388.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าหลากสี 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:36:57', NULL, NULL, NULL, NULL, NULL, NULL),
(329, 'A329', 'กระเป๋าดำสีเหลี่ยม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/329_1772181429866.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระเป๋าสีดำ 1 ใบ', '2026-02-26 16:35:35', '2026-02-27 08:37:09', NULL, NULL, NULL, NULL, NULL, NULL),
(330, 'A330', 'คีมช่าง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/330_1772181441123.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คีมเล็ก 1 อัน - คีมใหญ่ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:37:21', NULL, NULL, NULL, NULL, NULL, NULL),
(331, 'A331', 'ถุงมือพลาสติกใส', 'Other', 'อื่นๆ', 1, '/uploads/equipment/331_1772181453659.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงมือพลาสติกใส 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:37:33', NULL, NULL, NULL, NULL, NULL, NULL),
(332, 'A332', 'ยางลบ', 'Other', 'อื่นๆ', 6, '/uploads/equipment/332_1772181473364.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ยางลบ 6 อัน', '2026-02-26 16:35:35', '2026-02-27 08:37:53', NULL, NULL, NULL, NULL, NULL, NULL),
(333, 'A333', 'กาว', 'Other', 'อื่นๆ', 8, '/uploads/equipment/333_1772181484440.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กาว 8 แท่ง', '2026-02-26 16:35:35', '2026-02-27 08:38:04', NULL, NULL, NULL, NULL, NULL, NULL),
(334, 'A334', 'หมึกเครื่องปริ้น', 'Other', 'อื่นๆ', 1, '/uploads/equipment/334_1772181499047.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - หมึกเครื่องปริ้นสีดำ 1 อัน - หมึกเครื่องปริ้นสีเหลือง 1 อัน - หมึกเครื่องปริ้นสีชมพู 1 อัน - หมึกเครื่องปริ้นสีฟ้า 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:38:19', NULL, NULL, NULL, NULL, NULL, NULL),
(335, 'A335', 'ถังน้ำแข็ง + ที่ คีบ', 'Other', 'อื่นๆ', 4, '/uploads/equipment/335_1772181513294.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถังน้ำแข็ง + ที่ คีบ 4 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:38:33', NULL, NULL, NULL, NULL, NULL, NULL),
(336, 'A336', 'คลิปบอร์ด พิธีกร', 'Other', 'อื่นๆ', 1, '/uploads/equipment/336_1772181526953.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คลิปบอร์ด พิธีกร 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:38:46', NULL, NULL, NULL, NULL, NULL, NULL),
(337, 'A337', 'คลิปบอร์ด รอง A4', 'Other', 'อื่นๆ', 1, '/uploads/equipment/337_1772181545318.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คลิปบอร์ด รอง A4 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:39:05', NULL, NULL, NULL, NULL, NULL, NULL),
(338, 'A338', 'แผ่น Prop', 'Other', 'อื่นๆ', 1, '/uploads/equipment/338_1772181563544.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แผ่น Prop 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:39:23', NULL, NULL, NULL, NULL, NULL, NULL),
(339, 'A339', 'ถ่านก้อน', 'Other', 'อื่นๆ', 1, '/uploads/equipment/339_1772181573122.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถ่านก้อน 2A 14 ก้อน - ถ่านก้อน 3A 2 ก้อน - ถ่านก้อน 1.5 W ขนาด D 1 ก้อน - ถ่านก้อน 1.5 W ขนาด C 8 ก้อน', '2026-02-26 16:35:35', '2026-02-27 08:39:33', NULL, NULL, NULL, NULL, NULL, NULL),
(340, 'A340', 'น็อตกับอะไหล่', 'Other', 'อื่นๆ', 2, '/uploads/equipment/340_1772181586279.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - น็อต 2 แพ็ค - อะไหล่ 3 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:39:46', NULL, NULL, NULL, NULL, NULL, NULL),
(341, 'A341', 'ชุดอุปกรณ์ช่าง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/341_1772181593959.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ชุดอุปกรณ์ช่าง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:39:53', NULL, NULL, NULL, NULL, NULL, NULL),
(342, 'A342', 'ชุดไขควงเล็ก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/342_1772181605365.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ชุดไขควงเล็ก 2 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:40:05', NULL, NULL, NULL, NULL, NULL, NULL),
(343, 'A343', 'อะไหล่โต๊ะ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/343_1772181642384.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - อะไหล่โต๊ะ พี่นุ้ย 1 ชุด - อะไหล่โต๊ะ พี่ดามพ์ 1 ชุด - อะไหล่โต๊ะ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:40:42', NULL, NULL, NULL, NULL, NULL, NULL),
(344, 'A344', 'ตัวยิงบอร์ด', 'Other', 'อื่นๆ', 1, '/uploads/equipment/344_1772181651767.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวยิงบอร์ด 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:40:51', NULL, NULL, NULL, NULL, NULL, NULL),
(345, 'A345', 'ตีนตุ๊กแก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/345_1772181662833.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตีนตุ๊กแก 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:41:02', NULL, NULL, NULL, NULL, NULL, NULL),
(346, 'A346', 'เครื่องเคลือบบัตร', 'Other', 'อื่นๆ', 1, '/uploads/equipment/346_1772181675640.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เครื่องเคลือบบัตร 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:41:15', NULL, NULL, NULL, NULL, NULL, NULL),
(347, 'A347', 'กระดูกงูเก็บสายไฟ', 'Other', 'อื่นๆ', 2, '/uploads/equipment/347_1772181684331.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระดูกงูเก็บสายไฟ 2 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:41:24', NULL, NULL, NULL, NULL, NULL, NULL),
(348, 'A348', 'สีไม้', 'Other', 'อื่นๆ', 8, '/uploads/equipment/348_1772181695640.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สีไม้ 8 กล่อง', '2026-02-26 16:35:35', '2026-02-27 08:41:35', NULL, NULL, NULL, NULL, NULL, NULL),
(349, 'A349', 'เครื่องพ่นน้ำหอม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/349_1772181711405.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - เครื่องพ่นน้ำหอม 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:41:51', NULL, NULL, NULL, NULL, NULL, NULL),
(350, 'A350', 'ป้ายใช้ในงาน event', 'Other', 'อื่นๆ', 1, '/uploads/equipment/350_1772181720114.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ป้ายใช้ในงาน event 4 อัน', '2026-02-26 16:35:35', '2026-02-27 08:42:00', NULL, NULL, NULL, NULL, NULL, NULL),
(351, 'A351', 'ซองจดหมาย', 'Other', 'อื่นๆ', 1, '/uploads/equipment/351_1772181727639.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ซองจดหมาย 450 ซอง', '2026-02-26 16:35:35', '2026-02-27 08:42:07', NULL, NULL, NULL, NULL, NULL, NULL),
(352, 'A352', 'กระดานรองวาด', 'Other', 'อื่นๆ', 1, '/uploads/equipment/352_1772181737265.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระดานรองวาด 6 อัน', '2026-02-26 16:35:35', '2026-02-27 08:42:17', NULL, NULL, NULL, NULL, NULL, NULL),
(353, 'A353', 'แปรงผู้กัน', 'Other', 'อื่นๆ', 1, '/uploads/equipment/353_1772181744822.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ผู้กัน 7 อัน - แปรงทาสี 6 อัน', '2026-02-26 16:35:35', '2026-02-27 08:42:24', NULL, NULL, NULL, NULL, NULL, NULL),
(354, 'A354', 'กรรไกร', 'Other', 'อื่นๆ', 7, '/uploads/equipment/354_1772181759379.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กรรไกร 7 อัน', '2026-02-26 16:35:35', '2026-02-27 08:42:39', NULL, NULL, NULL, NULL, NULL, NULL),
(355, 'A355', 'ริบบิ้น', 'Other', 'อื่นๆ', 3, '/uploads/equipment/355_1772181775458.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ริบบิ้น 3 อัน', '2026-02-26 16:35:35', '2026-02-27 08:42:55', NULL, NULL, NULL, NULL, NULL, NULL),
(356, 'A356', 'ไม้บรรทัด', 'Other', 'อื่นๆ', 9, '/uploads/equipment/356_1772181797105.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไม้บรรทัด 9 อัน', '2026-02-26 16:35:35', '2026-02-27 08:43:17', NULL, NULL, NULL, NULL, NULL, NULL),
(357, 'A357', 'กระดาษพับนก', 'Other', 'อื่นๆ', 7, '/uploads/equipment/357_1772181890167.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - กระดาษพับนก 7 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:44:50', NULL, NULL, NULL, NULL, NULL, NULL),
(358, 'A358', 'กระดาษ Flying Color A4', 'Other', 'อื่นๆ', 1, '/uploads/equipment/358_1772181899953.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -กระดาษ Flying Color A4 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:44:59', NULL, NULL, NULL, NULL, NULL, NULL),
(359, 'A359', 'กระดาษร้อยปอนด์ A4', 'Other', 'อื่นๆ', 2, '/uploads/equipment/359_1772181923921.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -กระดาษ Flying Color A4 2 ชุด 100 แผ่น', '2026-02-26 16:35:35', '2026-02-27 08:45:23', NULL, NULL, NULL, NULL, NULL, NULL),
(360, 'A360', 'แผ่นปกใส', 'Other', 'อื่นๆ', 1, '/uploads/equipment/360_1772181933716.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แผ่นปกใส 1 แพ็ค', '2026-02-26 16:35:35', '2026-02-27 08:45:33', NULL, NULL, NULL, NULL, NULL, NULL),
(361, 'A361', 'Magazine', 'Other', 'อื่นๆ', 11, '/uploads/equipment/361_1772181945019.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Magazine 11 เล่ม', '2026-02-26 16:35:35', '2026-02-27 08:45:45', NULL, NULL, NULL, NULL, NULL, NULL),
(362, 'A362', 'สติกเกอร์ THANK YOU', 'Other', 'อื่นๆ', 1, '/uploads/equipment/362_1772181956477.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - สติกเกอร์ 1 ม้วน', '2026-02-26 16:35:35', '2026-02-27 08:45:56', NULL, NULL, NULL, NULL, NULL, NULL),
(363, 'A363', 'คลิปหนีบ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/363_1772181966179.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คลิปหนีบ 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:46:06', NULL, NULL, NULL, NULL, NULL, NULL),
(364, 'A364', 'ไก่ของเล่น', 'Other', 'อื่นๆ', 1, '/uploads/equipment/364_1772181974518.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ไก่ของเล่น 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:46:14', NULL, NULL, NULL, NULL, NULL, NULL),
(365, 'A365', 'ถุงเท้ารองวิ่ง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/365_1772181991340.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ถุงเท้ารองวิ่ง 1 คู่', '2026-02-26 16:35:35', '2026-02-27 08:46:31', NULL, NULL, NULL, NULL, NULL, NULL),
(366, 'A366', 'แม็ก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/366_1772182009276.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ลูก แม็ก 1อัน - ตัวแม็ก 2อัน', '2026-02-26 16:35:35', '2026-02-27 08:46:49', NULL, NULL, NULL, NULL, NULL, NULL),
(367, 'A367', 'รถเข็น อันใหญ่', 'Other', 'อื่นๆ', 1, '/uploads/equipment/367_1772182021771.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - รถเข็น อันใหญ่ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:47:01', NULL, NULL, NULL, NULL, NULL, NULL),
(368, 'A368', 'รถเข็น อันเล็ก', 'Other', 'อื่นๆ', 1, '/uploads/equipment/368_1772182031119.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - รถเข็น อันเล็ก 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:47:11', NULL, NULL, NULL, NULL, NULL, NULL),
(369, 'A369', 'แชมเปญ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/369_1772182053509.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แชมเปญ ขวดใหญ่ 1 ขวด - แชมเปญ ขวดเล็ก 1 ขวด', '2026-02-26 16:35:35', '2026-02-27 08:47:33', NULL, NULL, NULL, NULL, NULL, NULL),
(370, 'A370', 'ที่เจาะกระดาษ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/370_1772182062515.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ที่เจาะกระดาษ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:47:42', NULL, NULL, NULL, NULL, NULL, NULL),
(371, 'A371', 'กระเป๋าใส่ดินสอ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/371_1772182075101.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ประเป๋าใส่ดินสอ 3 ถุง', '2026-02-26 16:35:35', '2026-02-27 08:47:55', NULL, NULL, NULL, NULL, NULL, NULL),
(372, 'A372', 'Headphone Splitter', 'Other', 'อื่นๆ', 1, '/uploads/equipment/372_1772182088197.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Headphone Splitter 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:48:08', NULL, NULL, NULL, NULL, NULL, NULL),
(373, 'A373', 'คัตเตอร์', 'Other', 'อื่นๆ', 1, '/uploads/equipment/373_1772182098979.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - คัตเตอร์ 4 อัน', '2026-02-26 16:35:35', '2026-02-27 08:48:18', NULL, NULL, NULL, NULL, NULL, NULL),
(374, 'A374', 'ดินสอ', 'Other', 'อื่นๆ', 1, '/uploads/equipment/374_1772182108203.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -ดินสอ 12 แท่ง', '2026-02-26 16:35:35', '2026-02-27 08:48:28', NULL, NULL, NULL, NULL, NULL, NULL),
(375, 'A375', 'ตุ๊กตาตกแต่ง', 'Other', 'อื่นๆ', 1, '/uploads/equipment/375_1772182145270.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -ตุ๊กตาตกแต่ง 1 ถุง', '2026-02-26 16:35:35', '2026-02-27 08:49:05', NULL, NULL, NULL, NULL, NULL, NULL),
(376, 'A376', 'หมึกตัวปั้ม', 'Other', 'อื่นๆ', 1, '/uploads/equipment/376_1772182152763.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -หมึก แดง 1 อัน -หมึก ดำ 1 อัน -หมึก น้ำเงิน 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:49:12', NULL, NULL, NULL, NULL, NULL, NULL),
(377, 'A377', 'A4 Laminating', 'Other', 'อื่นๆ', 1, '/uploads/equipment/377_1772182159749.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -A4 Laminating ที่ เครื่อง', '2026-02-26 16:35:35', '2026-02-27 08:49:19', NULL, NULL, NULL, NULL, NULL, NULL),
(378, 'A378', 'Laminating Film', 'Other', 'อื่นๆ', 6, '/uploads/equipment/378_1772182171154.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Laminating Film 6 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:49:31', NULL, NULL, NULL, NULL, NULL, NULL),
(379, 'A379', 'ฟิวเจอร์บอร์ด', 'Other', 'อื่นๆ', 1, '/uploads/equipment/379_1772182192084.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -ฟิวเจอร์บอร์ด 4 แผ่น', '2026-02-26 16:35:35', '2026-02-27 08:49:52', NULL, NULL, NULL, NULL, NULL, NULL),
(380, 'A380', 'Power Inverter', 'Event', 'อื่นๆ', 1, '/uploads/equipment/380_1772182219874.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Power Inverter 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:50:19', NULL, NULL, NULL, NULL, NULL, NULL),
(381, 'A381', 'Lens Filter', 'Event', 'อื่นๆ', 1, '/uploads/equipment/381_1772182228876.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Lens Filter 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:50:28', NULL, NULL, NULL, NULL, NULL, NULL),
(382, 'A382', 'ตัวแปลงหัวชาร์จ', 'Event', 'อื่นๆ', 1, '/uploads/equipment/382_1772182238353.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวแปลงหัวชาร์จ 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:50:38', NULL, NULL, NULL, NULL, NULL, NULL),
(383, 'A383', 'แบตต่อกล้อง LP-E17', 'Event', 'อื่นๆ', 1, '/uploads/equipment/383_1772182250246.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - แบตต่อกล้อง LP-E17 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:50:50', NULL, NULL, NULL, NULL, NULL, NULL),
(384, 'A384', 'ชุด Lavalier', 'Event', 'อื่นๆ', 1, '/uploads/equipment/384_1772182261219.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - ตัวรับสัญญารณ (RX) 1 ชุด - ตัวส่งสัญญารณ (TX) 1 ชุด - สายไมค์แยกและตัวแปลง 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:51:01', NULL, NULL, NULL, NULL, NULL, NULL),
(385, 'A385', 'Hand Tally Counter', 'Event', 'อื่นๆ', 1, '/uploads/equipment/385_1772182270549.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Hand Tally Counter 1 อัน', '2026-02-26 16:35:35', '2026-02-27 08:51:10', NULL, NULL, NULL, NULL, NULL, NULL),
(386, 'A386', 'External Hard Drive Lenovo', 'Event', 'อื่นๆ', 1, '/uploads/equipment/386_1772182277836.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - External Hard Drive Lenovo 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:51:17', NULL, NULL, NULL, NULL, NULL, NULL),
(387, 'A387', 'External Hard Drive VAIO', 'Event', 'อื่นๆ', 1, '/uploads/equipment/387_1772182286163.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - External Hard Drive VAIO 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:51:26', NULL, NULL, NULL, NULL, NULL, NULL),
(388, 'A388', 'Storage Stick', 'Event', 'อื่นๆ', 1, '/uploads/equipment/388_1772182302826.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Storage Stick 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:51:42', NULL, NULL, NULL, NULL, NULL, NULL),
(389, 'A389', 'USB-C Docking', 'Event', 'อื่นๆ', 1, '/uploads/equipment/389_1772182320411.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - USB-C Docking 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:00', NULL, NULL, NULL, NULL, NULL, NULL),
(390, 'A390', 'Digital Tire Pressure Gauge', 'Event', 'อื่นๆ', 1, '/uploads/equipment/390_1772182328963.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Digital Tire Pressure Gauge 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:08', NULL, NULL, NULL, NULL, NULL, NULL),
(391, 'A391', 'Card Reader', 'Event', 'อื่นๆ', 1, '/uploads/equipment/391_1772182335247.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น - Card Reader 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:15', NULL, NULL, NULL, NULL, NULL, NULL),
(392, 'A392', 'ตัวแปลง USB -Type C', 'Event', 'อื่นๆ', 1, '/uploads/equipment/392_1772182345659.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -ตัวแปลง USB -Type C 2 อัน', '2026-02-26 16:35:35', '2026-02-27 08:52:25', NULL, NULL, NULL, NULL, NULL, NULL),
(393, 'A393', 'Card Reader + USB 2.0', 'Event', 'อื่นๆ', 1, '/uploads/equipment/393_1772182353325.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -Card Reader + USB 2.0 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:33', NULL, NULL, NULL, NULL, NULL, NULL),
(394, 'A394', 'เมาศ์ สาย USB', 'Event', 'อื่นๆ', 1, '/uploads/equipment/394_1772182371095.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -เมาส์ สาย USB 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:51', NULL, NULL, NULL, NULL, NULL, NULL),
(395, 'A395', 'เมาศ์ Macbook', 'Event', 'อื่นๆ', 1, '/uploads/equipment/395_1772182379931.jpg', 'ปกติ', 'อุปกรณ์ใน 1 ชุด/ชิ้น -เมาส์ Macbook 1 ชุด', '2026-02-26 16:35:35', '2026-02-27 08:52:59', NULL, NULL, NULL, NULL, NULL, NULL),
(396, 'A396', 'Note book', 'Event', 'ไฟฟ้า', 1, '/uploads/equipment/396_1772182386704.jpg', 'ชำรุด', 'อุปกรณ์ใน 1 ชุด/ชิ้น -Note book 1 เครื่อง - ชำรุด', '2026-02-26 16:35:35', '2026-02-27 08:53:06', NULL, NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int NOT NULL,
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_active` tinyint DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `is_active`, `created_at`) VALUES
(1, 'admin', '$2b$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 1, '2026-03-02 12:09:07');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `borrow_history`
--
ALTER TABLE `borrow_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_doc_no` (`doc_no`),
  ADD KEY `idx_equipment_code` (`equipment_code`);

--
-- Indexes for table `equipment`
--
ALTER TABLE `equipment`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uk_equipment_code` (`code`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrow_history`
--
ALTER TABLE `borrow_history`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `equipment`
--
ALTER TABLE `equipment`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=397;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `borrow_history`
--
ALTER TABLE `borrow_history`
  ADD CONSTRAINT `fk_borrow_equipment_code` FOREIGN KEY (`equipment_code`) REFERENCES `equipment` (`code`) ON DELETE RESTRICT ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
