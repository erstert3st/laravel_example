<?php
// This PHP script performs a simple check and returns a response.
header('Content-Type: application/json');

$response = array("message" => "Hello World from PHP!", "status" => "success");

// You can add more checks or validations here as needed.

echo json_encode($response);
?>