<?php

// use App\Http\Controllers\Product\ProductController;
use App\Http\Controllers\Product\API\ProductAPIController;
use App\Http\Controllers\Sales\API\SalesAPIController;
use App\Http\Controllers\User\API\UserAPIController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::post('/addSales', [SalesAPIController::class, 'create']);
Route::get('/sales', [SalesAPIController::class, 'findAll']);
Route::get('/products', [ProductAPIController::class, 'findAll']);

// User routes
Route::post('/users/register', [UserAPIController::class, 'register']);
Route::get('/users', [UserAPIController::class, 'findAll']);
Route::get('/users/{username}', [UserAPIController::class, 'findByUsername']);
Route::put('/users/update', [UserAPIController::class, 'update']);
Route::delete('/users/{username}', [UserAPIController::class, 'delete']);

// Route::post('/update', [])
