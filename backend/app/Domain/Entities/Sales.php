<?php

namespace App\Domain\Entities\Sales;

class Sales
{
    public function __construct(
        private ?string $order_list,
        private ?string $total_order,

    ) {
        $this->$order_list = $order_list;
        $this->$total_order = $total_order;

    }

    public function getOrder_list()
    {
        return $this->order_list;
    }

    public function getTotal_order()
    {
        return $this->total_order;
    }
}
