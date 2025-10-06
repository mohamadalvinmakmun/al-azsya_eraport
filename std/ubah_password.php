<?php

require_once '../connection.php';
require_once '../model/siswa.php';

session_start();
if (!isset($_SESSION['login']) || $_SESSION['login'] == false) {
    header('location: ../logout');
    exit();
}

$userid = $_SESSION['id'];
$login_as = $_SESSION['login_as'];

if ($login_as != "siswa") {
    header('location: ../index');
    exit();
}

$status = "";

if (isset($_POST["submit"])) {
    $old_password = $_POST["old_password"];
    $new_password = $_POST["new_password"];
    $confirm_password = $_POST["confirm_password"];

    $siswa = new Siswa();
    $is_valid = $siswa->cek_login_siswa($userid, $old_password);

    if (!$is_valid) {
        $status = "Password lama salah!";
        echo '<script>window.onload = function() { var myModal = new bootstrap.Modal(document.getElementById("errorModal")); myModal.show(); }</script>';
    } elseif ($new_password !== $confirm_password) {
        $status = "Password baru dan konfirmasi password tidak cocok!";
        echo '<script>window.onload = function() { var myModal = new bootstrap.Modal(document.getElementById("errorModal")); myModal.show(); }</script>';
    } else {
        $hashed_password = password_hash($new_password, PASSWORD_DEFAULT);
        $update_status = $siswa->update_password($userid, $hashed_password);

        if ($update_status) {
            $status = "Password berhasil diubah!";
            echo '<script>window.onload = function() { var myModal = new bootstrap.Modal(document.getElementById("successModal")); myModal.show(); }</script>';
        } else {
            $status = "Gagal mengubah password!";
            echo '<script>window.onload = function() { var myModal = new bootstrap.Modal(document.getElementById("errorModal")); myModal.show(); }</script>';
        }
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ubah Password</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(135deg, rgb(107, 223, 255) 0%, rgb(80, 158, 234) 100%);
            color: #fff;
            font-family: 'Arial', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            overflow: hidden;
            animation: fadeIn 1s ease-in-out;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
            }
            to {
                opacity: 1;
            }
        }

        .card {
            background-color: rgba(255, 255, 255, 0.9);
            border: none;
            border-radius: 10px;
            box-shadow: 0px 4px 15px rgba(0, 0, 0, 0.1);
            color: #333;
            transform: scale(0.9);
            animation: popIn 0.5s ease-in-out forwards;
            width: 100%;
            max-width: 500px;
        }

        @keyframes popIn {
            from {
                transform: scale(0.5);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .form-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }

        .form-container .form-label {
            font-weight: bold;
            color: rgb(80, 158, 234);
        }

        .form-container .form-control {
            margin-bottom: 15px;
        }

        .d-grid {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
        }

        .btn-primary {
            background: linear-gradient(135deg, rgb(107, 223, 255) 0%, rgb(80, 158, 234) 100%);
            border: none;
            transition: transform 0.3s ease, background 0.3s ease;
            width: 100%;
        }

        .btn-primary:hover {
            background: linear-gradient(135deg, rgb(80, 158, 234) 0%, rgb(107, 223, 255) 100%);
            transform: scale(1.05);
        }

        .btn-secondary {
            background-color: rgb(80, 158, 234);
            border: none;
            color: #fff;
            transition: transform 0.3s ease, background 0.3s ease;
            width: 100%;
        }

        .btn-secondary:hover {
            background-color: rgb(107, 223, 255);
            transform: scale(1.05);
        }

        .alert {
            animation: slideDown 0.5s ease-in-out;
            font-weight: bold;
        }

        /* Modal Styles */
        .modal-content {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0px 4px 20px rgba(0, 0, 0, 0.1);
            transform: scale(0.95);
            animation: popInModal 0.5s ease-in-out forwards;
        }

        @keyframes popInModal {
            from {
                transform: scale(0.5);
                opacity: 0;
            }
            to {
                transform: scale(1);
                opacity: 1;
            }
        }

        .modal-header {
            background-color: rgb(80, 158, 234);
            color: #fff;
            border-bottom: 2px solid #ddd;
            padding: 15px;
            font-weight: bold;
            text-align: center;
        }

        .modal-header .btn-close {
            background-color: #fff;
            color: rgb(80, 158, 234);
            font-size: 1.2rem;
            border: none;
        }

        .modal-body {
            text-align: center;
            padding: 30px;
            font-size: 1.1rem;
            color: #333;
        }

        .modal-footer {
            display: flex;
            justify-content: space-between;
            padding: 15px;
            background-color: #f8f9fa;
            border-top: 1px solid #ddd;
        }

        .modal-footer .btn-secondary {
            background-color: rgb(80, 158, 234);
            color: #fff;
            border-radius: 5px;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .modal-footer .btn-secondary:hover {
            background-color: rgb(107, 223, 255);
            transform: scale(1.05);
        }

        .modal-footer .btn-primary {
            background-color: rgb(107, 223, 255);
            border-radius: 5px;
            color: #fff;
            transition: transform 0.3s ease, background 0.3s ease;
        }

        .modal-footer .btn-primary:hover {
            background-color: rgb(80, 158, 234);
            transform: scale(1.05);
        }

        @keyframes slideDown {
            from {
                transform: translateY(-20px);
                opacity: 0;
            }
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card p-4">
                    <h2 class="text-center mb-4">Ubah Password</h2>
                    <?php if ($status): ?>
                        <div class="alert <?php echo strpos($status, 'berhasil') !== false ? 'alert-success' : 'alert-danger'; ?> text-center">
                            <?php echo $status; ?>
                        </div>
                    <?php endif; ?>
                    <form action="" method="POST">
                        <div class="mb-3">
                            <label for="old_password" class="form-label">Password Lama</label>
                            <input type="password" class="form-control" id="old_password" name="old_password" required>
                        </div>
                        <div class="mb-3">
                            <label for="new_password" class="form-label">Password Baru</label>
                            <input type="password" class="form-control" id="new_password" name="new_password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirm_password" class="form-label">Konfirmasi Password Baru</label>
                            <input type="password" class="form-control" id="confirm_password" name="confirm_password" required>
                        </div>
                        <div class="d-grid gap-2">
                            <button type="submit" class="btn btn-primary" name="submit">Ubah Password</button>
                            <a href="./profil" class="btn btn-secondary">Kembali</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Success Modal -->
    <div class="modal fade" id="successModal" tabindex="-1" aria-labelledby="successModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="successModalLabel">Berhasil</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Password Anda telah berhasil diubah!
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <a href="./profil" class="btn btn-primary">Kembali ke Profil</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Error Modal -->
    <div class="modal fade" id="errorModal" tabindex="-1" aria-labelledby="errorModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="errorModalLabel">Gagal</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <?php echo $status; ?>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Tutup</button>
                    <a href="./profil" class="btn btn-primary">Kembali ke Profil</a>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
