<?php
// Mengatur header agar dapat diakses oleh berbagai sumber (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Menghubungkan ke database
require "connect.php";

header('Content-Type: application/json');

$servername = "localhost"; // Ganti dengan nama server database Anda
$username = "root"; // Ganti dengan username database Anda
$password = ""; // Ganti dengan password database Anda
$dbname = "db_latihan"; // Ganti dengan nama database Anda

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    echo json_encode(['value' => 0, 'message' => 'Koneksi gagal: ' . $conn->connect_error]);
    exit;
}

// Mendapatkan email dari request POST
$email = isset($_POST['email']) ? $_POST['email'] : '';

if (empty($email)) {
    echo json_encode(['value' => 0, 'message' => 'Email tidak boleh kosong.']);
    exit;
}

// Memeriksa apakah email ada di tabel `users`
$sql = "SELECT * FROM users WHERE email = ?";
$stmt = $conn->prepare($sql);
$stmt->bind_param("s", $email);
$stmt->execute();
$result = $stmt->get_result();

if ($result->num_rows === 0) {
    echo json_encode(['value' => 0, 'message' => 'Email tidak ditemukan.']);
    exit;
}

// Menghasilkan token reset password
$token = bin2hex(random_bytes(50)); // Token acak 50 karakter
$expires = date("U") + 3600; // Token berlaku selama 1 jam

// Menyimpan token ke tabel `password_resets`
$sql = "INSERT INTO password_resets (email, token, expires) VALUES (?, ?, ?)";
$stmt = $conn->prepare($sql);
$stmt->bind_param("ssi", $email, $token, $expires);
$stmt->execute();

// Mengirim email reset password
$to = $email;
$subject = "Reset Password Anda";
$message = "Klik tautan berikut untuk mereset password Anda:\n";
$message .= "http://localhost/reset_password.php?token=" . $token;
$headers = "From: noreply@localhost"; // Alamat pengirim

if (mail($to, $subject, $message, $headers)) {
    echo json_encode(['value' => 1, 'message' => 'Email reset password telah dikirim.']);
} else {
    echo json_encode(['value' => 0, 'message' => 'Gagal mengirim email.']);
}

$stmt->close();
$conn->close();
?>
