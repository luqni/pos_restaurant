<?php
session_start(); // Ensure session is started
require_once 'checkIfLoggedIn.php';
include '../inc/dashHeader.php';
require_once '../config.php'; // Di config ada $pdo (PDO connection)
?>

<!DOCTYPE html>
<html>
<head>
    <link href="../css/pos.css" rel="stylesheet" />
</head>
<body>

<div class="container" style="text-align: center; width:100%; margin-top:3rem; margin-left: 2rem;">
    <div id="POS-Content" class="row">
        <div class="row center-middle">
            <div class="col-md-15" style="margin-left: 17rem; margin-top: 0rem;max-height: 700px; overflow-y: auto;">
                <div class="row justify-content-center">
                    <?php
                    try {
                        // Fetch all tables from the database
                        $stmt = $pdo->query("SELECT * FROM restaurant_tables ORDER BY table_id");
                        $tables = $stmt->fetchAll(PDO::FETCH_ASSOC);

                        $table_count = 0;
                        foreach ($tables as $row) {
                            if ($table_count % 5 == 0) {
                                echo '</div><div class="row justify-content-center">';
                            }

                            $table_id = $row['table_id'];
                            $capacity = $row['capacity'];

                            // Ambil bill terbaru untuk table_id ini
                            $stmtBill = $pdo->prepare("SELECT bill_id FROM bills WHERE table_id = :table_id ORDER BY bill_time DESC LIMIT 1");
                            $stmtBill->execute(['table_id' => $table_id]);
                            $latestBillData = $stmtBill->fetch(PDO::FETCH_ASSOC);

                            date_default_timezone_set('Asia/Singapore'); 

                            $selectedDate = date("Y-m-d");
                            $endTime = date("H:i:s");
                            $startTime = date("H:i:s", strtotime($endTime) - (20 * 60));

                            // Check reservation
                            $stmtRes = $pdo->prepare("
                                SELECT * FROM reservations 
                                WHERE table_id = :table_id 
                                  AND reservation_date = :reservation_date 
                                  AND reservation_time BETWEEN :start_time AND :end_time
                            ");
                            $stmtRes->execute([
                                'table_id' => $table_id,
                                'reservation_date' => $selectedDate,
                                'start_time' => $startTime,
                                'end_time' => $endTime,
                            ]);
                            $isReserved = $stmtRes->rowCount() > 0;

                            if ($latestBillData) {
                                $latestBillID = $latestBillData['bill_id'];

                                // Cek apakah ada bill_items
                                $stmtBillItems = $pdo->prepare("SELECT COUNT(*) FROM bill_items WHERE bill_id = :bill_id");
                                $stmtBillItems->execute(['bill_id' => $latestBillID]);
                                $billItemsCount = $stmtBillItems->fetchColumn();

                                if ($billItemsCount > 0) {
                                    $billItemColor = 'rgb(216, 0, 50)'; // ada item → merah
                                } else {
                                    $billItemColor = 'rgb(23, 89, 74)'; // tidak ada item → hijau
                                }

                                // Cek payment_time
                                $stmtPayment = $pdo->prepare("SELECT payment_time FROM bills WHERE bill_id = :bill_id");
                                $stmtPayment->execute(['bill_id' => $latestBillID]);
                                $paymentTime = $stmtPayment->fetchColumn();

                                $hasPaymentTime = !empty($paymentTime);
                                $box_color = $hasPaymentTime ? 'rgb(23, 89, 74)' : $billItemColor;
                            } else {
                                $latestBillID = null;
                                $box_color = 'gray'; // tidak ada bill
                            }

                            echo '<div class="col-md-2 mb-3">';
                            if ($isReserved) {
                                echo '<a href="orderItem.php?bill_id=' . $latestBillID . '&table_id=' . $table_id . '" class="btn btn-primary btn-block btn-lg" 
                                    style="color:black; background-color: rgb(248, 222, 34);
                                    justify-content: center; align-items: center; display: flex; width: 9rem; height: 9rem;">
                                    Table: ' . $table_id . '<br>Capacity: ' . $capacity;
                            } else {
                                echo '<a href="orderItem.php?bill_id=' . $latestBillID . '&table_id=' . $table_id . '" class="btn btn-primary btn-block btn-lg" 
                                    style="background-color: ' . $box_color . ';
                                    justify-content: center; align-items: center; display: flex; width: 9rem; height: 9rem;">
                                    Table: ' . $table_id . '<br>Capacity: ' . $capacity;
                            }
                            echo '</a></div>';
                            $table_count++;
                        }
                    } catch (PDOException $e) {
                        echo "Error fetching tables: " . htmlspecialchars($e->getMessage());
                    }
                    ?>
                </div>

                <div class="row d-flex justify-content-around" style="margin-top: 2rem;">
                    <div class="col-md-3">
                        <div class="alert alert-success" role="alert" style="color:white;background-color: rgb(23, 89, 74);" 
                             data-toggle="tooltip" data-placement="top" title="Tables That are Free">
                            Available
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="alert alert-danger" role="alert" style="color:white;background-color: rgb(216, 0, 50);" 
                             data-toggle="tooltip" data-placement="top" title="Tables That are Used">
                            Occupied
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="alert alert-warning" style="color:black;background-color: rgb(248, 222, 34);" role="alert" 
                             data-toggle="tooltip" data-placement="top" title="Tables That are Reserved">
                            Reserved
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<?php include '../inc/dashFooter.php' ?>
