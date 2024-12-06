<?php

namespace App\Http\Controllers\Auth;

use App\Application\User\RegisterUser;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class AdminAuthController extends Controller
{
    private const ADMIN_USERNAME = 'admin';

    private const ADMIN_PASSWORD = 'admin';

    private RegisterUser $registerUser;

    public function __construct(RegisterUser $registerUser)
    {
        $this->registerUser = $registerUser;
    }

    public function showLoginForm()
    {
        // if (session('is_admin')) {
        //     return redirect()->route('home');
        // }

        return view('auth.admin-login');
    }

    public function login(Request $request)
    {
        $data = $request->validate([
            'username' => 'required',
            'password' => 'required',
        ]);

        $credentials = $request->only('username', 'password');

        if (Auth::attempt($credentials)) {
            return redirect('home')->with('message', 'Login Successful!');
        }

        return redirect('/')->with('message', 'Login Failed!');
        // $data = $request->all();
        // $this->registerUser->login($data['username'], $data['password']);
        // dd($credentials);

        // if ($credentials['username'] === self::ADMIN_USERNAME &&
        //     $credentials['password'] === self::ADMIN_PASSWORD) {

        //     session(['is_admin' => true]);
        //     session(['username' => 'admin']);

        //     return redirect()->route('home');
        // }

        // return back()->withErrors([
        //     'username' => 'Invalid admin credentials.',
        // ])->withInput($request->except('password'));
    }

    public function logout(Request $request)
    {
        Auth::logout();

        $request->session()->invalidate();

        $request->session()->regenerateToken();

        return redirect('/')->with('message', 'Logged out successfully!');
    }
}
