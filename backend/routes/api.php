<?php

// use App\Http\Controllers\Product\ProductController;
use App\Http\Controllers\Product\API\ProductAPIController;
use App\Http\Controllers\Sales\API\SalesAPIController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/addSales', [SalesAPIController::class, 'create']);
Route::get('/sales', [SalesAPIController::class, 'findAll']);
Route::get('/products', [ProductAPIController::class, 'findAll']);

// Route::post('/update', [])
