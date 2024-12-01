<?php

namespace App\Http\Controllers\Sales\API;

use App\Http\Controllers\Controller;
use App\Domain\Sales\Sales;
use App\Application\Sales\RegisterSales;
use Illuminate\Http\Request;

class SalesAPIController extends Controller
{
    private RegisterSales $registerSales;

    public function __construct(RegisterSales $registerSales)
    {
        $this->registerSales = $registerSales;
    }

    public function findAll()
    {
        try {
            $sales = $this->registerSales->findAll();
            return response()->json([
                'sales' => $sales,
                'message' => 'Sales retrieved successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error retrieving sales',
                'error' => $e->getMessage()
            ], 500);
        }
    }

    public function createSales(Request $request)
    {
        try {
            $validated = $request->validate([
                'order_list' => 'required|array',
                'total_order' => 'required|numeric',
                'quantity' => 'required|numeric'
            ]);

            $sales = new Sales(
                null,
                json_encode($validated['order_list']),
                $validated['quantity'],
                (string)$validated['total_order']
            );

            $this->registerSales->create($sales);

            return response()->json([
                'message' => 'Sale created successfully'
            ], 201);

        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error creating sale',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
