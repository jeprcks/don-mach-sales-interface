<?php

namespace App\Infrastructure\Persistence\Eloquent\Sales;

use App\Domain\Sales\Sales;
use App\Domain\Sales\SalesRepository;
use App\Infrastructure\Persistence\Eloquent\Sales\SalesModel;

class EloquentSalesRepository implements SalesRepository
{
    public function create(Sales $sales): void
    {
        $saleModel = new SalesModel();
        $saleModel->order_list = $sales->getOrder_list();
        $saleModel->total_order = $sales->getTotal_order();
        $saleModel->quantity = $sales->getQuantity();
        $saleModel->save();
    }

    public function findAll(): array
    {
        return SalesModel::all()->toArray();
    }
}
