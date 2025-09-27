<?php
session_start(); // Ensure session is started
require_once '../posBackend/checkIfLoggedIn.php';
?>
<?php
include '../inc/dashHeader.php';
require_once '../config.php';

try {
    $query = "SELECT * FROM kitchen WHERE time_ended IS NULL";
    $stmt = $pdo->query($query);
    $orders = $stmt->fetchAll(PDO::FETCH_ASSOC);
} catch (PDOException $e) {
    $orders = [];
    // echo $e->getMessage(); // Debug jika perlu
}
?>

<link href="../css/pos.css" rel="stylesheet" />
<meta http-equiv="refresh" content="5">

<div class="wrapper" style="width: 1300px; padding-left: 200px; padding-top: 20px">
    <div class="container-fluid pt-5 pl-600 mt-5">
        <div class="">
            <div class="col" style="text-align: left; display: flex; justify-content: space-between;">
                <h2 class="">Kitchen Orders</h2>
                <a href="../posBackend/kitchenBackend/undo.php?UndoUnshow=true" class="btn btn-warning mb-2">Undo</a>
            </div>
        </div>

        <table class="table table-bordered ">
            <thead>
                <tr>
                    <th>Kitchen ID</th>
                    <th>Table ID</th>
                    <th>Item Name</th>
                    <th>Quantity</th>
                    <th>Time Submitted</th>
                    <th>Time Ended</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <?php if (!empty($orders)): ?>
                    <?php foreach ($orders as $row): ?>
                        <?php
                        $kitchen_id = $row['kitchen_id'];
                        $table_id = $row['table_id'];
                        $item_id = $row['item_id'];
                        $quantity = $row['quantity'];
                        $time_submitted = $row['time_submitted'];
                        $time_ended = $row['time_ended'];

                        // Get item name from menu table
                        $item_name = "Deleted";
                        try {
                            $itemQuery = "SELECT item_name FROM menu WHERE item_id = :item_id";
                            $stmtItem = $pdo->prepare($itemQuery);
                            $stmtItem->bindParam(':item_id', $item_id, PDO::PARAM_INT);
                            $stmtItem->execute();
                            $itemRow = $stmtItem->fetch(PDO::FETCH_ASSOC);
                            if ($itemRow) {
                                $item_name = $itemRow['item_name'];
                            }
                        } catch (PDOException $e) {
                            // Biarkan $item_name tetap "Deleted"
                        }
                        ?>
                        <tr>
                            <td><?= htmlspecialchars($kitchen_id) ?></td>
                            <td><?= htmlspecialchars($table_id) ?></td>
                            <td><?= htmlspecialchars($item_name) ?></td>
                            <td><?= htmlspecialchars($quantity) ?></td>
                            <td><?= htmlspecialchars($time_submitted) ?></td>
                            <td><?= $time_ended ? htmlspecialchars($time_ended) : 'Not Ended' ?></td>
                            <td>
                                <?php if (!$time_ended): ?>
                                    <a href="../posBackend/kitchenBackend/kitchen-panel-back.php?action=set_time_ended&kitchen_id=<?= urlencode($kitchen_id) ?>" class="btn btn-danger">Done</a>
                                <?php endif; ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                <?php else: ?>
                    <tr><td colspan="7">No records in the kitchen table.</td></tr>
                <?php endif; ?>
            </tbody>
        </table>
    </div>
</div>
