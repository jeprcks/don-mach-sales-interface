<?php

namespace App\Infrastructure\Persistence\Eloquent;

use App\Domain\Sales\SalesRepository;

class EloquentSalesRepository implements SalesRepository
{
    public function create(Sales $sales): void
    {
        $saleModel = new Sales;
        $saleModel->order_list = $sales['order_list'];
        $saleModel->total_order = $sales['total_order'];
        $saleModel->quantity = $sales['quantity'];
        $saleModel->save();
    }

    public function findAll(): array
    {
        return [];
    }
}
