<?php
require_once __DIR__ . '../../env_loader.php';
loadEnv(__DIR__ . '../../.env');

// Ambil konfigurasi dari .env
$dbDriver = getenv('DB_DRIVER') ?: 'mysql'; // mysql, pgsql, sqlite
$dbHost   = getenv('DB_HOST') ?: 'localhost';
$dbPort   = getenv('DB_PORT') ?: ($dbDriver === 'pgsql' ? '5432' : '3306');
$dbUser   = getenv('DB_USER') ?: 'root';
$dbPass   = getenv('DB_PASS') ?: 'P@ssw0rd';
$dbName   = getenv('DB_NAME') ?: 'restaurantdb';

// Buat DSN
if ($dbDriver === 'mysql') {
    $dsn = "mysql:host=$dbHost;port=$dbPort;dbname=$dbName;charset=utf8mb4";
} elseif ($dbDriver === 'pgsql') {
    $dsn = "pgsql:host=$dbHost;port=$dbPort;dbname=$dbName";
} elseif ($dbDriver === 'sqlite') {
    $dsn = "sqlite:$dbName";
} else {
    die("Driver $dbDriver belum didukung.");
}

try {
    // Buat koneksi PDO
    $pdo = new PDO($dsn, $dbUser, $dbPass, [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
    ]);

    // echo "✅ Koneksi ke database berhasil dengan driver $dbDriver";
} catch (PDOException $e) {
    die("❌ Koneksi gagal: " . $e->getMessage());
}
