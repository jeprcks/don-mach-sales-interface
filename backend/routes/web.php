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

//product
Route::get('/products', function () {
    return view('Pages.Product.index');
})->name('products');

//auth
Route::get('/', [AdminAuthController::class, 'showLoginForm']);

//product
Route::get('/products', [ProductWebController::class, 'index'])->name('product.index');
Route::post('/products/update', [ProductWebController::class, 'updateProduct'])->name('product.update');
Route::post('/products/create', [ProductWebController::class, 'createProducts'])->name('product.create');
Route::get('/home', [HomeWebController::class, 'index'])->name('homepage');

//users
Route::get('/users', [UserWEBController::class, 'index'])->name('users.index');
Route::post('/users', [UserWEBController::class, 'store'])->name('users.store');
Route::delete('/users/{id}', [UserWEBController::class, 'destroy'])->name('users.destroy');
Route::put('/users/{id}', [UserWEBController::class, 'update'])->name('users.update');

//transaction
Route::get('/transaction', [TransactionWEBController::class, 'index']);

//sales
Route::get('/sales', [SalesWEBController::class, 'index']);
Route::post('/update-stock', [SalesWEBController::class, 'updateStock'])->name('sales.updateStock');

//delete
Route::post('/deleteitem/{id}', [ProductWebController::class, 'deleteitem'])->name('deleteitem');
Route::delete('/product/delete/{product_id}', [ProductWebController::class, 'deleteitem'])->name('product.delete');

//validation
Route::post('/check-product-image', [ProductWebController::class, 'checkProductImage'])->name('product.checkImage');
//get kuha data or views
//post kay create
//put kay update
//delete/del kay delete
