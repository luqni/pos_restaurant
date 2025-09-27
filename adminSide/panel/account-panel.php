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
                    <h2 class="pull-left">Account Details</h2>
                    <a href="../staffCrud/createStaff.php" class="btn btn-outline-dark"><i class="fa fa-plus"></i> Add Staff</a>
                    <a href="../customerCrud/createCust.php" class="btn btn-outline-dark"><i class="fa fa-plus"></i> Add memberships</a>
                </div>
                
                <div class="mb-3">
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <input required type="text" id="search" name="search" class="form-control" placeholder="Enter Account ID, Email">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;" >
                                <a href="account-panel.php" class="btn btn-light">Show All</a>
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
                        $sql = "SELECT *
                                FROM accounts
                                WHERE email LIKE :search OR account_id LIKE :search
                                ORDER BY account_id";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindParam(':search', $search, PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM accounts ORDER BY account_id";
                        $stmt = $pdo->query($sql);
                    }

                    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

                    if ($results && count($results) > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Account ID</th>";
                        echo "<th>Email</th>";
                        echo "<th>Register Date</th>";
                        echo "<th>Phone Number</th>";
                        echo "<th>Password</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        foreach ($results as $row) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['account_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['email']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['register_date']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['phone_number']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['password']) . "</td>";
                            echo "</tr>";
                        }
                        echo "</tbody>";
                        echo "</table>";
                    } else {
                        echo '<div class="alert alert-danger"><em>No records were found.</em></div>';
                    }
                } catch (PDOException $e) {
                    echo "Oops! Something went wrong. Please try again later.";
                    // Debug (opsional):
                    // echo $e->getMessage();
                }
                ?>
            </div>
        </div>
    </div>
</div>

<?php include '../inc/dashFooter.php'; ?>
