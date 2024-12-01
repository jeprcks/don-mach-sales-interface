<?php

namespace App\Http\Controllers\Transaction\WEB;

use App\Http\Controllers\Controller;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;

class TransactionWEBController extends Controller
{
    public function index()
    {
        $transactions = SalesModel::orderBy('created_at', 'desc')->get();
        return view('Pages.Transaction.index', compact('transactions'));
    }
}
