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
        // Buat DSN sesuai driver (koneksi awal tanpa DB_NAME)
        if ($dbDriver === 'mysql') {
            $dsn = "mysql:host=$dbHost;port=$dbPort;charset=utf8mb4";
        } elseif ($dbDriver === 'pgsql') {
            $dsn = "pgsql:host=$dbHost;port=$dbPort;dbname=postgres"; // connect ke DB default postgres
        } elseif ($dbDriver === 'sqlite') {
            $dsn = "sqlite:$dbName";
        } else {
            throw new Exception("Driver $dbDriver belum didukung.");
        }

        // Koneksi ke server DB
        $pdo = new PDO($dsn, $dbUser, $dbPass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        ]);

        echo "Koneksi berhasil ke server DB dengan driver $dbDriver.<br>";

        // Buat database kalau MySQL atau PostgreSQL
        if ($dbDriver === 'mysql') {
            $pdo->exec("CREATE DATABASE IF NOT EXISTS `$dbName` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;");
            echo "Database '$dbName' created successfully.<br>";
        } elseif ($dbDriver === 'pgsql') {
            $stmt = $pdo->prepare("SELECT 1 FROM pg_database WHERE datname = :dbname");
            $stmt->execute([':dbname' => $dbName]);

            if (!$stmt->fetch()) {
                $pdo->exec("CREATE DATABASE \"$dbName\";");
                echo "Database '$dbName' created successfully.<br>";
            } else {
                echo "Database '$dbName' already exists.<br>";
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
            if (!file_exists($filename)) {
                echo "SQL file $filename not found.<br>";
                return;
            }

            $sql = file_get_contents($filename);

            try {
                $pdo->exec($sql);
                echo "SQL from $filename executed successfully.<br>";
                file_put_contents('setup_completed.flag', 'Setup completed successfully.');
            } catch (PDOException $e) {
                echo "Error executing SQL in $filename: " . $e->getMessage() . "<br>";
            }
        }

        // Tentukan file SQL sesuai driver
        if ($dbDriver === 'mysql') {
            $sqlFile = __DIR__ . '/restaurantdb_mysql.sql';
        } elseif ($dbDriver === 'pgsql') {
            $sqlFile = __DIR__ . '/db_new.sql';
        } else {
            $sqlFile = __DIR__ . '/restaurantdb.txt'; // fallback
        }

        executeSQLFromFile($sqlFile, $pdo);

    } catch (PDOException $e) {
        die("Koneksi gagal: " . $e->getMessage());
    }
}
?>

<a href="customerSide/home/home.php">Home</a>