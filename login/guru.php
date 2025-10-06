<?php

require_once "../connection.php";
require_once "../model/guru.php";

session_start();
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

if (isset($_SESSION['login'])) {
    header("location: ../index");
}

if (isset($_POST["login"])) {
    $nip = $_POST["nip"];
    $password = $_POST["password"];

    $guru = new Guru();
    $verifikasi = $guru->cek_login_guru($nip, $password);

    if ($verifikasi) {
        $info_guru = $guru->get_detail_guru($nip);
        // set session
        $_SESSION['login'] = true;
        $_SESSION['id'] = $info_guru['nip'];
        $_SESSION['login_as'] = 'guru';
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
            animation: fadeInUp 1.2s ease-in-out;
        }

        .login_box {
            width: 100%;
            margin-bottom: 15px;
            position: relative;
            display: flex;
            justify-content: center;
            animation: fadeInUp 1s ease-in-out;
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
            animation: inputFocus 0.6s ease;
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
            animation: fadeInUp 1.5s ease-in-out;
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

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
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

        @keyframes inputFocus {
            from {
                border-color: #ddd;
            }

            to {
                border-color: rgb(107, 223, 255);
            }
        }
    </style>

    <title>Login Guru</title>
</head>

<body>
    <div class="login">
        <div class="login_content">
            <div class="login_img">
                <img src="./img/al-azysa3.webp" alt="" />
            </div>
            <div class="login_forms">
                <form action="./guru" class="login_register" id="login-in" method="POST">
                    <h1 class="login_title" align="center">GURU</h1>
                    <?php
                    if (isset($status) && $status == "gagal") {
                        echo "<div class='alert alert-danger' role='alert'>Login gagal. Silahkan ulangi!</div>";
                    }
                    ?>
                    <div class="login_box">
                        <i class="fas fa-user"></i>
                        <input type="text" placeholder="Nomor Induk Pegawai" class="login_input" name="nip">
                    </div>

                    <div class="login_box">
                        <i class="fas fa-lock"></i>
                        <input type="password" placeholder="Password" class="login_input" name="password">
                    </div>
                    <div class="login_box">
                        <button type="submit" class="login_button" id="login" name="login">Login</button>
                    </div>
                    <div class="login_box">
                        <a href="utama" class="login_button" style="background: #aaa; color: #fff; text-decoration: none; padding: 8px 15px; font-size: 0.9rem; width: auto; text-align: center; display: inline-block;">Kembali ke Halaman Utama</a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script src="../assets/js/main.js"></script>
</body>

</html>