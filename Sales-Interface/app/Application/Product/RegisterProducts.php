<?php

namespace app\Application\Product;

use app\Domain\Entities\product;
use app\Domain\Entities\ProductRepository;

class RegisterProducts
{
    private ProductRepository $productRepository;

    public function __construct(ProductRepository $productRepository)
    {
        $this->productRepository = $productRepository;

    }

    public function create(string $product_id, string $product_name, $product_price, string $product_image, $product_stock, string $Description)
    {

        $product_price = is_null($product_price) ? null : (float) $product_price;

        $data = new Product($product_id, $product_name, $product_image, $product_price, $Description);

        return $this->productRepository->create($data);

    }

    public function update(string $product_id, string $product_image, string $product_name, $product_price, string $Description)
    {
        $product_price = is_null($product_price) ? null : (float) $product_price;

        $existingProduct = $this->productRepository->findByProductID($product_id);
        if (! $existingProduct) {

            throw new \Exception('Product not found');
        }
        $updatedProduct = new Product(
            $product_id,
            $product_name,
            $product_price,
            $Description,
            $product_image,
            $existingProduct->create_at(),
            date('Y-m-d H:i:s')
        );

        return $this->ProductRepository->update($updatedProduct);
    }
}
