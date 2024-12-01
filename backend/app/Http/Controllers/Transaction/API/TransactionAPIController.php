<?php

namespace App\Http\Controllers\Transaction\API;

use App\Http\Controllers\Controller;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;
use Illuminate\Http\Request;

class TransactionAPIController extends Controller
{
    public function index()
    {
        try {
            $transactions = SalesModel::orderBy('created_at', 'desc')
                ->get()
                ->map(function ($transaction) {
                    $orderList = json_decode($transaction->order_list, true);

                    return [
                        'orderId' => $transaction->id,
                        'date' => $transaction->created_at,
                        'items' => array_map(function ($item) {
                            return [
                                'name' => $item['name'],
                                'quantity' => $item['quantity'],
                                'price' => (float) $item['price'],
                                'total' => (float) $item['price'] * $item['quantity']
                            ];
                        }, $orderList),
                        'total' => (float) $transaction->total_order
                    ];
                });

            return response()->json($transactions);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
}
