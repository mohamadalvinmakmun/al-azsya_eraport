-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jan 15, 2025 at 04:08 PM
-- Server version: 10.6.17-MariaDB-cll-lve
-- PHP Version: 8.1.31

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `alasaera_eraport`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `buat_raport` (IN `nis_siswa` VARCHAR(11), IN `nip_walikelas` VARCHAR(11), IN `thnajaran` INT(11), IN `raporsmt` INT(11))   INSERT INTO raport (tanggal, nis, nip, tahun_ajaran, rapor_semester) 
    VALUES (CURRENT_DATE(), nis_siswa, nip_walikelas, thnajaran, raporsmt)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `get_list_chat_siswa` (IN `nip` VARCHAR(11))   SELECT murid_id,nama_siswa,guru_id,nama_kelas FROM chats INNER JOIN siswa ON siswa.nis = chats.murid_id INNER JOIN kelas ON siswa.id_kelas = kelas.id_kelas WHERE guru_id = 48295013901 GROUP BY murid_id$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `send_message_to_siswa` (IN `id_murid` VARCHAR(11), IN `id_guru` VARCHAR(11), IN `msg` VARCHAR(255))   INSERT INTO chats VALUES(NULL, id_murid, id_guru, NOW(), msg, FALSE, FALSE)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `send_message_to_wali_kelas` (IN `id_murid` VARCHAR(11), IN `id_guru` VARCHAR(11), IN `msg` VARCHAR(255))   INSERT INTO chats VALUES(NULL, id_murid, id_guru, NOW(), msg, FALSE, TRUE)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `tambah_data_guru` (IN `nipguru` VARCHAR(11), IN `namaguru` VARCHAR(50), IN `jenkelguru` ENUM('Laki-laki','Perempuan'), IN `alamatguru` TEXT, IN `emailguru` VARCHAR(30), IN `notelpguru` VARCHAR(14), IN `agamaguru` ENUM('Buddha','Hindu','Islam','Katolik','Konghuchu','Kristen'), IN `statusguru` VARCHAR(20), IN `tgllahirguru` DATE, IN `passwordguru` VARCHAR(255))   INSERT INTO guru(nip, nama_guru, jenis_kelamin, alamat, email, no_telp, agama, status, tanggal_lahir, password)
        VALUES (nipguru,namaguru,jenkelguru,alamatguru,emailguru,notelpguru,agamaguru,statusguru,tgllahirguru,passwordguru)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `tambah_data_siswa` (IN `nissiswa` VARCHAR(11), IN `namasiswa` VARCHAR(50), IN `jenkelsiswa` ENUM('Laki-laki','Perempuan'), IN `alamatsiswa` TEXT, IN `emailsiswa` VARCHAR(30), IN `notelpsiswa` VARCHAR(14), IN `agamasiswa` ENUM('Buddha','Hindu','Islam','Katolik','Konghuchu','Kristen'), IN `kelassiswa` INT(11), IN `tgllahirsiswa` DATE, IN `passwordsiswa` VARCHAR(255))   INSERT INTO siswa(nis, nama_siswa, jenis_kelamin, alamat, email, no_telp, agama, id_kelas, tanggal_lahir, password)
        VALUES (nissiswa, namasiswa, jenkelsiswa, alamatsiswa, emailsiswa, notelpsiswa, agamasiswa, kelassiswa, tgllahirsiswa, passwordsiswa)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `tambah_kelas` (IN `nipwali` VARCHAR(11), IN `namakelas` VARCHAR(30))   INSERT INTO kelas(nip, nama_kelas) VALUES (nipwali, namakelas)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `tambah_mapel` (IN `nipwali` VARCHAR(11), IN `namamapel` VARCHAR(50))   INSERT INTO mata_pelajaran(nip, nama_mapel) VALUES (nipwali, namamapel)$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `tambah_nilai` (IN `nis_siswa` VARCHAR(11), IN `id_mapel` INT(11), IN `id_raport` INT(11), IN `smt` INT(11), IN `cp1` INT(11), IN `cp2` INT(11), IN `cp3` INT(11), IN `cp4` INT(11), IN `uts` INT(11), IN `uas` INT(11))   INSERT INTO nilai(nis, id_mapel, id_raport, semester, cp1, cp2, cp3, cp4, uts, uas, nilai_akhir) 
    VALUES (nis_siswa, id_mapel, id_raport, smt, cp1, cp2, cp3, cp4, uts, uas, hitung_nilai_akhir(cp1, cp2, cp3, cp4, uts, uas))$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `ubah_data_guru` (IN `nipguru` VARCHAR(11), IN `namaguru` VARCHAR(50), IN `jenkelguru` ENUM('Laki-laki','Perempuan'), IN `alamatguru` TEXT, IN `emailguru` VARCHAR(30), IN `notelpguru` VARCHAR(14), IN `agamaguru` ENUM('Buddha','Hindu','Islam','Katolik','Konghuchu','Kristen'), IN `statusguru` VARCHAR(20), IN `tgllahirguru` DATE, IN `passwordguru` VARCHAR(255))   UPDATE guru SET nip=nipguru, nama_guru=namaguru, jenis_kelamin=jenkelguru, alamat=alamatguru, email=emailguru, no_telp=notelpguru, agama=agamaguru, status=statusguru, tanggal_lahir=tgllahirguru, password=passwordguru WHERE nip=nipguru$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `ubah_data_siswa` (IN `nissiswa` VARCHAR(11), IN `namasiswa` VARCHAR(50), IN `jenkelsiswa` ENUM('Laki-laki','Perempuan'), IN `alamatsiswa` TEXT, IN `emailsiswa` VARCHAR(30), IN `notelpsiswa` VARCHAR(14), IN `agamasiswa` ENUM('Buddha','Hindu','Islam','Katolik','Konghuchu','Kristen'), IN `kelassiswa` INT(11), IN `tgllahirsiswa` DATE, IN `passwordsiswa` VARCHAR(255))   UPDATE siswa SET nis=nissiswa, nama_siswa=namasiswa, jenis_kelamin=jenkelsiswa, alamat=alamatsiswa, email=emailsiswa, no_telp=notelpsiswa, agama=agamasiswa, id_kelas=kelassiswa, tanggal_lahir=tgllahirsiswa, password=passwordsiswa WHERE nis=nissiswa$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `ubah_kelas` (IN `idkelas` INT(11), IN `nipwali` VARCHAR(11), IN `namakelas` VARCHAR(30))   UPDATE kelas SET nip=nipwali, nama_kelas=namakelas WHERE id_kelas=idkelas$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `ubah_mapel` (IN `idmapel` INT(11), IN `nipwali` VARCHAR(11), IN `namamapel` VARCHAR(50))   UPDATE mata_pelajaran SET nip=nipwali, nama_mapel=namamapel WHERE id_mapel=idmapel$$

CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` PROCEDURE `ubah_nilai` (IN `nis_siswa` VARCHAR(11), IN `id_mapel` INT(11), IN `smt` INT(11), IN `cp1` INT(11), IN `cp2` INT(11), IN `cp3` INT(11), IN `cp4` INT(11), IN `uts` INT(11), IN `uas` INT(11))   UPDATE nilai SET cp1 = cp1, cp2 = cp2, cp3 = cp3, cp4 = cp4, uts = uts, uas = uas, nilai_akhir = hitung_nilai_akhir(cp1, cp2, cp3, cp4, uts, uas) WHERE nis = nis_siswa AND id_mapel = id_mapel AND semester = smt$$

--
-- Functions
--
CREATE DEFINER=`alasaera__TVJV82kuxlcvePNeipbS94XJ6cbkpkuy`@`localhost` FUNCTION `hitung_nilai_akhir` (`cp1` INT, `cp2` INT, `cp3` INT, `cp4` INT, `uts` INT, `uas` INT) RETURNS CHAR(1) CHARSET latin1 COLLATE latin1_swedish_ci DETERMINISTIC BEGIN
    DECLARE rata DOUBLE;
    DECLARE nilai_akhir CHAR(1);

    -- Hitung rata-rata nilai
    SET rata = (COALESCE(cp1, 0) + COALESCE(cp2, 0) + COALESCE(cp3, 0) + COALESCE(cp4, 0) + COALESCE(uts, 0) + COALESCE(uas, 0)) / 6;

    -- Tentukan nilai akhir berdasarkan rata-rata
    IF rata > 90 THEN
        SET nilai_akhir = 'A';
    ELSEIF rata > 70 THEN
        SET nilai_akhir = 'B';
    ELSEIF rata > 60 THEN
        SET nilai_akhir = 'C';
    ELSEIF rata > 50 THEN
        SET nilai_akhir = 'D';
    ELSE
        SET nilai_akhir = 'E';
    END IF;

    -- Kembalikan nilai akhir
    RETURN nilai_akhir;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id_admin` int(11) NOT NULL,
  `nama_admin` varchar(255) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id_admin`, `nama_admin`, `email`, `password`) VALUES
(2, 'Adji', 'adji@eraports.com', '123'),
(3, 'Boni', 'boni@eraports.com', '123'),
(4, 'Adi', 'adi@eraports.com', '123'),
(5, 'Rizky', 'rizky@eraports.com', '123'),
(6, 'Rio', 'rio@eraports.com', '123');

-- --------------------------------------------------------

--
-- Table structure for table `chats`
--

CREATE TABLE `chats` (
  `id_chat` int(11) NOT NULL,
  `murid_id` varchar(11) NOT NULL,
  `guru_id` varchar(11) NOT NULL,
  `timestamps` timestamp NOT NULL DEFAULT current_timestamp(),
  `message` varchar(255) NOT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `is_from_murid` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `guru`
--

CREATE TABLE `guru` (
  `nip` varchar(11) NOT NULL,
  `nama_guru` varchar(50) NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `alamat` text NOT NULL,
  `email` varchar(30) NOT NULL,
  `no_telp` varchar(14) NOT NULL,
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghuchu') NOT NULL,
  `status` varchar(20) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`nip`, `nama_guru`, `jenis_kelamin`, `alamat`, `email`, `no_telp`, `agama`, `status`, `tanggal_lahir`, `password`) VALUES
('48295013901', 'Ahmad', 'Laki-laki', 'Jakarta', 'ahmad12@gmail.com', '08123947562', 'Islam', 'Pegawai Negeri Sipil', '1998-08-18', '$2y$10$5VVYxZO.q33y9A1anNY5YemQYbzA5RUZ.DgRS.1LEaTUNqzpIZGk.'),
('48295013902', 'Dimas', 'Laki-laki', 'Bogor', 'dimas01@gmail.com', '08134792835', 'Islam', 'Guru Tetap Yayasan', '1990-09-05', '$2y$10$ktv87UPxfYMzkAlD70ieC.fNCm9X1/fclKoF8KeqeB8CIGJUxi7Qy'),
('48295013903', 'Rafif ', 'Laki-laki', 'Tangerang', 'rafif18@gmail.com', '081827481512', 'Islam', 'Guru Tetap Yayasan', '1990-02-18', '$2y$10$o7ZhxPscyX9yBoJ3mSPsVOI2u87E4ytwxzNdD8MJPo9hZZ9g5p.y2'),
('48295013904', 'Kartika', 'Perempuan', 'Jakarta', 'kartika18@gmail.com', '087846789612', 'Islam', 'Guru Tetap Yayasan', '1990-02-18', '$2y$10$.h76Sliy.9pUq4zIjVBfVeDR2M2x5R6Q..ED2wsiWpCFGy3YlL/fy'),
('48295013905', 'Raditya', 'Laki-laki', 'Bogor', 'raditya18@gmail.com', '081293819211', 'Islam', 'Guru Tetap Yayasan', '1990-09-18', '$2y$10$CCoYxmpyT.9GjPIq6yMeXOom0Qi/.j5/ypDBbazDYgcQtI8eKwVCO'),
('48295013906', 'Fathur', 'Laki-laki', 'Depok', 'fathur12@gmail.com', '081273428124', 'Islam', 'Pegawai Negeri Sipil', '1990-04-12', '$2y$10$.Q/5ToE4S9u0LmAwkvv8peA0yUg7b89dxQ4VNCMD4vMCce.fJKwIO'),
('48295013907', 'Echidna', 'Perempuan', 'Bekasi', 'echidna05@gmail.com', '08565472856', 'Kristen', 'Pegawai Negeri Sipil', '1984-06-05', '$2y$10$WaV3rq3od9fTOFnyBuuPuOQMPglW3KmE4Cb8qXE2GCyF3MPjHQBva'),
('48295013908', 'kuswantoro', 'Laki-laki', 'Tangerang', 'Kuswan11@gmail.com', '082276812909', 'Islam', 'Guru Tetap Yayasan', '1980-06-11', '$2y$10$ddRIX3XaTaf.I9cjmZZCgOozn4650auC37Vo7I6yYSFiy4yf/TjKm'),
('48295013909', 'Rozali', 'Laki-laki', 'Surakarta', 'rozy20@gmail.com', '085688654619', 'Islam', 'Guru Tetap Yayasan', '1988-01-20', '$2y$10$unCzaLx5utiWTmzTGtdGLOHp93bz1hma8conYnM8gcHB8pdO5DlMy'),
('48295013910', 'Yuliana', 'Perempuan', 'Jakarta', 'yuliana10@gmail.com', '08587765435', 'Islam', 'Guru Tetap Yayasan', '1999-03-10', '$2y$10$64Pcj1M9tNNBrVlXOUVgSOHbJwJLoNmcEhxlaWA9gbnKqweXWgjfW'),
('48295013911', 'Kurniawati', 'Perempuan', 'Bekasi', 'kurnia21@gmail.com', '082276812910', 'Islam', 'Guru Tetap Yayasan', '1890-08-21', '$2y$10$pjGSOTS8L.fGKzQtZja.1O5D6KxaDnKYkAhl5WgT1UFwQkZ0JOW8K'),
('48295013912', 'Fauziatul', 'Perempuan', 'Kebumen', 'fauziyatul05@gmail.com', '082276812912', 'Islam', 'Guru Tidak Tetap', '1889-02-05', '$2y$10$DunYc0zKs0MBuaolU0OIL.VYY5ojOEq8TXjUELrRarO1x0.4uVHIK'),
('48295013913', 'Rihannah', 'Perempuan', 'Jakarta', 'rihannah15@gmail.com', '085875435790', 'Kristen', 'Pegawai Negeri Sipil', '1989-06-15', '$2y$10$TORcYgHx/LauNY4l5Acmz.wEKC9.7PiJM.H2MdOtIddUcWzh2A5Ny'),
('48295013914', 'Wirayudha', 'Laki-laki', 'Bogor', 'wirayudha13@gmail.com', '085876546468', 'Islam', 'Guru Tidak Tetap', '1986-05-13', '$2y$10$9UqBaFzz2NKLqhihX3jQ9.m/WLsg3uTkNR5RSwztl241MVLq1uW8C'),
('48295013915', 'Dimas Edi Jatmiko', 'Laki-laki', 'Wates', 'jatmiko56@gmail.com', '082276802913', 'Islam', 'Guru Tetap Yayasan', '1891-06-05', '$2y$10$8Tcb/fYSXHuR1YkmNsRwFunNqjEmAHjktyAeWSycYi3zhsOXDQj/u'),
('48295013916', 'Hanifah', 'Perempuan', 'Mantingan', 'hanifah4@gmail.com', '082276802914', 'Islam', 'Pegawai Negeri Sipil', '1980-04-09', '$2y$10$k1vUYwOJ4fEXjUxX6D1./Oh1P/iy0n2vuV9uny87s1IKv0SzguMtu'),
('48295013917', 'Sugianto', 'Laki-laki', 'Yogyakarta', 'sugi12@gmail.com', '0858787546', 'Islam', 'Guru Tetap Yayasan', '1988-12-04', '$2y$10$9HKsv.k1qomH9BkZIdSU2umLRU8vAIbEXdTQkb5.k1zi2TYdtsvgO'),
('48295013918', 'Zazkia', 'Perempuan', 'Bekasi', 'zazki29@gmail.com', '082276802921', 'Islam', 'Guru Tetap Yayasan', '1988-11-29', '$2y$10$f8nZAd9Na.hAQr/7kSmp2evaUldyJ/bMygUJvhJ8Hr5ZmaU6lnR6i'),
('48295013919', 'Sandika', 'Laki-laki', 'Tangerang', 'sandika18@gmail.com', '081728467128', 'Kristen', 'Pegawai Negeri Sipil', '1990-07-18', '$2y$10$f4tC2/3ERnnTrZ2S0jidguVUDdqmw0fNxmQ1f2yzHZle4jQs99XJC'),
('4829501753', 'Briliant', 'Laki-laki', 'Bogor', 'briliant14@gmail.com', '083892085664', 'Kristen', 'Guru Tidak Tetap', '1999-08-14', '$2y$10$mXfnh2Tu7mKgBshLj.pH0ujDxUjv6WSPmAIBgykIalDSQYHJZUkkW');

-- --------------------------------------------------------

--
-- Table structure for table `kelas`
--

CREATE TABLE `kelas` (
  `id_kelas` int(11) NOT NULL,
  `nama_kelas` varchar(30) NOT NULL,
  `nip` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `nip`) VALUES
(1, 'X IPA A', '48295013901'),
(8, 'X IPS A', '48295013902'),
(9, 'X IPA B', '48295013903'),
(11, 'X IPS B', '48295013904');

-- --------------------------------------------------------

--
-- Table structure for table `mata_pelajaran`
--

CREATE TABLE `mata_pelajaran` (
  `id_mapel` int(11) NOT NULL,
  `nama_mapel` varchar(50) NOT NULL,
  `nip` varchar(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mata_pelajaran`
--

INSERT INTO `mata_pelajaran` (`id_mapel`, `nama_mapel`, `nip`) VALUES
(7, 'Matematika', '48295013901'),
(8, 'Biologi', '48295013902'),
(9, 'Sejarah', '48295013903'),
(11, 'Kimia', '48295013904'),
(12, 'Bahasa Indonesia', '48295013905'),
(13, 'Bahasa Inggris', '48295013906'),
(14, 'PKN', '48295013907'),
(16, 'Seni Budaya', '48295013908');

-- --------------------------------------------------------

--
-- Table structure for table `nilai`
--

CREATE TABLE `nilai` (
  `id_nilai` int(11) NOT NULL,
  `nis` varchar(11) NOT NULL,
  `id_mapel` int(11) NOT NULL,
  `id_raport` int(11) NOT NULL,
  `semester` int(11) NOT NULL,
  `cp1` int(11) DEFAULT NULL,
  `cp2` int(11) DEFAULT NULL,
  `cp3` int(11) DEFAULT NULL,
  `cp4` int(11) DEFAULT NULL,
  `uts` int(11) DEFAULT NULL,
  `uas` int(11) DEFAULT NULL,
  `nilai_akhir` varchar(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `nilai`
--

INSERT INTO `nilai` (`id_nilai`, `nis`, `id_mapel`, `id_raport`, `semester`, `cp1`, `cp2`, `cp3`, `cp4`, `uts`, `uas`, `nilai_akhir`) VALUES
(36, '295013901', 7, 21, 2, 90, 0, 0, 0, 0, 0, 'E'),
(37, '295013901', 8, 21, 2, 85, 0, 0, 0, 0, 0, 'E'),
(38, '295013901', 9, 21, 2, 91, 91, 87, 92, 98, 65, 'B'),
(39, '295013902', 7, 22, 2, 75, 0, 0, 0, 0, 0, 'E'),
(40, '295013902', 8, 22, 2, 77, 0, 0, 0, 0, 0, 'E'),
(41, '295013902', 9, 22, 2, 89, 92, 94, 95, 97, 100, 'A'),
(42, '295013903', 7, 23, 2, 83, 0, 0, 0, 0, 0, 'E'),
(43, '295013903', 8, 23, 2, 86, 0, 0, 0, 0, 0, 'E'),
(44, '295013903', 9, 23, 2, 90, 90, 95, 90, 97, 97, 'A'),
(45, '295013904', 7, 24, 2, 88, 0, 0, 0, 0, 0, 'E'),
(46, '295013904', 8, 24, 2, 87, 0, 0, 0, 0, 0, 'E'),
(47, '295013904', 9, 24, 2, 92, 92, 90, 88, 97, 98, 'A'),
(48, '295013905', 7, 25, 2, 85, 0, 0, 0, 0, 0, 'E'),
(49, '295013905', 8, 25, 2, 82, 0, 0, 0, 0, 0, 'E'),
(50, '295013905', 9, 25, 2, 87, 90, 90, 98, 96, 99, 'A'),
(51, '295013906', 7, 26, 2, 87, 0, 0, 0, 0, 0, 'E'),
(52, '295013906', 8, 26, 2, 98, 0, 0, 0, 0, 0, 'E'),
(53, '295013906', 8, 26, 2, 98, 0, 0, 0, 0, 0, 'E'),
(54, '295013906', 9, 26, 2, 87, 88, 88, 90, 93, 92, 'B'),
(55, '295013907', 7, 27, 2, 89, 0, 0, 0, 0, 0, 'E'),
(56, '295013907', 8, 27, 2, 88, 0, 0, 0, 0, 0, 'E'),
(57, '295013907', 9, 27, 2, 89, 87, 90, 90, 95, 96, 'A'),
(58, '295013908', 7, 28, 2, 89, 0, 0, 0, 0, 0, 'E'),
(59, '295013908', 8, 28, 2, 87, 0, 0, 0, 0, 0, 'E'),
(60, '295013908', 8, 28, 2, 87, 0, 0, 0, 0, 0, 'E'),
(61, '295013908', 9, 28, 2, 89, 90, 100, 90, 94, 96, 'A'),
(62, '295013909', 7, 29, 2, 100, 0, 0, 0, 0, 0, 'E'),
(63, '295013909', 8, 29, 2, 96, 93, 87, 88, 90, 94, 'A'),
(64, '295013909', 9, 29, 2, 97, 84, 80, 100, 99, 95, 'A'),
(65, '295013910', 7, 30, 2, 98, 0, 0, 0, 0, 0, 'E'),
(66, '295013910', 8, 30, 2, 95, 97, 100, 89, 100, 100, 'A'),
(67, '295013910', 9, 30, 2, 79, 82, 87, 92, 90, 98, 'B'),
(68, '295013921', 14, 31, 2, 76, 80, 85, 85, 90, 93, 'B'),
(69, '295013922', 14, 32, 2, 80, 80, 87, 86, 92, 90, 'B'),
(70, '295013923', 14, 33, 2, 87, 85, 90, 90, 93, 95, 'B'),
(71, '295013924', 14, 34, 2, 78, 83, 89, 90, 90, 91, 'B'),
(72, '295013925', 14, 35, 2, 91, 90, 100, 100, 94, 97, 'A'),
(73, '295013926', 14, 36, 2, 80, 80, 84, 92, 95, 95, 'B'),
(74, '295013927', 14, 37, 2, 87, 90, 100, 100, 97, 95, 'A'),
(75, '295013928', 14, 38, 2, 87, 90, 93, 93, 96, 98, 'A'),
(76, '295013929', 14, 39, 2, 87, 85, 95, 93, 96, 98, 'A'),
(77, '295013930', 14, 40, 2, 98, 98, 85, 100, 96, 98, 'A'),
(78, '295013901', 14, 21, 2, 86, 80, 92, 90, 95, 90, 'B'),
(79, '295013902', 14, 22, 2, 90, 90, 90, 96, 94, 98, 'A'),
(80, '295013903', 14, 23, 2, 78, 80, 90, 84, 96, 95, 'B'),
(81, '295013904', 14, 24, 2, 96, 82, 86, 98, 99, 100, 'A'),
(82, '295013905', 14, 25, 2, 95, 78, 92, 88, 80, 90, 'B'),
(83, '295013906', 14, 26, 2, 95, 92, 89, 90, 95, 95, 'A'),
(84, '295013907', 14, 27, 2, 86, 78, 100, 97, 98, 94, 'A'),
(85, '295013908', 14, 28, 2, 87, 86, 78, 100, 95, 98, 'A'),
(86, '295013909', 14, 29, 2, 98, 76, 88, 90, 90, 90, 'B'),
(87, '295013910', 14, 30, 2, 87, 76, 100, 92, 100, 98, 'A'),
(88, '295013901', 16, 21, 2, 78, 82, 87, 90, 90, 95, 'B'),
(89, '295013902', 16, 22, 2, 90, 90, 93, 95, 97, 97, 'A'),
(90, '295013903', 16, 23, 2, 90, 90, 95, 97, 99, 99, 'A'),
(91, '295013904', 16, 24, 2, 90, 90, 99, 100, 95, 97, 'A'),
(92, '295013905', 16, 25, 2, 87, 90, 90, 94, 95, 100, 'A'),
(93, '295013906', 16, 26, 2, 90, 90, 95, 96, 98, 99, 'A'),
(94, '295013907', 16, 27, 2, 97, 98, 99, 87, 90, 90, 'A'),
(95, '295013908', 16, 28, 2, 90, 90, 90, 97, 95, 100, 'A'),
(96, '295013908', 16, 28, 2, 90, 90, 90, 97, 95, 100, 'A'),
(97, '295013909', 16, 29, 2, 90, 90, 95, 96, 99, 99, 'A'),
(98, '295013910', 16, 30, 2, 90, 90, 94, 96, 89, 99, 'A'),
(99, '295013901', 7, 41, 1, 78, 76, 84, 77, 89, 91, 'B'),
(100, '295013902', 7, 42, 1, 90, 90, 92, 95, 97, 98, 'A'),
(101, '295013903', 7, 43, 1, 90, 96, 85, 80, 89, 90, 'B'),
(102, '295013904', 7, 44, 1, 90, 90, 93, 99, 100, 94, 'A'),
(103, '295013905', 7, 45, 1, 80, 100, 92, 84, 93, 95, 'A'),
(104, '295013906', 7, 46, 1, 91, 86, 89, 100, 92, 98, 'A'),
(105, '295013907', 7, 47, 1, 87, 88, 90, 94, 90, 95, 'A'),
(106, '295013908', 7, 48, 1, 87, 79, 100, 93, 95, 98, 'A'),
(107, '295013909', 7, 49, 1, 78, 92, 86, 90, 100, 96, 'A'),
(108, '295013910', 7, 50, 1, 96, 80, 87, 100, 97, 98, 'A'),
(109, '295013901', 14, 41, 1, 79, 83, 90, 90, 92, 94, 'B'),
(110, '295013902', 14, 42, 1, 87, 90, 90, 100, 95, 92, 'A'),
(111, '295013910', 14, 50, 1, 87, 80, 90, 91, 100, 98, 'A'),
(112, '295013909', 14, 49, 1, 87, 100, 90, 92, 97, 96, 'A'),
(113, '295013908', 14, 48, 1, 91, 90, 80, 100, 85, 90, 'B'),
(114, '295013907', 14, 47, 1, 87, 80, 100, 100, 97, 98, 'A'),
(115, '295013906', 14, 46, 1, 80, 92, 100, 100, 82, 98, 'A'),
(116, '295013905', 14, 45, 1, 80, 100, 100, 95, 95, 98, 'A'),
(117, '295013904', 14, 44, 1, 90, 90, 87, 98, 100, 98, 'A'),
(118, '295013903', 14, 43, 1, 87, 80, 94, 90, 90, 100, 'A'),
(119, '295013921', 14, 51, 1, 90, 90, 92, 100, 96, 100, 'A'),
(120, '295013922', 14, 52, 1, 87, 80, 100, 92, 87, 90, 'B'),
(121, '295013923', 14, 53, 1, 76, 80, 97, 100, 98, 99, 'A'),
(122, '295013924', 14, 54, 1, 86, 66, 80, 100, 92, 96, 'B'),
(123, '295013925', 14, 55, 1, 89, 90, 90, 100, 97, 97, 'A'),
(124, '295013926', 14, 56, 1, 100, 100, 87, 90, 95, 95, 'A'),
(125, '295013927', 14, 57, 1, 79, 80, 88, 92, 95, 95, 'B'),
(126, '295013928', 14, 58, 1, 88, 90, 90, 90, 94, 96, 'A'),
(127, '295013929', 14, 59, 1, 88, 90, 90, 93, 100, 98, 'A'),
(128, '295013930', 14, 60, 1, 100, 100, 98, 96, 98, 98, 'A'),
(129, '295013901', 16, 41, 1, 90, 90, 90, 92, 100, 100, 'A'),
(130, '295013902', 16, 42, 1, 90, 90, 90, 92, 94, 98, 'A'),
(131, '295013903', 16, 43, 1, 90, 90, 90, 100, 97, 98, 'A'),
(132, '295013904', 16, 44, 1, 90, 90, 90, 94, 100, 98, 'A'),
(133, '295013905', 16, 45, 1, 90, 90, 90, 93, 100, 98, 'A'),
(134, '295013906', 16, 46, 1, 90, 90, 90, 93, 94, 100, 'A'),
(135, '295013907', 16, 47, 1, 90, 90, 90, 100, 95, 98, 'A'),
(136, '295013908', 16, 48, 1, 90, 90, 90, 100, 100, 98, 'A'),
(137, '295013909', 16, 49, 1, 90, 90, 90, 90, 100, 98, 'A'),
(138, '295013910', 16, 50, 1, 90, 90, 90, 93, 100, 98, 'A'),
(139, '295013901', 13, 41, 1, 100, 92, 92, 94, 95, 98, 'A'),
(140, '295013902', 13, 42, 1, 90, 100, 92, 94, 98, 98, 'A'),
(141, '295013903', 13, 43, 1, 90, 90, 90, 100, 92, 97, 'A'),
(142, '295013904', 13, 44, 1, 98, 100, 92, 92, 95, 98, 'A'),
(143, '295013905', 13, 45, 1, 90, 90, 92, 100, 94, 98, 'A'),
(144, '295013906', 13, 46, 1, 90, 90, 93, 100, 98, 98, 'A'),
(145, '295013907', 13, 47, 1, 90, 90, 92, 90, 100, 98, 'A'),
(146, '295013908', 13, 48, 1, 90, 90, 100, 98, 100, 98, 'A'),
(147, '295013909', 13, 49, 1, 100, 89, 90, 90, 92, 96, 'A'),
(148, '295013910', 13, 50, 1, 90, 90, 88, 100, 92, 98, 'A'),
(149, '295013901', 12, 41, 1, 90, 90, 78, 88, 90, 98, 'B'),
(150, '295013902', 12, 42, 1, 90, 90, 98, 100, 88, 98, 'A'),
(151, '295013903', 12, 43, 1, 87, 90, 90, 91, 94, 98, 'A'),
(152, '295013904', 12, 44, 1, 90, 90, 100, 92, 96, 98, 'A'),
(153, '295013905', 12, 45, 1, 90, 90, 100, 89, 92, 98, 'A'),
(154, '295013906', 12, 46, 1, 100, 90, 90, 92, 92, 98, 'A'),
(155, '295013907', 12, 47, 1, 90, 92, 100, 92, 93, 98, 'A'),
(156, '295013908', 12, 48, 1, 90, 87, 100, 90, 90, 98, 'A'),
(157, '295013909', 12, 49, 1, 90, 100, 90, 92, 92, 98, 'A'),
(158, '295013910', 12, 50, 1, 90, 90, 100, 92, 91, 98, 'A'),
(159, '295013901', 8, 41, 1, 89, 90, 90, 100, 90, 98, 'A'),
(160, '295013902', 8, 42, 1, 90, 90, 100, 100, 92, 98, 'A'),
(161, '295013903', 8, 43, 1, 90, 90, 100, 100, 97, 98, 'A'),
(162, '295013904', 8, 44, 1, 90, 90, 100, 100, 98, 98, 'A'),
(163, '295013905', 8, 45, 1, 90, 91, 100, 100, 92, 98, 'A'),
(164, '295013906', 8, 46, 1, 90, 90, 100, 100, 92, 98, 'A'),
(165, '295013907', 8, 47, 1, 100, 92, 90, 90, 92, 98, 'A'),
(166, '295013908', 8, 48, 1, 90, 100, 100, 92, 93, 98, 'A'),
(167, '295013909', 8, 49, 1, 90, 90, 90, 100, 92, 98, 'A'),
(168, '295013910', 8, 50, 1, 100, 100, 90, 92, 92, 98, 'A'),
(169, '295013901', 11, 41, 1, 90, 100, 100, 78, 90, 99, 'A'),
(170, '295013911', 8, 61, 2, 88, 0, 0, 0, 0, 0, 'E'),
(171, '295013912', 8, 62, 2, 87, 0, 0, 0, 0, 0, 'E'),
(172, '295013913', 8, 63, 2, 86, 0, 0, 0, 0, 0, 'E'),
(173, '295013914', 8, 64, 2, 84, 0, 0, 0, 0, 0, 'E'),
(174, '295013911', 7, 65, 1, 86, 89, 76, 70, 85, 82, 'B'),
(175, '295013912', 7, 66, 1, 90, 90, 78, 78, 90, 67, 'B'),
(176, '295013913', 7, 67, 1, 67, 78, 89, 90, 78, 90, 'B'),
(177, '295013914', 7, 68, 1, 78, 89, 90, 78, 89, 90, 'B'),
(178, '295013916', 7, 69, 1, 90, 89, 89, 78, 90, 89, 'B'),
(179, '295013917', 7, 70, 1, 90, 90, 90, 89, 89, 90, 'B'),
(180, '295013918', 7, 71, 1, 90, 90, 78, 89, 90, 90, 'B'),
(181, '295013918', 7, 71, 1, 90, 90, 78, 89, 90, 90, 'B'),
(182, '295013919', 7, 72, 1, 89, 90, 90, 90, 90, 90, 'B'),
(183, '295013920', 7, 73, 1, 90, 90, 90, 90, 90, 90, 'B');

-- --------------------------------------------------------

--
-- Table structure for table `raport`
--

CREATE TABLE `raport` (
  `id_raport` int(11) NOT NULL,
  `tanggal` date NOT NULL,
  `nis` varchar(11) NOT NULL,
  `nip` varchar(11) NOT NULL,
  `tahun_ajaran` int(11) NOT NULL,
  `rapor_semester` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `raport`
--

INSERT INTO `raport` (`id_raport`, `tanggal`, `nis`, `nip`, `tahun_ajaran`, `rapor_semester`) VALUES
(21, '2025-01-10', '295013901', '48295013901', 20242025, 2),
(22, '2025-01-10', '295013902', '48295013901', 20242025, 2),
(23, '2025-01-10', '295013903', '48295013901', 20242025, 2),
(24, '2025-01-10', '295013904', '48295013901', 20242025, 2),
(25, '2025-01-10', '295013905', '48295013901', 20242025, 2),
(26, '2025-01-10', '295013906', '48295013901', 20242025, 2),
(27, '2025-01-10', '295013907', '48295013901', 20242025, 2),
(28, '2025-01-10', '295013908', '48295013901', 20242025, 2),
(29, '2025-01-10', '295013909', '48295013901', 20242025, 2),
(30, '2025-01-10', '295013910', '48295013901', 20242025, 2),
(31, '2025-01-11', '295013921', '48295013903', 20242025, 2),
(32, '2025-01-11', '295013922', '48295013903', 20242025, 2),
(33, '2025-01-11', '295013923', '48295013903', 20242025, 2),
(34, '2025-01-11', '295013924', '48295013903', 20242025, 2),
(35, '2025-01-11', '295013925', '48295013903', 20242025, 2),
(36, '2025-01-11', '295013926', '48295013903', 20242025, 2),
(37, '2025-01-11', '295013927', '48295013903', 20242025, 2),
(38, '2025-01-11', '295013928', '48295013903', 20242025, 2),
(39, '2025-01-11', '295013929', '48295013903', 20242025, 2),
(40, '2025-01-11', '295013930', '48295013903', 20242025, 2),
(41, '2025-01-13', '295013901', '48295013901', 20242025, 1),
(42, '2025-01-13', '295013902', '48295013901', 20242025, 1),
(43, '2025-01-13', '295013903', '48295013901', 20242025, 1),
(44, '2025-01-13', '295013904', '48295013901', 20242025, 1),
(45, '2025-01-13', '295013905', '48295013901', 20242025, 1),
(46, '2025-01-13', '295013906', '48295013901', 20242025, 1),
(47, '2025-01-13', '295013907', '48295013901', 20242025, 1),
(48, '2025-01-13', '295013908', '48295013901', 20242025, 1),
(49, '2025-01-13', '295013909', '48295013901', 20242025, 1),
(50, '2025-01-13', '295013910', '48295013901', 20242025, 1),
(51, '2025-01-13', '295013921', '48295013903', 20242025, 1),
(52, '2025-01-13', '295013922', '48295013903', 20242025, 1),
(53, '2025-01-13', '295013923', '48295013903', 20242025, 1),
(54, '2025-01-13', '295013924', '48295013903', 20242025, 1),
(55, '2025-01-13', '295013925', '48295013903', 20242025, 1),
(56, '2025-01-13', '295013926', '48295013903', 20242025, 1),
(57, '2025-01-13', '295013927', '48295013903', 20242025, 1),
(58, '2025-01-13', '295013928', '48295013903', 20242025, 1),
(59, '2025-01-13', '295013929', '48295013903', 20242025, 1),
(60, '2025-01-13', '295013930', '48295013903', 20242025, 1),
(61, '2025-01-15', '295013911', '48295013902', 20242025, 2),
(62, '2025-01-15', '295013912', '48295013902', 20242025, 2),
(63, '2025-01-15', '295013913', '48295013902', 20242025, 2),
(64, '2025-01-15', '295013914', '48295013902', 20242025, 2),
(65, '2025-01-15', '295013911', '48295013902', 20242025, 1),
(66, '2025-01-15', '295013912', '48295013902', 20242025, 1),
(67, '2025-01-15', '295013913', '48295013902', 20242025, 1),
(68, '2025-01-15', '295013914', '48295013902', 20242025, 1),
(69, '2025-01-15', '295013916', '48295013902', 20242025, 1),
(70, '2025-01-15', '295013917', '48295013902', 20242025, 1),
(71, '2025-01-15', '295013918', '48295013902', 20242025, 1),
(72, '2025-01-15', '295013919', '48295013902', 20242025, 1),
(73, '2025-01-15', '295013920', '48295013902', 20242025, 1);

-- --------------------------------------------------------

--
-- Table structure for table `siswa`
--

CREATE TABLE `siswa` (
  `nis` varchar(11) NOT NULL,
  `nama_siswa` varchar(50) NOT NULL,
  `jenis_kelamin` enum('Laki-laki','Perempuan') NOT NULL,
  `alamat` text NOT NULL,
  `email` varchar(50) NOT NULL,
  `no_telp` varchar(14) NOT NULL,
  `agama` enum('Islam','Kristen','Katolik','Hindu','Buddha','Konghuchu') NOT NULL,
  `id_kelas` int(11) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`nis`, `nama_siswa`, `jenis_kelamin`, `alamat`, `email`, `no_telp`, `agama`, `id_kelas`, `tanggal_lahir`, `password`) VALUES
('295013901', 'Natania Idoo', 'Perempuan', 'Tangerang', 'natania@gmail.com', '081296784300', 'Islam', 1, '2006-02-19', '$2y$10$DbsfThpqijErYi8AWqCDAeZYDF.01DTSGsY/bf1tZfHBZjVgNEhTe'),
('295013902', 'Kayla Adelia', 'Perempuan', 'Tulungagung', 'kayla@gmail.com', '083895013477', 'Islam', 1, '2006-05-20', '$2y$10$WHx569bZm1JPl4zYf3ZuN.O4ItHhwPkvo8xm8n7.NNnTOEJZMqC5y'),
('295013903', 'Farid Handoko', 'Laki-laki', 'Cirebon', 'farid@gmail.com', '085827019433', 'Islam', 1, '2006-04-03', '$2y$10$aY6/OYL6RwFN62jPL6ndFubA9biKUBnlU12lX0p0wXuSOTbbvOMWq'),
('295013904', 'Prananja Dylan', 'Laki-laki', 'Tasikmalaya', 'prananja@gmail.com', '087812663490', 'Islam', 1, '2006-09-14', '$2y$10$6P2OCyJp.5E.Ou/psVC9huruuKoax/tgT5DPa3iUc04g1WHQ1ttNO'),
('295013905', 'Syahrani Puan', 'Perempuan', 'Bekasi', 'syahrani@gmail.com', '087826118902', 'Islam', 1, '2006-06-12', '$2y$10$6.Mob6SbkYdbCROnwQczZ.AgC/eJzM7zlGQQzOKMI6DIy/2CayazW'),
('295013906', 'Widdah Abrilla', 'Perempuan', 'Jakarta Timur', 'widdah@gmail.com', '081275883506', 'Islam', 1, '2006-05-23', '$2y$10$nbYGUCsE7Gb0WTT6fgYtMO/rPcqLaApxOCKS1N7TqHifAN66Ew/86'),
('295013907', 'Natasha Paramitha', 'Perempuan', 'Jakarta', 'natasha@gmail.com', '085842167784', 'Islam', 1, '2006-05-14', '$2y$10$DaLT4wAHb9I0sbLTUEfqWuMCQkJOogjh1IYhG2XaLqPesmUdvfe.C'),
('295013908', 'Sahda Noerhaliza', 'Perempuan', 'Depok', 'sahda@gmail.com', '081254678321', 'Islam', 1, '2006-07-04', '$2y$10$EefaiFpDbsWRXKjrXImUPuWkbmaoOzjLr7q27OSTjyFqtRtvg5s6m'),
('295013909', 'Fahri Husun', 'Laki-laki', 'Jakarta Utara', 'fahri@gmail.com', '085831460942', 'Islam', 1, '2006-12-19', '$2y$10$RDfmAH/GRMbXJNugPFcCEuF/aMvWyym9xNcY317vgi0e24NINny66'),
('295013910', 'Reza Zulfaqih', 'Laki-laki', 'Tangerang', 'reza@gmail.com', '085274559032', 'Islam', 1, '2006-12-09', '$2y$10$pyk12duwotnP2qsaTDKH8OtzRluErnz61GzJpv995Ob.Pg2KLiwhO'),
('295013911', 'Khadeeja Azwar', 'Perempuan', 'Bekasi', 'khadeeja@gmail.com', '083892085664', 'Islam', 8, '2006-04-12', '$2y$10$6Zb3C5rosXTMZz6gaAOH/eDX6WSGOUSjcvnczYDmpDXYvhtfxhR4u'),
('295013912', 'Hafidzur Rochman', 'Laki-laki', 'Jakarta Utara', 'hafidzur@gmail.com', '081246882910', 'Islam', 8, '2006-02-09', '$2y$10$7Ke7gbOAk1kXUc6l2ktx2.pDnIe1gzNIXejecH3nl6Vf.hEKKomeq'),
('295013913', 'Laudziya Farha', 'Perempuan', 'Jakarta Selatan', 'laudziya@gmail.com', '081364790244', 'Islam', 8, '2006-10-05', '$2y$10$Zi1Q6ZclwqDJednnKAnq0.81DJ.dDL3Te94hTVyGCP7kYa6BSsXeu'),
('295013914', 'Malwa Ghaisani', 'Perempuan', 'Bogor', 'malwa@gmail.com', '087846119026', 'Islam', 8, '0006-07-10', '$2y$10$O9wE.yZGsg9007TmYMNxkuhW.fdSPVMRDnIkDIh2FUmoMgXnj8PWi'),
('295013915', 'Ridwan Sudais', 'Laki-laki', 'Tangerang', 'ridwan@gmail.com', '083819002452', 'Islam', 8, '2006-08-16', '$2y$10$Ldgol1ZwqZ/3yf0d.dB92uemknB/DJFAFcmDe0i39.H32kW.sPRXO'),
('295013916', 'Shofi Hanani', 'Perempuan', 'Bogor', 'shofi@gmail.com', '081365773092', 'Islam', 8, '2006-11-21', '$2y$10$Ux7NoXRcJth9VrgdlTQXAu6mHrBqTIwSHNc92YXsO1s2p5SzO7IZq'),
('295013917', 'Yusuf Hamdani', 'Laki-laki', 'Bogor', 'yusuf@gmail.com', '089523517833', 'Islam', 8, '2006-02-09', '$2y$10$ImJWTxrQAoKM/3Ck/4f5KOwDSWy4HRJoDlNG6bfmQULsDg0GM8u9S'),
('295013918', 'Neyza Mulyeni Putri', 'Perempuan', 'Jakarta', 'neyza@gmail.com', '081265883410', 'Islam', 8, '2006-04-09', '$2y$10$CH.sMFWOjreG2VRu4nYKdeVxk2n40bcdb7cXEqsrbhlgtH1hb4tO.'),
('295013919', 'Fathur Rizieq', 'Laki-laki', 'Jambi', 'fathur@gmail.com', '087843801192', 'Islam', 8, '2006-12-07', '$2y$10$z6llD6GOUrGsbR69HnKR6.1kyG8hsG3lipBvr3Fq2DAk4SxVzKOOi'),
('295013920', 'Nurul Izzah', 'Perempuan', 'Bogor', 'nurul@gmail.com', '089572810277', 'Islam', 8, '2006-03-27', '$2y$10$lqaZJkPlLDn5dRubT0ZKF.LpphfEKMi73O0lwkpZ/bj2Q5/aXfQvm'),
('295013921', 'Sarah Nada Nabila', 'Perempuan', 'Depok', 'sarah@gmail.com', '081298002246', 'Islam', 9, '2006-07-11', '$2y$10$BxoXP8mclW0ePgBvRzbgZOLgKf8ct9vLgqVumxzDX063ClVW86jDK'),
('295013922', 'Rizki Ramadhan', 'Laki-laki', 'Jakarta Utara', 'rizki@gmail.com', '083982170664', 'Islam', 9, '2006-03-08', '$2y$10$k3Wwc1erzLs0I7JsPWMbaeyJ7uliLLjpEwh9XuKK9LrEOoFIzAhla'),
('295013923', 'Nayla Rabbani', 'Perempuan', 'Bogor', 'nayla@gmail.com', '081327880215', 'Islam', 9, '2006-05-09', '$2y$10$77CY7cLcTKJkOkmLLzBZF.d5QJVkqNBWgtEMSkdqVst9Bz037ORsG'),
('295013924', 'Farhatun Nabila', 'Perempuan', 'Tangerang', 'farhatun@gmail.com', '081290542281', 'Islam', 9, '2006-12-31', '$2y$10$oKBpAtkdFjzJDPixmu7ah.5qBdMR65TFqgQymhzIU0dT7DH8AZBoG'),
('295013925', 'Ahmad Faqih', 'Laki-laki', 'Depok', 'ahmad@gmail.com', '087824116598', 'Islam', 9, '2006-07-01', '$2y$10$ErMBl0i4TX8WMJiS5nf9T.Sznr5jDS3D5ZIz9r.g1L1pyqqz8tNri'),
('295013926', 'Raisa Nabila', 'Perempuan', 'Tangerang Selatan', 'raisa@gmail.com', '087835269932', 'Islam', 9, '2006-01-20', '$2y$10$KUSN72wgr3E7NjP2tQuN5.02lFQ365RkrQt3LMaR64oeSZApB8w.O'),
('295013927', 'Afwa Zazkia', 'Perempuan', 'Bekasi', 'afwa@gmail.com', '083892105634', 'Islam', 9, '2006-08-20', '$2y$10$9Cjaokah62T7dXdF/2D0jep5a6lmeErXCHwk2DiR0e.vA5S1sGlxW'),
('295013928', 'Khairulnisa', 'Perempuan', 'Jakarta ', 'khairulnisa@gmail.com', '089527182366', 'Islam', 9, '2006-07-10', '$2y$10$GXtN5/12ZortqvpD4IQD8umas2xVfcxCyGP3ow.j0bY0w2R4Ek.bG'),
('295013929', 'Yusuf Satria', 'Laki-laki', 'Bekasi', 'yusuf@gmail.com', '081283944528', 'Islam', 9, '2006-12-08', '$2y$10$G1QOfiPi5Kf8U15zr5Py..j02mfx/Fv6KDwgF02/HpMVftYFPZrXq'),
('295013930', 'Muhammad Rofiudin', 'Laki-laki', 'Jakarta ', 'rofiudin@gmail.com', '083812557290', 'Islam', 9, '2006-09-18', '$2y$10$MLNAiUt6X1J1YjM6RwIxUuqZaSmIvM57VwWSPOBf6le4Dt2mlFw0a'),
('295013931', 'Teges Alia', 'Perempuan', 'Bogor', 'teges@gmail.com', '087832461187', 'Islam', 11, '2006-04-23', '$2y$10$T.tuD4FIcQp0sw/7xGnCCe0Tv23H6uiN3Mlo.f66u2J5bKW8AfklG'),
('295013932', 'Nadya Ulya', 'Perempuan', 'Tegal', 'nadya@gmail.com', '081374663802', 'Islam', 11, '2006-10-09', '$2y$10$fzc.4dygDljtJDtMrDXh8eXAYxzHGzOvcaVdzhPuBRiGjpAG3fETi'),
('295013933', 'Rifaldi', 'Laki-laki', 'Jakarta', 'rifaldi@gmail.com', '083821904267', 'Islam', 11, '2006-11-09', '$2y$10$UMxa8rTtR4fSuOc5mGUk3uQsZ3L0AoOH80Mqy7QEA1yWrMfxBZBN6'),
('295013934', 'Kayla Hasna', 'Perempuan', 'Bogor', 'kayla@gmail.com', '085829110534', 'Islam', 11, '0006-09-13', '$2y$10$bAEqFMayrDPof4XjL6ROvel8uHjWYGfsgkb6wMngjmIpdD0ONMS0q'),
('295013935', 'Richi Mahesa', 'Laki-laki', 'Jakarta Selatan', 'richi@gmail.com', '085834226056', 'Islam', 11, '2006-06-23', '$2y$10$xYNuG/rnOk6zKwEUnIV7uewUCiXpimeQsc/xlRqwLa2w4MiDeOao6'),
('295013936', 'Dzihni Habibi', 'Laki-laki', 'Bogor', 'dzihni@gmail.com', '089577246128', 'Islam', 11, '2006-04-07', '$2y$10$ReFsyonuYG6SnsDg25eVdujKJUN4x4evKTrPJWhBbJrzGeS5TriMu'),
('295013937', 'Adrian Ahmad', 'Laki-laki', 'Tangerang', 'adrian@gmail.com', '085276945516', 'Islam', 11, '2006-04-07', '$2y$10$VPVP9uAv24sMkfHAc1vwdOuzFWFUcHBe.Gxb.7v4TubjGnClKhphC'),
('295013938', 'Syabna Naftali', 'Perempuan', 'Bogor', 'syabna@gmail.com', '081265830094', 'Islam', 11, '2006-10-05', '$2y$10$XGVvfl3PPEGTMDA0KgZUq.Kil26M1bVZxpzBXdc3to1HBYn7Bc0Zu'),
('295013939', 'Sofura Salima', 'Perempuan', 'Jakarta Utara', 'sofura@gmail.com', '085834221906', 'Islam', 11, '2006-03-12', '$2y$10$UoBvx62aCYMOHUzPo/8xmO75O//r/q/UG2sb6Erg0lcyuepCN4EhC'),
('295013940', 'Siti Nayla', 'Perempuan', 'Tangerang Selatan', 'siti@gmail.com', '089527189024', 'Islam', 11, '2006-10-12', '$2y$10$u1ZpELETDC6D71j8O6yEDOCFy2EkuIJjL2WtQC7SJQVyJiBpvnLd2');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id_admin`);

--
-- Indexes for table `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id_chat`),
  ADD KEY `chats_ibfk_1` (`guru_id`),
  ADD KEY `chats_ibfk_2` (`murid_id`);

--
-- Indexes for table `guru`
--
ALTER TABLE `guru`
  ADD PRIMARY KEY (`nip`);

--
-- Indexes for table `kelas`
--
ALTER TABLE `kelas`
  ADD PRIMARY KEY (`id_kelas`),
  ADD KEY `kelas_ibfk_1` (`nip`);

--
-- Indexes for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  ADD PRIMARY KEY (`id_mapel`),
  ADD KEY `mata_pelajaran_ibfk_1` (`nip`);

--
-- Indexes for table `nilai`
--
ALTER TABLE `nilai`
  ADD PRIMARY KEY (`id_nilai`),
  ADD KEY `id_raport` (`id_raport`),
  ADD KEY `nilai_ibfk_2` (`nis`),
  ADD KEY `nilai_ibfk_1` (`id_mapel`);

--
-- Indexes for table `raport`
--
ALTER TABLE `raport`
  ADD PRIMARY KEY (`id_raport`),
  ADD KEY `raport_ibfk_2` (`nip`),
  ADD KEY `raport_ibfk_1` (`nis`);

--
-- Indexes for table `siswa`
--
ALTER TABLE `siswa`
  ADD PRIMARY KEY (`nis`),
  ADD KEY `siswa_ibfk_1` (`id_kelas`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id_admin` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `chats`
--
ALTER TABLE `chats`
  MODIFY `id_chat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kelas`
--
ALTER TABLE `kelas`
  MODIFY `id_kelas` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  MODIFY `id_mapel` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `nilai`
--
ALTER TABLE `nilai`
  MODIFY `id_nilai` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=184;

--
-- AUTO_INCREMENT for table `raport`
--
ALTER TABLE `raport`
  MODIFY `id_raport` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `chats`
--
ALTER TABLE `chats`
  ADD CONSTRAINT `chats_ibfk_1` FOREIGN KEY (`guru_id`) REFERENCES `guru` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `chats_ibfk_2` FOREIGN KEY (`murid_id`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `kelas`
--
ALTER TABLE `kelas`
  ADD CONSTRAINT `kelas_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `guru` (`nip`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `mata_pelajaran`
--
ALTER TABLE `mata_pelajaran`
  ADD CONSTRAINT `mata_pelajaran_ibfk_1` FOREIGN KEY (`nip`) REFERENCES `guru` (`nip`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `nilai`
--
ALTER TABLE `nilai`
  ADD CONSTRAINT `nilai_ibfk_1` FOREIGN KEY (`id_mapel`) REFERENCES `mata_pelajaran` (`id_mapel`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nilai_ibfk_2` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `nilai_ibfk_3` FOREIGN KEY (`id_raport`) REFERENCES `raport` (`id_raport`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `raport`
--
ALTER TABLE `raport`
  ADD CONSTRAINT `raport_ibfk_1` FOREIGN KEY (`nis`) REFERENCES `siswa` (`nis`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `raport_ibfk_2` FOREIGN KEY (`nip`) REFERENCES `guru` (`nip`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `siswa`
--
ALTER TABLE `siswa`
  ADD CONSTRAINT `siswa_ibfk_1` FOREIGN KEY (`id_kelas`) REFERENCES `kelas` (`id_kelas`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
