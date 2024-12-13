<?php

namespace App\Http\Controllers\Transaction\WEB;

use App\Http\Controllers\Controller;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;

class TransactionWEBController extends Controller
{
    public function index($user_id)
    {
        $transactions = SalesModel::where('user_id', $user_id)->orderBy('created_at', 'desc')->get();

        return view('Pages.Transaction.index', compact('transactions'));
    }
}
