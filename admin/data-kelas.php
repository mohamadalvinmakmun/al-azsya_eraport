<?php
require_once dirname(__FILE__) . '/../connection.php';

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

if (!isset($_SESSION['login_as']) || $_SESSION['login_as'] != "admin") {
    header('location: ../index');
    exit();
}

if (!isset($_GET['p'])) {
    $page_no = 1;
} else {
    $page_no = $_GET['p'];
}

$records_per_page = 30;
$offset = ($page_no - 1) * $records_per_page;
$previous_page = $page_no - 1;
$next_page = $page_no + 1;

$result = $conn->query("SELECT COUNT(*) As total_records FROM kelas");
$total_records = $result->fetch_assoc();
$total_records = $total_records['total_records'];
$total_no_of_pages = ceil($total_records / $records_per_page);
$second_last = $total_no_of_pages - 1;
$adjacents = "2";
?>

<!DOCTYPE html>
<html lang="en" dir="ltr">

<head>
    <meta charset="UTF-8">
    <title>Data Kelas | E-Raport</title>
    <link rel="stylesheet" href="style.css">
    <!-- Boxicons CDN Link -->
    <link href='https://unpkg.com/boxicons@2.0.7/css/boxicons.min.css' rel='stylesheet'>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="../assets/css/style.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
 <style>
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
                <li>
                    <a href="data-guru">
                        <span class="icon"><i class='bx bx-user'></i></span>
                        <span class="title">Data Guru</span>
                    </a>
                </li>
                <li>
                    <a href="data-siswa">
                        <span class="icon"><i class='bx bx-user'></i></span>
                        <span class="title">Data Siswa</span>
                    </a>
                </li>
                <li class="hovered">
                    <a href="data-kelas">
                        <span class="icon"><i class='bx bx-door-open'></i></span>
                        <span class="title">Data Kelas</span>
                    </a>
                </li>
                <li>
                    <a href="data-mapel">
                        <span class="icon"><i class='bx bx-book-alt'></i></span>
                        <span class="title">Data Mapel</span>
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

        <!-- card -->
        <div class="cardBox">
            <div class="card">
                <div>
                    <?php
                    $result_kelas = $conn->query("SELECT * FROM kelas LIMIT $records_per_page OFFSET $offset");
                    if ($result_kelas && $result_kelas->num_rows > 0) {
                        $result_jml = $conn->query("SELECT COUNT(*) AS total_kelas FROM kelas");
                        $jml = $result_jml->fetch_assoc();
                        echo "<div class='numbers'>${jml['total_kelas']}</div>";
                    }
                    ?>
                    <div class="cardName">Kelas</div>
                </div>
                <div class="iconBx">
                    <i class='bx bx-door-open'></i>
                </div>
            </div>
        </div>

        <div class="konten">
            <h2 class="konten_title">
                Data Kelas
            </h2>
            <div class="konten_isi">
                <?php
                if (isset($_GET['status'])) {
                    if ($_GET['status'] == "berhasil") {
                        echo "<div class='alert alert-success alert-dismissible fade show' role='alert'>
                        Data berhasil diubah/ditambahkan!
                        <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                      </div>";
                    } else if ($_GET['status'] == "gagal") {
                        echo "<div class='alert alert-danger alert-dismissible fade show' role='alert'>
                        Data gagal diubah/ditambahkan!
                        <button type='button' class='btn-close' data-bs-dismiss='alert' aria-label='Close'></button>
                      </div>";
                    }
                }
                ?>
                <div class="konten_pengaturan">
                    <a href="tambah-data-kelas"><button type="button" class="btn btn-success">Tambah kelas</button></a>
                </div>
                <div class="konten_table table-responsive">
                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>Kelas</th>
                                <th>Jumlah Siswa</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $result_kelas = $conn->query("SELECT * FROM kelas LIMIT $records_per_page OFFSET $offset");
                            if ($result_kelas && $result_kelas->num_rows > 0) {
                                $no = 1;
                                while ($row = $result_kelas->fetch_assoc()) {
                                    $id_kls = $row['id_kelas'];
                                    $result_jml = $conn->query("SELECT COUNT(*) AS total_siswa FROM siswa WHERE id_kelas = $id_kls");
                                    $jml = $result_jml->fetch_assoc();
                                    echo "
                                    <tr>
                                        <td>$no</td>
                                        <td>${row['nama_kelas']}</td>
                                        <td>${jml['total_siswa']}</td>
                                        <td class='aksi'>
                                            <a href='ubah-data-kelas?id-kelas=${row['id_kelas']}'><button type='button' data-bs-toggle='tooltip' class='btn btn-primary btn-sm' title='Ubah'><i class='bx bx-pencil'></i></button></a>
                                            <button type='button' class='btn btn-danger btn-sm' title='Hapus' data-bs-toggle='modal' data-bs-target='#confirmDeleteModal' data-href='hapus-data-kelas?id-kelas=${row['id_kelas']}'><i class='bx bx-trash'></i></button>
                                        </td>
                                    </tr>
                                    ";
                                    $no++;
                                }
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
            <div class="konten_nav">
                <nav aria-label="Page navigation example">
                    <ul class="pagination">
                        <?php
                        if ($total_no_of_pages > 1) {
                        ?>
                            <li class="page-item"><a class="page-link" href="<?php echo "?$previous_page"; ?>">Previous</a></li>
                            <?php
                            for ($i = 1; $i <= $total_no_of_pages; $i++) {
                            ?>
                                <li class='page-item <?php echo $i == $page_no ? "active" : "" ?>'><a class='page-link' href='<?php echo "?p=$i"; ?>'><?php echo $i; ?></a></li>
                            <?php
                            }
                            ?>
                            <li class="page-item"><a class="page-link" href="<?php echo "?$next_page" ?>">Next</a></li>
                        <?php
                        }
                        ?>
                    </ul>
                </nav>
            </div>
        </div>
    </div>

    <!-- Modal Konfirmasi Hapus -->
    <div class="modal fade" id="confirmDeleteModal" tabindex="-1" aria-labelledby="confirmDeleteModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmDeleteModalLabel">Konfirmasi Hapus</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin ingin menghapus data kelas ini?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <a href="#" id="confirmDeleteButton" class="btn btn-danger">Hapus</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.addEventListener("DOMContentLoaded", function () {
            const confirmDeleteModal = document.getElementById('confirmDeleteModal');
            const confirmDeleteButton = document.getElementById('confirmDeleteButton');

            confirmDeleteModal.addEventListener('show.bs.modal', function (event) {
                const button = event.relatedTarget;
                const href = button.getAttribute('data-href');
                confirmDeleteButton.setAttribute('href', href);
            });
        });
    </script>
</body>

</html>
