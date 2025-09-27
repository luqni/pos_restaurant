<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php include '../inc/dashHeader.php'; ?>
<style>
    .wrapper { width: 1300px; padding-left: 200px; padding-top: 20px }
</style>

<div class="wrapper">
    <div class="container-fluid pt-5 pl-600">
        <div class="row">
            <div class="m-50">
                <div class="mt-5 mb-3">
                    <h2 class="pull-left">Items Details</h2>
                    <a href="../menuCrud/createItem.php" class="btn btn-outline-dark"><i class="fa fa-plus"></i> Add Item</a>
                </div>
                <div class="mb-3">
                    <form method="POST" action="#">
                        <div class="row">
                            <div class="col-md-6">
                                <select name="search" id="search" class="form-control">
                                    <option value="">Select Item Type or Item Category</option>
                                    <option value="Main Dishes">Main Dishes</option>
                                    <option value="Side Snacks">Side Snacks</option>
                                    <option value="Drinks">Drinks</option>
                                    <option value="Steak & Ribs">Steak & Ribs</option>
                                    <option value="Seafood">Seafood</option>
                                    <option value="Pasta">Pasta</option>
                                    <option value="Lamb">Lamb</option>
                                    <option value="Chicken">Chicken</option>
                                    <option value="Burgers & Sandwiches">Burgers & Sandwiches</option>
                                    <option value="Bar Bites">Bar Bites</option>
                                    <option value="House Dessert">House Dessert</option>
                                    <option value="Salad">Salad</option>
                                    <option value="Shoney Kid">Shoney Kid</option>
                                    <option value="Side Dishes">Side Dishes</option>
                                    <option value="Classic Cocktails">Classic Cocktails</option>
                                    <option value="Cold Pressed Juice">Cold Pressed Juice</option>
                                    <option value="House Cocktails">House Cocktails</option>
                                    <option value="Mocktails">Mocktails</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <button type="submit" class="btn btn-dark">Search</button>
                            </div>
                            <div class="col" style="text-align: right;">
                                <a href="menu-panel.php" class="btn btn-light">Show All</a>
                            </div>
                        </div>
                    </form>
                </div>
                <?php
                // Include config file (must define $pdo)
                require_once "../config.php";

                try {
                    if (isset($_POST['search']) && !empty($_POST['search'])) {
                        $search = "%" . $_POST['search'] . "%";
                        $sql = "SELECT * FROM menu 
                                WHERE item_type LIKE :search 
                                   OR item_category LIKE :search 
                                   OR item_name LIKE :search 
                                   OR item_id LIKE :search
                                ORDER BY item_id";
                        $stmt = $pdo->prepare($sql);
                        $stmt->bindParam(':search', $search, PDO::PARAM_STR);
                        $stmt->execute();
                    } else {
                        $sql = "SELECT * FROM menu ORDER BY item_id";
                        $stmt = $pdo->query($sql);
                    }

                    if ($stmt->rowCount() > 0) {
                        echo '<table class="table table-bordered table-striped">';
                        echo "<thead>";
                        echo "<tr>";
                        echo "<th>Item ID</th>";
                        echo "<th>Name</th>";
                        echo "<th>Type</th>";
                        echo "<th>Category</th>";
                        echo "<th>Price</th>";
                        echo "<th>Description</th>";
                        echo "<th>Edit</th>";
                        echo "</tr>";
                        echo "</thead>";
                        echo "<tbody>";
                        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                            echo "<tr>";
                            echo "<td>" . htmlspecialchars($row['item_id']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['item_name']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['item_type']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['item_category']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['item_price']) . "</td>";
                            echo "<td>" . htmlspecialchars($row['item_description']) . "</td>";
                            echo "<td>";
                            echo '<a href="../menuCrud/updateItemVerify.php?id=' . urlencode($row['item_id']) . '" 
                                    title="Modify Record" data-toggle="tooltip"
                                    onclick="return confirm(\'Admin permission Required!\n\nAre you sure you want to Edit this Item?\')">
                                    <i class="fa fa-pencil" aria-hidden="true"></i></a>';
                            echo "</td>";
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
