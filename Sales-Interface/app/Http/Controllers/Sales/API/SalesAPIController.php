<?php

namespace App\Http\Controllers\Sales\API;

use App\Application\Sales\RegisterSales;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class SalesAPIController extends Controller
{
    private RegisterSales $registerSales;

    public function __construct(RegisterSales $registerSales)
    {
        $this->RegisterSales = $registerSales;
    }

    public function create(Request $request)
    {
        $data = $request->all();

        // return response()->json($data);
        $validate = Validator::make(data: $data, rules: [
            'order_list' => 'required|string',
            'quantity' => 'required|numeric',
            'total_order' => 'required|numeric',
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
            // return response()->json(['message' => 'Invalid Products.'], 422);
        }
    }
}
