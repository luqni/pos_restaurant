<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php include '../inc/dashHeader.php'; ?>
<style>
    .wrapper{ width: 85%; padding-left: 200px; padding-top: 20px }
</style>

<div class="wrapper">
    <div class="container-fluid pt-5 pl-600">
        <div class="row">
            <div class="m-50">
                <div class="mt-5 mb-3">
                    <h2 class="pull-left">Search bills Details</h2>
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <input required type="text" id="search" name="search" class="form-control" placeholder="Enter Bill ID, Table ID, Card ID, Payment Method">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;">
                                <a href="bill-panel.php" class="btn btn-light">Show All</a>
                            </div>
                        </div>
                    </form>
                </div>
                
                <?php
                // Include config file (PDO connection: $pdo)
                require_once "../config.php";
                
                try {
                    if (isset($_POST['search']) && !empty($_POST['search'])) {
                        $search = "%" . $_POST['search'] . "%";
                        $sql = "SELECT * FROM bills 
                                WHERE table_id LIKE :search 
                                   OR payment_method LIKE :search 
                                   OR bill_id LIKE :search 
                                   OR card_id LIKE :search
                                ORDER BY bill_id";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindParam(':search', $search, PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM bills ORDER BY bill_id";
                        $stmt = $pdo->query($sql);
                    }

                    if ($stmt->rowCount() > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Bill ID</th>";
                        echo "<th>Staff ID</th>";
                        echo "<th>Member ID</th>";
                        echo "<th>Reservation ID</th>";
                        echo "<th>Table ID</th>";
                        echo "<th>Card ID</th>";
                        echo "<th>Payment Method</th>";
                        echo "<th style='width:13em'>Bill Time</th>";
                        echo "<th style='width:13em'>Payment Time</th>";
                        echo "<th>Receipt</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['bill_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['staff_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['member_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['reservation_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['table_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['card_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['payment_method']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['bill_time']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['payment_time']) . "</td>";
                            echo "<td>";
                            echo '<a href="../posBackend/receipt.php?bill_id='. urlencode($row['bill_id']) .'" title="Receipt" data-toggle="tooltip"><span class="fa fa-receipt text-black"></span></a>';
                            echo "</td>";
                            echo "</tr>";
                        }
                        echo "</tbody>";
                        echo "</table>";
                    } else {
                        echo '<div class="alert alert-danger"><em>No records were found.</em></div>';
                    }
                } catch (PDOException $e) {
                    echo "Oops! Something went wrong: " . $e->getMessage();
                }
                ?>
            </div>
        </div>
    </div>
</div>

<?php include '../inc/dashFooter.php'; ?>
