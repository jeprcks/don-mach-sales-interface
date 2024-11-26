<?php

use App\Http\Controllers\Sales\API\SalesAPIController;
use App\Http\Controllers\Product\API\ProductAPIController;
use Illuminate\Support\Facades\Route;

Route::post('/createSales', [SalesAPIController::class, 'createSales']);
Route::get('/sales', [SalesAPIController::class, 'findAll']);
Route::get('/products', [ProductAPIController::class, 'findAll']);

