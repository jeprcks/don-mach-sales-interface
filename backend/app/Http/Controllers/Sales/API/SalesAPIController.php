<?php

namespace App\Http\Controllers\Sales\API;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class SalesAPIController extends Controller
{
    public function findAll()
    {
        return response()->json(['message' => 'Test']);
    }

    public function createSales(Request $request)
    {
        dd($request->all());
    }
}
