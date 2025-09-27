<?php
require_once __DIR__ . '/env_loader.php';
loadEnv(__DIR__ . '/.env');

// Check if setup has already been completed
if (file_exists('setup_completed.flag')) {
    echo "Setup has already been completed. The SQL setup won't run again.";
} else {
    // Ambil konfigurasi dari .env
    $dbDriver = getenv('DB_DRIVER') ?: 'mysql'; // mysql, pgsql, sqlite, dll
    $dbHost   = getenv('DB_HOST') ?: 'localhost';
    $dbPort   = getenv('DB_PORT') ?: ($dbDriver === 'pgsql' ? '5432' : '3306');
    $dbUser   = getenv('DB_USER') ?: 'root';
    $dbPass   = getenv('DB_PASS') ?: 'P@ssw0rd';
    $dbName   = getenv('DB_NAME') ?: 'restaurantdb';

    try {
        // Buat DSN sesuai driver
        if ($dbDriver === 'mysql') {
            $dsn = "mysql:host=$dbHost;port=$dbPort;charset=utf8mb4";
        } elseif ($dbDriver === 'pgsql') {
            $dsn = "pgsql:host=$dbHost;port=$dbPort";
        } elseif ($dbDriver === 'sqlite') {
            $dsn = "sqlite:$dbName";
        } else {
            throw new Exception("Driver $dbDriver belum didukung.");
        }

        // Koneksi ke server DB (tanpa DB_NAME dulu untuk create database)
        $pdo = new PDO($dsn, $dbUser, $dbPass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ]);

        echo "Koneksi berhasil ke server DB dengan driver $dbDriver.<br>";

        // Buat database kalau MySQL atau PostgreSQL
        if (in_array($dbDriver, ['mysql', 'pgsql'])) {
            $sqlCreateDB = "CREATE DATABASE IF NOT EXISTS $dbName";
            if ($dbDriver === 'pgsql') {
                // PostgreSQL tidak dukung `IF NOT EXISTS` dengan cara sama
                $sqlCreateDB = "SELECT 1 FROM pg_database WHERE datname='$dbName'";
                $stmt = $pdo->query($sqlCreateDB);
                if (!$stmt->fetch()) {
                    $pdo->exec("CREATE DATABASE $dbName");
                    echo "Database '$dbName' created successfully.<br>";
                } else {
                    echo "Database '$dbName' already exists.<br>";
                }
            } else {
                $pdo->exec($sqlCreateDB);
                echo "Database '$dbName' created successfully.<br>";
            }
        }

        // Reconnect langsung ke database spesifik
        if ($dbDriver === 'mysql') {
            $dsn = "mysql:host=$dbHost;port=$dbPort;dbname=$dbName;charset=utf8mb4";
        } elseif ($dbDriver === 'pgsql') {
            $dsn = "pgsql:host=$dbHost;port=$dbPort;dbname=$dbName";
        }

        $pdo = new PDO($dsn, $dbUser, $dbPass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ]);

        // Jalankan SQL dari file
        function executeSQLFromFile($filename, $pdo) {
            $sql = file_get_contents($filename);
            try {
                $pdo->exec($sql);
                echo "SQL statements executed successfully.<br>";
                file_put_contents('setup_completed.flag', 'Setup completed successfully.');
            } catch (PDOException $e) {
                echo "Error executing SQL: " . $e->getMessage() . "<br>";
            }
        }

        executeSQLFromFile('restaurantdb.txt', $pdo);

    } catch (PDOException $e) {
        die("Koneksi gagal: " . $e->getMessage());
    }
}
?>

<a href="customerSide/home/home.php">Home</a>