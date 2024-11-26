<?php

namespace App\Http\Controllers\Sales\WEB;

use App\Http\Controllers\Controller;

class SalesWEBController extends Controller
{
    public function index()
    {
        return view('Pages.Sales.index');
    }
}
