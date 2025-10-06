<!DOCTYPE html>
<html lang="id">

<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Profil SMA Islam Al-Azsya</title>
	<link href="https://fonts.googleapis.com/css?family=Lato:700%7CMontserrat:400,600" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="css/bootstrap.min.css" />
	<link rel="stylesheet" href="css/font-awesome.min.css">
	<link type="text/css" rel="stylesheet" href="css/style.css" />

	<style>
		body {
			font-family: 'Montserrat', sans-serif;
			background-color: #f0f8ff;
			animation: fadeInBody 1.5s ease-in;
		}

		@keyframes fadeInBody {
			from {
				opacity: 0;
			}

			to {
				opacity: 1;
			}
		}

		.hero-area {
			text-align: center;
			padding: 100px 0;
			background: url('./img/gedung8.jpg') no-repeat center center;
			background-size: 100%;
			color: white;
			animation: slideInDown 1.5s;
			position: relative;
		}

		.hero-area::before {
			content: "";
			position: absolute;
			top: 0;
			left: 0;
			width: 100%;
			height: 100%;
			/* Ubah opacity sesuai kebutuhan */
		}


		.hero-area .logo-center {
			width: 180px;
			height: 180px;
			border-radius: 50%;
			margin-bottom: 20px;
			animation: bounceIn 1.5s;
		}

		@keyframes bounceIn {
			from {
				transform: scale(0.5);
				opacity: 0;
			}

			to {
				transform: scale(1);
				opacity: 1;
			}
		}

		.header-container {
			background: linear-gradient(to right, #2c3e50, #3498db);
			padding: 10px 0;
			box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		}

		.navbar-header .logo {
			width: 80px;
			height: 80px;
			border-radius: 50%;
			transition: transform 0.3s ease-in-out;
		}

		.navbar-header .logo:hover {
			transform: rotate(360deg);
		}

		.navbar-nav li a {
			color: white !important;
			font-weight: bold;
			transition: color 0.3s;
		}

		.navbar-nav li a:hover {
			color: rgb(255, 255, 255) !important;
		}

		.navbar-nav {
			display: flex;
			align-items: center;
			height: 80px;
			/* Sesuaikan dengan tinggi header */
		}

		.navbar-nav>li {
			display: flex;
			align-items: center;
		}

		.menu-toggle {
			display: none;
			font-size: 24px;
			cursor: pointer;
			color: white;
			position: absolute;
			right: 20px;
			top: 20px;
		}



		@media (max-width: 768px) {
			/* .navbar-header {
				display: flex;
				justify-content: space-between;
				align-items: center;
			} */

			#nav {
				display: none;
				flex-direction: column;
				background: #2c3e50;
				position: absolute;
				top: 60px;
				left: 0;
				height: 25vh;
				width: 50%;
				text-align: center;
				padding: 10px 0;
				z-index: 1000;
			}

			#nav.active {
				display: flex;
			}

			.navbar-nav {
				flex-direction: column;
				width: 100%;
			}

			.navbar-nav li {
				padding: 10px 0;
			}

			.menu-toggle {
				display: block;
				font-size: 24px;
				cursor: pointer;
				color: white;
			}
		}
		



		.btn-primary {
			background-color: rgb(255, 255, 255);
			border: none;
			transition: background-color 0.3s, transform 0.2s;
		}

		.btn-primary:hover {
			background-color: rgb(255, 255, 255);
			transform: scale(1.1);
		}

		.hero-area h1 {
			animation: fadeIn 2s;
		}

		.hero-area p {
			font-style: italic;
		}

		.section {
			padding: 60px 0;
			text-align: center;
			animation: fadeInUp 2s ease-in;
		}

		@keyframes fadeInUp {
			from {
				transform: translateY(50px);
				opacity: 0;
			}

			to {
				transform: translateY(0);
				opacity: 1;
			}
		}

		.quote {
			font-style: italic;
			font-size: 1.2em;
			margin-top: 20px;
			animation: fadeIn 2s;
		}

		.activity-img {
			width: 100%;
			height: auto;
			border-radius: 10px;
			transition: transform 0.3s, box-shadow 0.3s;
		}

		.activity-img:hover {
			transform: scale(1.05);
			box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
		}
	</style>
</head>

<body>
<header id="header" class="header-container">
    <div class="container">
        <div class="navigation">
            <div class="navbar-header">
                <a class="logo"><img src="./img/al-azysa3.webp" alt="logo" class="logo"></a>
                <span class="menu-toggle" onclick="toggleMenu()">&#9776;</span>
            </div>
            <nav id="nav" class="collapse navbar-collapse">
                <ul class="main-menu nav navbar-nav navbar-right">
                    <li><a href="#about">Tentang</a></li>
                    <li><a href="#activities">Kegiatan</a></li>
                    <li><a href="./utama">Login</a></li>
                </ul>
            </nav>
        </div>
    </div>
</header>

<style>
    .collapse {
        display: none;
    }

    .collapse.show {
        display: block;
    }

    .menu-toggle {
        cursor: pointer;
        font-size: 24px;
    }
</style>

<script>
    function toggleMenu() {
        let nav = document.getElementById("nav");
        nav.classList.toggle("show");
    }

    document.addEventListener("click", function (event) {
        let nav = document.getElementById("nav");
        let menuToggle = document.querySelector(".menu-toggle");

        // Cek apakah klik terjadi di luar navbar dan tombol menu
        if (!nav.contains(event.target) && !menuToggle.contains(event.target)) {
            nav.classList.remove("show");
        }
    });
</script>

	<div class="hero-area">
		<img src="./img/al-azysa3.webp" alt="Logo SMA Islam Al-Azsya" class="logo-center">
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
		<h1> </h1>
		<br>
		<p> </p>
		<br>
	</div>

	<div id="about" class="section">
		<h1>Selamat Datang di SMA Islam Al-Azsya</h1>
		<h2>Tentang Al-Azsya</h2>
		<div style="background-color: #ffffff; padding: 20px; border-radius: 10px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2); max-width: 800px; margin: 0 auto; text-align: justify;">
			<p><strong>SMA Islam Al-Azsya</strong> adalah lembaga pendidikan yang berlandaskan nilai-nilai Islam, berkomitmen untuk mencetak generasi yang berakhlak mulia, cerdas, dan berdaya saing tinggi.</p>
			<p>Dengan sistem pendidikan yang terpadu antara ilmu pengetahuan umum dan pendidikan agama, kami berupaya membentuk siswa yang tidak hanya unggul secara akademik tetapi juga memiliki karakter Islami yang kuat.</p>
			<p>Didukung oleh tenaga pendidik profesional dan berbagai fasilitas modern, SMA Islam Al-Azsya menjadi tempat terbaik untuk menempa ilmu dan membangun masa depan yang gemilang.</p>
		</div>
	</div>

	<div id="activities" class="section">
		<h2>Kegiatan Sekolah</h2>
		<div class="row">
			<div class="col-md-4">
				<img src="./img/penghafal.webp" class="activity-img">
				<p>Program Tahfidz Al-Qur'an </p>
			</div>
			<div class="col-md-4">
				<img src="./img/atletik.webp" alt="Robotika" class="activity-img">
				<p>Kelas Atletik</p>
			</div>
			<div class="col-md-4">
				<img src="./img/pramuka.webp" alt="Tahfidz" class="activity-img">
				<p>Pramuka</p>
			</div>
		</div>
	</div>

	<div id="contact" class="section">
		<h2>Kontak Kami</h2>
		<p>Alamat: Jl. H. Naman Swakarsa II No.41</p>
		<p>Email: alazsya@outlook.com</p>
		<p>Telepon: (021) 123456789</p>
	</div>

	<footer class="section text-center">
		<p>&copy; 2025 SMA Islam Al-Azsya. </p>

	</footer>
</body>

</html>