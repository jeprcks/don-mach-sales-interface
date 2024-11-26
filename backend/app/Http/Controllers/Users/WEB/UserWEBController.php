<?php

namespace App\Http\Controllers\Users\WEB;

use App\Http\Controllers\Controller;

class UserWEBController extends Controller
{
    public function index()
    {
        return view('Pages.CreateUser.index'); // tawg ang page sa view gikan nga folder gaw.
    }
}
