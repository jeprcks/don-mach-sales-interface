<?php

namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class AdminAuthController extends Controller
{
    private const ADMIN_USERNAME = 'admin';

    private const ADMIN_PASSWORD = 'admin';

    public function showLoginForm()
    {
        if (session('is_admin')) {
            return redirect()->route('home');
        }

        return view('auth.admin-login');
    }

    public function login(Request $request)
    {
        $credentials = $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        if ($credentials['username'] === self::ADMIN_USERNAME &&
            $credentials['password'] === self::ADMIN_PASSWORD) {

            session(['is_admin' => true]);
            session(['username' => 'admin']);

            return redirect()->route('home');
        }

        return back()->withErrors([
            'username' => 'Invalid admin credentials.',
        ])->withInput($request->except('password'));
    }

    public function logout()
    {
        session()->forget(['is_admin', 'username']);

        return redirect()->route('login');
    }
}
