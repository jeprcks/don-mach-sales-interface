<?php

namespace App\Infrastructure\Persistence\Eloquent\Product;

use Illuminate\Database\Eloquent\Model;

class ProductModel extends Model
{
    protected $table = 'product';

    protected $fillable = ['id', 'product_id', 'product_image', 'product_name', 'product_price', 'product_stock', 'description'];
}
