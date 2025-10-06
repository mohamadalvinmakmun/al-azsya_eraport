<?php

require_once '../connection.php';
require_once '../model/siswa.php';

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

session_start();
if (!isset($_SESSION['login']) || $_SESSION['login'] == false) {
    header('location: ../logout');
    exit();
}

$userid = $_SESSION['id'];
$login_as = $_SESSION['login_as'];

if (!isset($_SESSION['login_as']) || $_SESSION['login_as'] != "siswa") {
    header('location: ../index');
    exit();
}

$siswa = new Siswa();

$result = $siswa->get_detail_siswa($userid);


?>

<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <title>Profil | E-Raport</title>
    <link rel="stylesheet" href="style.css">
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<style>
    body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fa;
            margin: 0;
            padding: 0;
        }

        .btn-warning {
            position: relative;
            transition: all 0.3s ease;
        }

        .btn-warning::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            border-radius: 5px;
            background: rgba(255, 255, 0, 0.3);
            opacity: 0;
            transition: opacity 0.3s ease, transform 0.3s ease;
            transform: scale(1.5);
            z-index: -1;
        }

        .btn-warning:hover::after {
            opacity: 1;
            transform: scale(1);
        }

        .btn-warning:hover {
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(255, 193, 7, 0.4);
        }

        .konten {
            margin: 2rem;
        }

        .konten_title {
            font-size: 2rem;
            color: #333;
            margin-bottom: 1rem;
            text-align: center;
        }

        .konten_profil_foto img {
            border-radius: 50%;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        }

        .konten_table {
            margin-top: 1.5rem;
        }

        table {
            background: #fff;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }

        table td {
            padding: 10px;
        }
        /* Animasi untuk Sidebar (Slide In) */
.navigation {
    transform: translateX(-100%);
    animation: slideIn 0.8s forwards;
}

@keyframes slideIn {
    from {
        transform: translateX(-100%);
    }
    to {
        transform: translateX(0);
    }
}

/* Animasi untuk Fade In pada Konten */
.konten {
    opacity: 0;
    animation: fadeIn 1s 0.8s forwards;
}

@keyframes fadeIn {
    from {
        opacity: 0;
    }
    to {
        opacity: 1;
    }
}

/* Hover Animasi pada Tombol */
button {
    transition: transform 0.2s ease, background-color 0.2s ease;
}

button:hover {
    transform: scale(1.05);
    background-color: #28a745;
    color: white;
}

/* Animasi Hover untuk Item Sidebar */
.navigation ul li a {
    transition: background-color 0.3s, padding-left 0.3s;
}

.navigation ul li a:hover {
    background-color: #007bff;
    padding-left: 15px;
}
</style>

<body>
    <div class="container">
        <div class="navigation">
            <ul>
                <li>
                    <a href="#">
                        <span class="icon"></span>
                        <h1 class="title">E-Raport</h1>
                    </a>
                </li>
                <li>
                    <a href="../index">
                        <span class="icon"><i class='bx bx-grid-alt'></i></span>
                        <span class="title">Dashboard</span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="#">
                        <span class="icon"><i class='bx bx-user'></i></span>
                        <span class="title">Profil</span>
                    </a>
                </li>
                <li>
                    <a href="pesan">
                        <span class="icon"><i class='bx bx-chat'></i></span>
                        <span class="title">Pesan</span>
                    </a>
                </li>
                <li>
                    <a href="prestasi">
                        <span class="icon"><i class='bx bxs-graduation'></i></span>
                        <span class="title">Prestasi</span>
                    </a>
                </li>
                <li>
                    <a href="../logout">
                        <span class="icon"><i class='bx bx-exit'></i></span>
                        <span class="title">Logout</span>
                    </a>
                </li>
            </ul>
        </div>
    </div>


    <!-- main -->
    <div class="main">
        <div class="topbar">
            <div class="toggle">
                <i class='bx bx-menu'></i>
            </div>
            <!-- user -->
            <div class="user">
                                <?php 
                if ($login_as == "siswa") {
                    $pp = "../assets/img/pp/std.png";
                } elseif ($login_as == "guru") {
                    $pp = "../assets/img/pp/guru.png";
                } elseif ($login_as == "admin") {
                    $pp = "../assets/img/pp/admin.png";
                }
                ?>
                <img src="<?php echo $pp; ?>" alt="user">
            </div>
        </div>

        <div class="konten">
            <h2 class="konten_title">
                Profil Siswa
            </h2>
            <div class="konten_isi" id="data-pribadi">
                <div class="konten_profil">
                    <div class="konten_profil_foto">
                        <img src="../assets/img/pp/std.png" alt="user" title="Foto profil siswa" />
                    </div>
                </div>
                <div class="konten_pengaturan" data-aos="fade-left">
                    <a href="./ubah_password" class="btn btn-warning">Ganti Password</a>
                </div>
                <div class="konten_table table-responsive">
                    <table class="table table-bordered konten_profil_biodata">
                        <tbody>
                            <tr>
                                <td>Nama</td>
                                <td><?php echo $result['nama_siswa'] ?></td>
                            </tr>
                            <tr>
                                <td>Nomor Induk Siswa</td>
                                <td><?php echo $result['nis'] ?></td>
                            </tr>
                            <tr>
                                <td>Alamat</td>
                                <td><?php echo $result['alamat'] ?></td>
                            </tr>
                            <tr>
                                <td>Nomor Telepon</td>
                                <td><?php echo $result['no_telp'] ?></td>
                            </tr>
                            <tr>
                                <td>Email</td>
                                <td><?php echo $result['email'] ?></td>
                            </tr>
                            <tr>
                                <td>Tanggal Lahir</td>
                                <td><?php echo $result['tanggal_lahir'] ?></td>
                            </tr>
                            <tr>
                                <td>Jenis Kelamin</td>
                                <td><?php echo $result['jenis_kelamin'] ?></td>
                            </tr>
                            <tr>
                                <td>Agama</td>
                                <td><?php echo $result['agama'] ?></td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="../assets/js/main.js"></script>
</body>

</html>