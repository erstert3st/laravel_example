<?php
// This script generates random web requests for 1 minute using PHP's native functions
header('Content-Type: text/plain');

// Define URLs to request
$urls = [
    'http://localhost/',
    'http://localhost/check.php',
    'http://localhost/status',
    'http://localhost/?param=test',
    'http://localhost/check.php?test=1',
    'http://localhost/info.php'
];

// Set timeout for 1 minute
$endTime = time() + 60;
$requestCount = 0;

echo "Starting web request generator for 1 minute...\n";

// Configure non-blocking behavior
$options = [
    'http' => [
        'timeout' => 1, // 1 second timeout for each request
    ]
];
$context = stream_context_create($options);

// Main loop
while (time() < $endTime) {
    // Select a random URL
    $randomUrl = $urls[array_rand($urls)];
    
    // Make the request
    echo "Requesting: $randomUrl\n";
    try {
        // Use file_get_contents with a short timeout to simulate non-blocking
        $response = @file_get_contents($randomUrl, false, $context);
        $requestCount++;
    } catch (Exception $e) {
        // Ignore errors
    }
    
    // Random sleep between 100-500ms
    $sleepTime = rand(100, 500) * 1000; // in microseconds
    usleep($sleepTime);
    
    // Output status every few requests
    if ($requestCount % 5 == 0) {
        echo "Total requests made: $requestCount\n";
    }
}

echo "Completed 1 minute of web traffic generation.\n";
echo "Total requests made: $requestCount\n";
?>