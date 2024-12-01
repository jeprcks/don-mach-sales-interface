<?php

namespace App\Http\Controllers\Sales\WEB;

use App\Http\Controllers\Controller;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SalesWEBController extends Controller
{
    public function index()
    {
        $products = DB::table('product')
            ->select('product_id', 'product_name', 'product_price', 'product_stock', 'product_image', 'description')
            ->get();

        return view('Pages.Sales.index', ['products' => $products]);
    }

    public function updateStock(Request $request)
    {
        try {
            DB::beginTransaction();

            $orders = $request->input('orders');
            $totalQuantity = 0;
            $totalOrder = 0;

            foreach ($orders as $order) {
                $product = DB::table('product')
                    ->where('product_name', $order['name'])
                    ->first();

                if ($product) {
                    $newStock = $product->product_stock - $order['quantity'];

                    if ($newStock < 0) {
                        DB::rollBack();

                        return response()->json([
                            'success' => false,
                            'message' => "Insufficient stock for {$order['name']}",
                        ], 400);
                    }

                    DB::table('product')
                        ->where('product_name', $order['name'])
                        ->update(['product_stock' => $newStock]);

                    $totalQuantity += $order['quantity'];
                    $totalOrder += $order['price'] * $order['quantity'];
                }
            }

            // Create transaction record
            $sale = new SalesModel;
            $sale->order_list = json_encode($orders);
            $sale->total_order = $totalOrder;
            $sale->quantity = $totalQuantity;
            $sale->save();

            DB::commit();

            return response()->json([
                'success' => true,
                'transaction_id' => $sale->id,
            ]);
        } catch (\Exception $e) {
            DB::rollBack();

            return response()->json([
                'success' => false,
                'message' => $e->getMessage(),
            ], 500);
        }
    }
}
