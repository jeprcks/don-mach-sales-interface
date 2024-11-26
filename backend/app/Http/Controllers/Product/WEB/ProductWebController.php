<?php

namespace App\Http\Controllers\Product\WEB;

use App\Http\Controllers\Controller;

class ProductWebController extends Controller
{
    public function index()
    {
        return view('Pages.Product.index');
    }
}
