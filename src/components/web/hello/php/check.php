<?php
header('Content-Type: application/json');
$response = array("message" => "Hello World from PHP!", "status" => "success");
echo json_encode($response);
?>