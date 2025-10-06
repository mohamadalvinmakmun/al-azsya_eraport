<?php
session_start();

// If a user is already logged in, redirect them to the index page
if (isset($_SESSION['login']) && $_SESSION['login'] == true) {
    header("location: ../index");
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Page</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet"> <!-- Add Font Awesome -->
    <style>
        /* Full-page background animation */
        body {
            margin: 0;
            padding: 0;
            font-family: 'Arial', sans-serif;
            height: 100vh;
            overflow: hidden;
            display: flex;
            justify-content: center;
            align-items: center;
            background: #001f3f;
            animation: blinkColor 5s infinite alternate;
        }

        @keyframes blinkColor {
            0% {
                background: #001f3f;
            }

            50% {
                background: #0074D9;
            }

            100% {
                background: #001f3f;
            }
        }

        /* Login container styling */
        .login-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            text-align: center;
            width: 100%;
            max-width: 400px;
            z-index: 1;
        }

        .login-container h2 {
            color: #0074D9;
            font-size: 28px;
            margin-bottom: 30px;
        }

        .login-button {
            display: inline-block;
            padding: 12px 24px;
            margin: 10px;
            background: #0074D9;
            color: white;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            font-size: 18px;
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.15);
            transition: all 0.3s ease;
        }

        .login-button:hover {
            background: #0056b3;
            transform: translateY(-4px);
        }

        .login-button i {
            margin-right: 8px;
        }

        .container {
            text-align: center;
            z-index: 1;
        }

        .container h1 {
            font-size: 36px;
            color: white;
            margin-bottom: 20px;
        }

        .container p {
            font-size: 18px;
            color: white;
            margin-bottom: 40px;
        }

        /* Responsive tweak for smaller screens */
        @media (max-width: 600px) {
            .container h1 {
                font-size: 28px;
            }

            .container p {
                font-size: 16px;
            }

            .login-button {
                font-size: 16px;
                padding: 10px 20px;
            }
        }
    </style>
</head>

<body>

    <div class="container">
        <h1>Welcome To Al-Azsya E-Raport System</h1>
        <p class="lead">Silakan pilih login sebagai :</p>

        <!-- Tombol Login Guru -->
        <a href="guru" class="login-button">
            <i class="fas fa-chalkboard-teacher"></i> Login Guru
        </a>

        <!-- Tombol Login Siswa -->
        <a href="siswa" class="login-button">
            <i class="fas fa-user-graduate"></i> Login Siswa
        </a>

        <!-- Tombol Login Admin -->
        <a href="admin" class="login-button">
            <i class="fas fa-user-shield"></i> Login Admin
        </a>
        <a href="./index" class="login-button">
            <i class="fas fa-home"></i> Menu Utama
        </a>
    </div>

</body>

</html>