<?php

use App\Http\Controllers\Product\API\ProductAPIController;
use App\Http\Controllers\Sales\API\SalesAPIController;
use App\Http\Controllers\Users\API\UsersAPIController;
use Illuminate\Support\Facades\Route;

//sales
Route::post('/createSales', [SalesAPIController::class, 'createSales']);
Route::get('/sales', [SalesAPIController::class, 'findAll']);

//product
Route::get('/products', [ProductAPIController::class, 'findAll']);
Route::post('/add/products', [ProductAPIController::class, 'createProducts']);
Route::post('/update/products', [ProductAPIController::class, 'updateProduct']);
Route::delete('/delete/products/{id}', [ProductAPIController::class, 'destroy']);

//user
Route::get('/display/users', [UsersAPIController::class, 'findAll']);
Route::post('/create/users', [UsersAPIController::class, 'create']);
Route::put('/update/users/{id}', [UsersAPIController::class, 'update']);
Route::delete('/delete/users/{id}', [UsersAPIController::class, 'destroy']);
Route::get('/users/{username}', [UsersAPIController::class, 'findByUsername']);
