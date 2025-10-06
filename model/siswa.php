<?php 

require_once dirname(__FILE__) . '/../config_sekolah.php';
require_once dirname(__FILE__) .'/../connection.php';

class Siswa {
    public function get_detail_siswa($nis)
    {
        global $conn;
        $query = "SELECT * FROM siswa WHERE nis = '$nis'";
        $result = $conn->query($query);
        if ($result) {
            if ($result->num_rows === 1) {
                $siswa = $result->fetch_assoc();
                return $siswa;
            }
        } 
        return false;

    }

    public function cek_login_siswa($nis, $password)
    {
        $siswa = $this->get_detail_siswa($nis);
        if (!$siswa) {
            return false;
        }
        $db_password = $siswa['password'];
        $verify = password_verify($password, $db_password);
        if ($verify) {
            return true;
        } else {
            return false;
        }
    }

    public function get_nama_siswa($nis)
    {
        $result = $this->get_detail_siswa($nis);
        if ($result) {
            $nama_siswa = $result['nama_siswa'];
            return $nama_siswa;
        } else {
            return false;
        }
    }

    public function get_wali_kelas($nis)
    {
        global $conn;
        $query = "SELECT guru.nip, guru.nama_guru, guru.jenis_kelamin FROM siswa INNER JOIN kelas ON siswa.id_kelas = kelas.id_kelas
        INNER JOIN guru ON kelas.nip = guru.nip WHERE nis = '$nis'";
        echo $conn->error;
        $result = $conn->query($query);
        if ($result) {
            $row = $result->fetch_assoc();
            return $row;
        }
    }
    public function get_kelas_siswa($nis)
    {
        global $conn;
        $query = "SELECT nama_kelas FROM siswa,kelas WHERE siswa.id_kelas=kelas.id_kelas AND nis=$nis";
        $result = $conn->query($query);
        if ($result && $result->num_rows > 0) {
            $row = $result->fetch_assoc();
            return $row['nama_kelas'];
        } else {
            return false;
        }
    }

    public function get_daftar_siswa_by_kelas($id_kelas, $limit, $offset)
    {
        global $conn;
        $query = "SELECT * FROM siswa WHERE id_kelas = $id_kelas LIMIT $limit OFFSET $offset";
        $result = $conn->query($query);
        if ($result) {
            return $result;
        } else {
            return false;
        }
    }
    public function update_password($nis, $new_password) {
        global $conn;
        $query = "UPDATE siswa SET password = ? WHERE nis = ?";
        $stmt = $conn->prepare($query);
        $stmt->bind_param('ss', $new_password, $nis);
    
        return $stmt->execute();
    }    
    public function cek_nilai_tersedia_semester($nis, $semester)
{
    global $conn; // Pastikan koneksi database tersedia di fungsi ini

    // Query untuk memeriksa ketersediaan nilai
    $query = "SELECT COUNT(*) AS jumlah FROM nilai WHERE nis = ? AND semester = ?";

    // Siapkan statement
    if ($stmt = $conn->prepare($query)) {
        // Bind parameter
        $stmt->bind_param("si", $nis, $semester);

        // Eksekusi query
        $stmt->execute();

        // Dapatkan hasil
        $result = $stmt->get_result();
        $row = $result->fetch_assoc();

        // Periksa apakah nilai tersedia
        return $row['jumlah'] > 0;
    } else {
        // Jika terjadi kesalahan pada statement
        die("Error preparing statement: " . $conn->error);
    }
}
}
?>