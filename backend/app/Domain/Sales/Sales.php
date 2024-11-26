<?php

namespace App\Domain\Sales;

class Sales
{
    private int $id;

    private string $order_list;

    private int $quantity;

    private string $total_order;

    public function __construct(
        ?int $id = null,
        ?string $order_list = null,
        ?int $quantity = null,
        ?string $total_order = null,

    ) {
        $this->id = $id;
        $this->order_list = $order_list;
        $this->quantity = $quantity;
        $this->total_order = $total_order;
    }

    public function getID()
    {
        return $this->id;
    }

    public function getOrder_list()
    {
        return $this->order_list;
    }

    public function getQuantity()
    {
        return $this->quantity;
    }

    public function getTotal_order()
    {
        return $this->total_order;
    }
}
