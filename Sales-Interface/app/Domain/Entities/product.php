<?php

namespace app\Domain\Entities\product;

class Product
{
    public function __construct(
        private ?string $product_id,
        private ?string $product_image,
        private ?string $product_name,
        private ?float $product_price,
        private ?string $description,
        private ?string $product_stock,
    ) {
        $this->product_id = $product_id;
        $this->product_image = $product_image;
        $this->product_name = $product_name;
        $this->product_price = $product_price;
        $this->description = $description;
        $this->product_stock = $product_stock;
    }

    public function getProduct_id()
    {
        return $this->product_id;
    }

    public function getProduct_image()
    {
        return $this->product_image;
    }

    public function getProduct_name()
    {
        return this->product_name;
    }

    public function getProduct_price()
    {
        return this->product_price;
    }

    public function getProduct_stock()
    {
        return this->product_stock;
    }

    public function getDescription()
    {
        return this->description;
    }
}
