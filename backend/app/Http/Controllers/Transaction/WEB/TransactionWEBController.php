<?php

namespace App\Http\Controllers\Transaction\WEB;

use App\Http\Controllers\Controller;

class TransactionWEBController extends Controller
{
    public function index()
    {
        return view('Pages.Transaction.index');
    }
}
