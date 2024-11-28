<?php

use App\Http\Controllers\Auth\AdminAuthController;
use App\Http\Controllers\Home\WEB\HomeWebController;
use App\Http\Controllers\Product\WEB\ProductWebController;
use App\Http\Controllers\Sales\WEB\SalesWEBController;
use App\Http\Controllers\Transaction\WEB\TransactionWEBController;
use App\Http\Controllers\Users\WEB\UserWEBController;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('pages.Auth.page');
// });
Route::get('/products', function () {
    return view('Pages.Product.index');
})->name('products');

Route::get('/', [AdminAuthController::class, 'showLoginForm']);
Route::get('/products', [ProductWebController::class, 'index'])->name('product.index');
Route::post('/products/update', [ProductWebController::class, 'updateProduct'])->name('product.update');
Route::post('/products/create', [ProductWebController::class, 'createProducts'])->name('product.create');
Route::get('/home', [HomeWebController::class, 'index']);
Route::get('/users', [UserWEBController::class, 'index']);
Route::get('/transaction', [TransactionWEBController::class, 'index']);
Route::get('/sales', [SalesWEBController::class, 'index']);
Route::post('/deleteitem/{id}', [ProductWebController::class, 'deleteitem'])->name('deleteitem');
Route::delete('/delete/products/{id}', [ProductWebController::class, 'deleteitem'])->name('product.delete');


//get kuha data or views
//post kay create
//put kay update
//delete/del kay delete
