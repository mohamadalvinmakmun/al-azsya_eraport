<?php 

$host = "localhost";
$db_name = "alasaera_eraport";
$user = "root";
$pass = "";

$conn = new mysqli($host, $user, $pass, $db_name);

if ($conn->connect_error) {
    die("Connection failed: ".$conn->connect_error);
}

?>