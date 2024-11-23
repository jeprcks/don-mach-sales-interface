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

    public function index()
    {
        return response()->json(['message' => 'success']);
    }

    public function findAll()
    {
        return response()->json(['message' => 'success']);
    }
}
