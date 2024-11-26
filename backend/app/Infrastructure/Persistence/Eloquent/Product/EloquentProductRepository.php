<?php

namespace App\Infrastructure\Persistence\Eloquent\Product;

use App\Domain\Product\Product;
use App\Domain\Product\ProductRepository;

class EloquentProductRepository implements ProductRepository
{
    public function findAll(): array
    {
        return ProductModel::all()->map(
            fn ($productModel) => new Product(
                $productModel->id,
                $productModel->product_id,
                $productModel->product_image,
                $productModel->product_name,
                $productModel->product_price,
                $productModel->description,
                $productModel->product_stock,
            )
        )->toArray();
    }

    // public function findById($id)
    // {
    //     return ProductModel::findOrFail($id);
    // }

    // public function create(array $data)
    // {
    //     return ProductModel::create($data);
    // }

    // public function update($id, array $data)
    // {
    //     $product = $this->findById($id);
    //     $product->update($data);

    //     return $product;
    // }

    // public function delete($id)
    // {
    //     $product = $this->findById($id);

    //     return $product->delete();
    // }
}
