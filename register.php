<?php
// Mengatur header untuk memungkinkan akses dari berbagai sumber (CORS)
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST, GET, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type");

// Periksa apakah permintaan menggunakan metode POST
if ($_SERVER['REQUEST_METHOD'] == "POST") {
    // Ambil data yang dikirimkan melalui POST
    $email = $_POST['email'] ?? null;
    $password = $_POST['password'] ?? null;
    $nama = $_POST['nama'] ?? null;
    $alamat = $_POST['alamat'] ?? null;
    $telepon = $_POST['telepon'] ?? null;

    // Periksa apakah semua field diisi
    if (!empty($email) && !empty($password) && !empty($nama) && !empty($alamat) && !empty($telepon)) {
        // Hash password untuk keamanan
        $hashed_password = password_hash($password, PASSWORD_DEFAULT);

        // Siapkan query untuk memasukkan data ke database
        // Menggunakan prepared statement untuk mencegah SQL injection
        $stmt = $connect->prepare("INSERT INTO users (email, password, nama, alamat, telepon, createdDate) VALUES (?, ?, ?, ?, ?, NOW())");

        // Bind parameter ke dalam prepared statement
        $stmt->bind_param("sssss", $email, $hashed_password, $nama, $alamat, $telepon);

        // Jalankan query
        if ($stmt->execute()) {
            // Jika berhasil, berikan respons sukses
            $response = [
                'status' => 'success',
                'message' => 'Registrasi berhasil'
            ];
        } else {
            // Jika gagal, berikan respons error
            $response = [
                'status' => 'error',
                'message' => 'Gagal menyimpan data: ' . $stmt->error
            ];
        }

        // Tutup statement
        $stmt->close();
    } else {
        // Jika ada field yang kosong, berikan pesan error
        $response = [
            'status' => 'error',
            'message' => 'Semua field wajib diisi'
        ];
    }
} else {
    // Jika permintaan bukan POST, berikan pesan error
    $response = [
        'status' => 'error',
        'message' => 'Permintaan tidak valid'
    ];
}

// Kembalikan respons dalam format JSON
header('Content-Type: application/json');
echo json_encode($response);