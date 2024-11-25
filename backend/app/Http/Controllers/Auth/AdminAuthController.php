<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AdminAuthController extends Controller
{
    public function showLoginForm()
    {
        return view('Pages.Auth.login');
    }

    public function login(Request $request)
    {
        // Add login logic here
        return redirect()->intended('/products');
    }
} 