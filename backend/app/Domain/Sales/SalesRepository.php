<?php

namespace App\Domain\Sales;
use App\Domain\Sales\Sales;

interface SalesRepository
{
    public function create(Sales $order_list): void;

    public function findALL(): array;
    
}
