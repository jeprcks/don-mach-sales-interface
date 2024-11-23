<?php

namespace App\infrastructure\Persistence\Eloquent;

use App\Domain\Entities\product;
use App\Domain\Entities\ProductRepository;

class EloquentProductRepository implements ProductRepository
{
    public function create(Product $product): void
    {
        $productModel = ProductModel::find($product->getProduct_id()) ?? new ProductModel;
        $productModel->product_id = $product->getProduct_id();
        $productModel->product_name = $product->getProduct_name();
        $productModel->product_image = $product->getProduct_image();
        $productModel->product_price = $product->getProduct_price();
        $productModel->description = $product->getDescription();
        $productModel->product_stock = $product->getProduct_stock();
        $productModel->save();
    }

    public function update(Product $product): void
    {
        $productModel = ProductModel::find($product->getProduct_id()) ?? new ProductModel;
        $productModel->id = $product->getProduct_id();
        $productModel->product_name = $product->getProduct_name();
        $productModel->product_image = $product->getProduct_image();
        $productModel->product_price = $product->getProduct_price();
        $productModel->product_stock = $product->getProduct_stock();
        $productModel->description = $product->getDescriptipn();
        $productModel->save();

    }

    public function delete(Product $product): void
    {
        ProductModel::where('id', $id)->delete();
    }

    public function findByID(string $id): ?Product
    {
        $productModel = ProductModel::find($id);
        if (! productModel) {
            return null;
        }

        return new Product($productModel->id, $productModel->product_name, $productModel->product_price, $productModel->image, $productModel->description);
    }

    // public function findAll(): array
    // {
    //     return ProductModel::all()->map(fn ($productModel) => new Product(

    //         product_id: $productModel->product_id,
    //         product_name: $productModel->product_name,
    //         product_image: $productModel->product_image,
    //         product_price: $productModel->product_price,
    //         product_stock: $productModel->product_stock,
    //         description: $productModel->description,

    //     ))->toArray();

    // }
}
