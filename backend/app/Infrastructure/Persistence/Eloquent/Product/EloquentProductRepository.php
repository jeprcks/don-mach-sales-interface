<?php

namespace App\Infrastructure\Persistence\Eloquent\Product;

use App\Domain\Products\ProductRepository;

class EloquentProductRepository implements ProductRepository
{
    public function findAll()
    {
        return ProductModel::all();
    }

    public function findById($id)
    {
        return ProductModel::findOrFail($id);
    }

    public function create(array $data)
    {
        return ProductModel::create($data);
    }

    public function update($id, array $data)
    {
        $product = $this->findById($id);
        $product->update($data);

        return $product;
    }

    public function delete($id)
    {
        $product = $this->findById($id);

        return $product->delete();
    }
}
