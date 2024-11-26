<?php

namespace App\Application\Product;

use App\Domain\Product\ProductRepository;

class RegisterProducts
{
    private ProductRepository $productRepository;

    public function __construct(ProductRepository $productRepository)
    {
        $this->productRepository = $productRepository;
    }

    public function execute($data)
    {
        // Temporary implementation for testing
        return true;
    }

    public function findById($id)
    {
        // Temporary implementation for testing
        return (object) [
            'id' => $id,
            'name' => 'Test Product',
            'description' => 'Test Description',
            'price' => 100,
            'stock' => 10,
            'category' => 'Test Category',
        ];
    }

    public function update($id, $data)
    {
        // Temporary implementation for testing
        return true;
    }

    public function delete($id)
    {
        // Temporary implementation for testing
        return true;
    }

    public function findAll(): array
    {
        return $this->productRepository->findAll();
    }
}
