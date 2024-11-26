<?php

use App\Http\Controllers\Auth\AdminAuthController;
use App\Http\Controllers\Home\WEB\HomeWebController;
use App\Http\Controllers\Product\WEB\ProductWebController;
use App\Http\Controllers\Sales\WEB\SalesWEBController;
use App\Http\Controllers\Transaction\WEB\TransactionWEBController;
use App\Http\Controllers\Users\WEB\UserWEBController;
use Illuminate\Support\Facades\Route;

Route::get('/', [AdminAuthController::class, 'showLoginForm']);
Route::get('/products', [ProductWebController::class, 'index']);
Route::get('/home', [HomeWebController::class, 'index']);
Route::get('/users', [UserWEBController::class, 'index']);
Route::get('/transaction', [TransactionWEBController::class, 'index']);
Route::get('/sales', [SalesWEBController::class, 'index']);
//get kuha data or views
//post kay create
//put kay update
//delete/del kay delete
