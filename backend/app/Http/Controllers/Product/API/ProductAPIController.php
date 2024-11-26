<?php

namespace App\Http\Controllers\Product\API;

use App\Application\Product\RegisterProducts;
use App\Http\Controllers\Controller;

class ProductAPIController extends Controller
{
    private RegisterProducts $registerProducts;

    public function __construct(RegisterProducts $registerProducts)
    {
        $this->registerProducts = $registerProducts;
    }

    public function findAll()
    {
        try {
            $productModel = $this->registerProducts->findAll();
            if (! $productModel) {
                return response()->json(['message' => 'No products found.'], 404);
            }
            $products = array_map(fn ($productModel) => $productModel->toArray(), $productModel);

            return response()->json(compact('products'), 200);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 404);
        }
    }
}
