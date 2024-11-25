<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Product\Web\ProductWebController;

// Route::get('/', function () {
//     return view('welcome');
// });

// use App\Http\Controllers\LoginController;

// Route::get('/login', [LoginController::class, 'showLoginForm'])->name('login');
// Route::post('/login', [LoginController::class, 'login']);
// Route::post('/logout', [LoginController::class, 'logout'])->name('logout');

// Route::get('/dashboard', function () {
//     return view('dashboard');
// })->middleware('auth');

//adminlogin
Route::get('/admin/login', [AdminAuthController::class, 'showLoginForm'])->name('admin.login');
Route::post('/admin/login', [AdminAuthController::class, 'login']);


//home ui

Route::get('/', function () {
    return view('home');
});

Route::prefix('products')->group(function () {
    Route::get('/', [ProductWebController::class, 'index'])->name('products.index');
    Route::get('/create', [ProductWebController::class, 'create'])->name('products.create');
    Route::post('/', [ProductWebController::class, 'store'])->name('products.store');
    Route::get('/{id}/edit', [ProductWebController::class, 'edit'])->name('products.edit');
    Route::put('/{id}', [ProductWebController::class, 'update'])->name('products.update');
    Route::delete('/{id}', [ProductWebController::class, 'destroy'])->name('products.destroy');
});
