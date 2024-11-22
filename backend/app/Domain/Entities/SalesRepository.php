<?php

namespace App\Domain\Entities\SalesRepository;

use app\Domain\Entities\Sales;

interface SalesRepository
{
    public function create(Sales $order_list): void;

    public function findALL(): array;
}
