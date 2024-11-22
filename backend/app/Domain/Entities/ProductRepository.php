<?php

namespace app\Domain\Entities\ProductRepository;

use app\Domain\Entities\product;

interface ProductRepository
{
    public function create(Product $product): void;

    public function update(Product $product): void;

    public function findByID(string $product_id): void;
    
    public function findAll(): array;

    
}
