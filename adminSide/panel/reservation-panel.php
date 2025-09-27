<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php include '../inc/dashHeader.php'; ?>
<style>
    .wrapper{ width: 1300px; padding-left: 200px; padding-top: 20px  }
</style>
<div class="wrapper">
    <div class="container-fluid pt-5 pl-600">
        <div class="row">
            <div class="m-50">
                <div class="mt-5 mb-3">
                    <h2 class="pull-left">Reservation Details</h2>
                    <a href="../reservationsCrud/createReservation.php" class="btn btn-outline-dark"><i class="fa fa-plus"></i> Add Reservation</a>
                </div>
                <div class="mb-3">
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <input required type="text" id="search" name="search" class="form-control" placeholder="Enter Reservation ID, Customer Name, Reservation Date (2023-09)">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;" >
                                <a href="reservation-panel.php" class="btn btn-light">Show All</a>
                            </div>
                        </div>
                    </form>
                </div>
                
                <?php
                // Include PDO config file
                require_once "../config.php"; // variabel $pdo sudah tersedia dari sini

                try {
                    if (isset($_POST['search']) && !empty($_POST['search'])) {
                        $search = "%" . $_POST['search'] . "%";
                        $sql = "SELECT * 
                                FROM reservations 
                                WHERE reservation_date LIKE :search 
                                   OR reservation_id LIKE :search 
                                   OR customer_name LIKE :search
                                ORDER BY reservation_date DESC, reservation_time DESC";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindParam(':search', $search, PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM reservations ORDER BY reservation_date DESC, reservation_time DESC";
                        $stmt = $pdo->query($sql);
                    }

                    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    if ($rows && count($rows) > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Reservation ID</th>";
                        echo "<th>Customer Name</th>";
                        echo "<th>Table ID</th>";
                        echo "<th>Reservation Time</th>";
                        echo "<th>Reservation Date</th>";
                        echo "<th>Head Count</th>";
                        echo "<th>Special Request</th>";
                        echo "<th>Delete</th>";
                        echo "<th>Receipt</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        foreach ($rows as $row) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['reservation_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['customer_name']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['table_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['reservation_time']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['reservation_date']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['head_count']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['special_request']) . "</td>";
                            echo "<td>";
                            echo '<a href="../reservationsCrud/deleteReservationVerify.php?id='. urlencode($row['reservation_id']) .'" title="Delete Record" data-toggle="tooltip" '
                                   . 'onclick="return confirm(\'Admin permission Required!\n\nAre you sure you want to delete this Reservation?\n\nThis will alter other modules related to this Reservation!\n\')"><span class="fa fa-trash text-black"></span></a>';
                            echo "</td>";
                            echo "<td>";
                            echo '<a href="../reservationsCrud/reservationReceipt.php?reservation_id='. urlencode($row['reservation_id']) .'" title="Receipt" data-toggle="tooltip"><span class="fa fa-receipt text-black"></span></a>';
                            echo "</td>";
                            echo "</tr>";
                        }
                        echo "</tbody>";
                        echo "</table>";
                    } else {
                        echo '<div class="alert alert-danger"><em>No records were found.</em></div>';
                    }
                } catch (PDOException $e) {
                    echo "Oops! Something went wrong: " . htmlspecialchars($e->getMessage());
                }
                ?>
            </div>
        </div>
    </div>
</div>

<?php include '../inc/dashFooter.php'; ?>
