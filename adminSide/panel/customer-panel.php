<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php include '../inc/dashHeader.php'; ?>
<style>
    .wrapper{ width: 60%; padding-left: 200px; padding-top: 20px }
</style>

<div class="wrapper">
    <div class="container-fluid pt-5 pl-600">
        <div class="row">
            <div class="m-50">
                <div class="mt-5 mb-3">
                    <h2 class="pull-left">Membership Details</h2>
                    <a href="../customerCrud/createCust.php" class="btn btn-outline-dark"><i class="fa fa-plus"></i> Add Membership</a>
                </div>
                <div class="mb-3">
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <input required type="text" id="search" name="search" class="form-control" placeholder="Enter Member ID, Name">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;" >
                                <a href="customer-panel.php" class="btn btn-light">Show All</a>
                            </div>
                        </div>
                    </form>
                </div>
                <?php
                // Include config file
                require_once "../config.php"; // ini menyediakan variabel $pdo

                try {
                    if (isset($_POST['search']) && !empty($_POST['search'])) {
                        $search = "%" . $_POST['search'] . "%";

                        $sql = "SELECT * 
                                FROM memberships 
                                WHERE member_name LIKE :search 
                                   OR member_id = :exact
                                ORDER BY member_id";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindValue(':search', $search, PDO::PARAM_STR);
                        $stmt->bindValue(':exact', $_POST['search'], PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM memberships ORDER BY member_id";
                        $stmt = $pdo->query($sql);
                    }

                    $rows = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    if ($rows && count($rows) > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th style='width:7em;'>Member Id</th>";
                        echo "<th>Member Name</th>";
                        echo "<th style='width:7em;'>Points</th>";
                        echo "<th>Account ID</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        foreach ($rows as $row) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['member_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['member_name']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['points']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['account_id']) . "</td>";
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
