<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Log;

Route::get('/', function () {
    Log::info('OpenTelemetry Testlog: Zugriff auf / route');
    return view('welcome');
});
