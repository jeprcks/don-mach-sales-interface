<?php

use App\Http\Controllers\Sales\API\SalesAPIController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/sales', [SalesAPIController::class, 'create']);

// Route::post('/update', [])