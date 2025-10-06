<?php
// Include FPDF library
require('../fpdf182/fpdf.php');

// Database connection
$host = 'localhost';
$user = 'root';
$pass = '';
$db = 'u551918833_eraport';
$conn = new mysqli($host, $user, $pass, $db);

if ($conn->connect_error) {
    die("Koneksi gagal: " . $conn->connect_error);
}

// Ambil parameter NIS dari URL
$nis = isset($_GET['nis']) ? $_GET['nis'] : '';

if (empty($nis)) {
    die("NIS tidak ditemukan!");
}

// Query data siswa
$sql_siswa = "SELECT s.nama_siswa, s.id_kelas, k.nama_kelas 
              FROM siswa s 
              JOIN kelas k ON s.id_kelas = k.id_kelas 
              WHERE s.nis = ?";
$stmt_siswa = $conn->prepare($sql_siswa);
$stmt_siswa->bind_param("s", $nis);
$stmt_siswa->execute();
$result_siswa = $stmt_siswa->get_result();

if ($result_siswa->num_rows == 0) {
    die("Data siswa tidak ditemukan untuk NIS $nis");
}

$data_siswa = $result_siswa->fetch_assoc();
$nama_siswa = $data_siswa['nama_siswa'];
$nama_kelas = $data_siswa['nama_kelas'];

// Query data nilai khusus semester 2
$semester = 2; // Fokus pada semester 2
$sql_nilai = "SELECT n.*, m.nama_mapel 
              FROM nilai n 
              JOIN mata_pelajaran m ON n.id_mapel = m.id_mapel 
              WHERE n.nis = ? AND n.semester = ? 
              ORDER BY n.id_raport DESC";
$stmt_nilai = $conn->prepare($sql_nilai);
$stmt_nilai->bind_param("si", $nis, $semester);
$stmt_nilai->execute();
$result_nilai = $stmt_nilai->get_result();

if ($result_nilai->num_rows == 0) {
    die("Data nilai tidak ditemukan untuk semester $semester pada NIS $nis");
}

// Inisialisasi FPDF
$pdf = new FPDF();
$pdf->AddPage();
$pdf->SetFont('Arial', 'B', 16);

// Header
$pdf->Cell(0, 10, "Laporan Nilai Siswa - Semester $semester", 0, 1, 'C');
$pdf->Ln(5);

// Informasi Siswa
$pdf->SetFont('Arial', '', 12);
$pdf->Cell(30, 10, "Nama Siswa: ", 0, 0);
$pdf->Cell(0, 10, $nama_siswa, 0, 1);
$pdf->Cell(30, 10, "Kelas: ", 0, 0);
$pdf->Cell(0, 10, $nama_kelas, 0, 1);
$pdf->Cell(30, 10, "NIS: ", 0, 0);
$pdf->Cell(0, 10, $nis, 0, 1);
$pdf->Ln(10);

// Header Tabel Nilai
$pdf->SetFont('Arial', 'B', 10);
$pdf->Cell(10, 10, "No", 1, 0, 'C');
$pdf->Cell(40, 10, "Mata Pelajaran", 1, 0, 'C');
$pdf->Cell(15, 10, "CP1", 1, 0, 'C');
$pdf->Cell(15, 10, "CP2", 1, 0, 'C');
$pdf->Cell(15, 10, "CP3", 1, 0, 'C');
$pdf->Cell(15, 10, "CP4", 1, 0, 'C');
$pdf->Cell(15, 10, "UTS", 1, 0, 'C');
$pdf->Cell(15, 10, "UAS", 1, 0, 'C');
$pdf->Cell(20, 10, "Nilai Akhir", 1, 1, 'C');

// Iterasi data nilai
$pdf->SetFont('Arial', '', 10);
$no = 1;
while ($row = $result_nilai->fetch_assoc()) {
    $pdf->Cell(10, 10, $no++, 1, 0, 'C');
    $pdf->Cell(40, 10, $row['nama_mapel'], 1, 0);
    $pdf->Cell(15, 10, $row['cp1'], 1, 0, 'C');
    $pdf->Cell(15, 10, $row['cp2'], 1, 0, 'C');
    $pdf->Cell(15, 10, $row['cp3'], 1, 0, 'C');
    $pdf->Cell(15, 10, $row['cp4'], 1, 0, 'C');
    $pdf->Cell(15, 10, $row['uts'], 1, 0, 'C');
    $pdf->Cell(15, 10, $row['uas'], 1, 0, 'C');
    $pdf->Cell(20, 10, $row['nilai_akhir'], 1, 1, 'C');
}

// Footer
$pdf->Ln(10);
$pdf->SetFont('Arial', 'I', 10);
$pdf->Cell(0, 10, "Dicetak pada: " . date("d-m-Y H:i:s"), 0, 0, 'R');

// Output PDF
$pdf->Output('I', 'Laporan_Nilai_Semester2_' . $nis . '.pdf');
?>
