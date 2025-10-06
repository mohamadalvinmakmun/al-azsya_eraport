<?php

require_once dirname(__FILE__) . '/../connection.php';

class Data
{
    private $conn;

    public function __construct()
    {
        global $conn;
        $this->conn = $conn;
    }

    public function tambah_data_guru($nip, $nama_guru, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $status, $tanggal_lahir, $password)
    {
        $query = "CALL tambah_data_guru(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssssss", $nip, $nama_guru, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $status, $tanggal_lahir, $password);
        $result = $stmt->execute();
        $stmt->close();
        return $result;
    }

    public function ubah_data_guru($nip, $nama_guru, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $status, $tanggal_lahir, $password)
    {
        $query = "CALL ubah_data_guru(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssssss", $nip, $nama_guru, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $status, $tanggal_lahir, $password);
        $result = $stmt->execute();
        $stmt->close();
        return $result;
    }

    public function tambah_data_siswa($nis, $nama_siswa, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $kelas, $tanggal_lahir, $password)
    {
        $query = "CALL tambah_data_siswa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssssss", $nis, $nama_siswa, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $kelas, $tanggal_lahir, $password);
        $result = $stmt->execute();
        $stmt->close();
        return $result;
    }

    public function ubah_data_siswa($nis, $nama_siswa, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $kelas, $tanggal_lahir, $password)
    {
        $query = "CALL ubah_data_siswa(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        $stmt = $this->conn->prepare($query);
        $stmt->bind_param("ssssssssss", $nis, $nama_siswa, $jenis_kelamin, $alamat, $email, $no_telp, $agama, $kelas, $tanggal_lahir, $password);
        $result = $stmt->execute();
        $stmt->close();
        return $result;
    }
}
