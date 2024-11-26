<?php

namespace App\Domain\Sales\SalesRepository;

interface SalesRepository
{
    public function create(Sales $order_list): void;

    public function findALL(): array;
}
