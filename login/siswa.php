<?php

require_once '../connection.php';
require_once '../model/siswa.php';

session_start();
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_SESSION['login'])) {
    header("location: ../index");
}

if (isset($_POST["login"])) {
    $nis = $_POST["nis"];
    $password = $_POST["password"];

    $siswa = new Siswa();
    $verifikasi = $siswa->cek_login_siswa($nis, $password);

    if ($verifikasi) {
        $info_siswa = $siswa->get_detail_siswa($nis);
        // set session
        $_SESSION['login'] = true;
        $_SESSION['id'] = $info_siswa['nis'];
        $_SESSION['login_as'] = 'siswa';
        header("location: ../index");
        exit();
    } else {
        $status = "gagal";
    }
}

?>



<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <!-- <link rel="stylesheet" href="../assets/css/style-login.css"> -->
    <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"> -->
    <script src="https://kit.fontawesome.com/158e244731.js" crossorigin="anonymous"></script>
    <style>
        body {
            background: linear-gradient(135deg, rgb(107, 223, 255), #2575fc);
            height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            font-family: 'Arial', sans-serif;
            margin: 0;
        }

        .login {
            background: #fff;
            border-radius: 15px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            width: 100%;
            max-width: 400px;
            animation: fadeIn 1s ease;
        }

        .login_forms {
            display: flex;
            flex-direction: column;
            align-items: center;
            width: 100%;
        }

        .login_content {
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 30px;
        }

        .login_img img {
            width: 100px;
            margin-bottom: 20px;
            animation: bounce 2s infinite;
            border-radius: 50%;
            object-fit: cover;
        }

        .login_title {
            font-size: 1.5rem;
            font-weight: bold;
            color: rgb(107, 223, 255);
            margin-bottom: 20px;
        }

        .login_box {
            width: 100%;
            margin-bottom: 15px;
            position: relative;
            display: flex;
            justify-content: center;
        }

        .login_box i {
            position: absolute;
            top: 50%;
            left: 10px;
            transform: translateY(-50%);
            color: rgb(107, 223, 255);
        }


        .login_input {
            width: 90%;
            max-width: 350px;
            padding: 10px 10px 10px 35px;
            border: 1px solid #ddd;
            border-radius: 5px;
            outline: none;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .login_input:focus {
            border-color: rgb(107, 223, 255);
        }

        .login_button {
            width: 50%;
            max-width: 350px;
            padding: 10px;
            background: rgb(107, 223, 255);
            border: none;
            border-radius: 5px;
            color: #fff;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: background 0.3s ease;
            text-align: center;
        }

        .login_button:hover {
            background: #2575fc;
        }

        .alert-danger {
            font-size: 0.9rem;
            margin-bottom: 20px;
            text-align: center;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }

            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {

            0%,
            100% {
                transform: translateY(0);
            }

            50% {
                transform: translateY(-10px);
            }
        }
    </style>

    <title>Login Siswa</title>
</head>

<body>
    <div class="login">
        <div class="login_content">
            <div class="login_img">
                <img src="./img/al-azysa3.webp" alt="Login Icon">
            </div>
            <form action="./siswa" class="login_register" id="login-in" method="POST">
                <h1 class="login_title" align="center">SISWA</h1>
                <?php
                if (isset($status) && $status == "gagal") {
                    echo "
                    <div class='alert alert-danger' role='alert'>Login gagal. Silahkan ulangi!</div>
                    ";
                }
                ?>
                <div class="login_box">
                    <i class="fas fa-user"></i>
                    <input type="text" placeholder="Nomor Induk Siswa" class="login_input" name="nis" required>
                </div>

                <div class="login_box">
                    <i class="fas fa-lock"></i>
                    <input type="password" placeholder="Password" class="login_input" name="password" required>
                </div>
                <div class="login_box">
                    <button type="submit" href="#" class="login_button" id="login" name="login">Login</button>
                </div>

                <div class="login_box">
                    <a href="utama" class="login_button" style="background: #aaa; color: #fff; text-decoration: none; padding: 8px 15px; font-size: 0.9rem; width: auto; text-align: center; display: inline-block;">Kembali ke Halaman Utama</a>
                </div>


            </form>
        </div>
    </div>
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>

</html>