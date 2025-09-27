<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php include '../inc/dashHeader.php'; ?>   
<style>
    .wrapper { width: 50%; padding-left: 200px; padding-top: 20px }
</style>
<div class="wrapper">
    <div class="container-fluid pt-5 pl-600">
        <div class="row">
            <div class="m-50">
                <div class="mt-5 mb-3">
                    <h2 class="pull-left">Table Details</h2>
                    <a href="../tableCrud/createTable.php" class="btn btn-outline-dark">
                        <i class="fa fa-plus"></i> Add Table
                    </a>
                </div>
                <div class="mb-3">
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <input required type="text" id="search" name="search" class="form-control" placeholder="Enter Table ID, Capacity">
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;">
                                <a href="table-panel.php" class="btn btn-light">Show All</a>
                            </div>
                        </div>
                    </form>
                </div>
                <?php
                // Include config file (PDO $pdo)
                require_once "../config.php";

                try {
                    if (isset($_POST['search']) && !empty($_POST['search'])) {
                        $search = "%" . $_POST['search'] . "%";
                        $sql = "SELECT * 
                                FROM restaurant_tables
                                WHERE table_id LIKE :search 
                                   OR capacity LIKE :search
                                ORDER BY table_id";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindParam(':search', $search, PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM restaurant_tables ORDER BY table_id";
                        $stmt = $pdo->query($sql);
                    }

                    if ($stmt->rowCount() > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Table ID</th>";
                        echo "<th>Capacity</th>";
                        echo "<th>Availability</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['table_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['capacity']) . " Persons</td>";
                            echo "<td>" . ($row['is_available'] ? "Yes" : "No") . "</td>";
                            echo "</tr>";
                        }
                        echo "</tbody>";
                        echo "</table>";
                    } else {
                        echo '<div class="alert alert-danger"><em>No records were found.</em></div>';
                    }
                } catch (PDOException $e) {
                    echo "Oops! Something went wrong. " . $e->getMessage();
                }
                ?>
            </div>
        </div>        
    </div>
</div>

<?php include '../inc/dashFooter.php'; ?>
