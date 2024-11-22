<?php

namespace App\Http\Controllers;

use App\Application\UseCases\LoginUseCase;
use Illuminate\Http\Request;

class LoginController extends Controller
{
    private LoginUseCase $loginUseCase;

    public function __construct(LoginUseCase $loginUseCase)
    {
        $this->loginUseCase = $loginUseCase;
    }

    public function showLoginForm()
    {
        return view('auth.login');
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $email = $request->input('email');
        $password = $request->input('password');

        $isAuthenticated = $this->loginUseCase->execute($email, $password);

        if ($isAuthenticated) {
            $request->session()->put('user', $email);
            return redirect()->route('dashboard');
        }

        return back()->withErrors(['error' => 'Invalid credentials']);
    }

    public function logout(Request $request)
    {
        $request->session()->forget('user');
        return redirect()->route('login');
    }
}
