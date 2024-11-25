<?php

namespace App\Domain\Product;

interface ProductRepository
{
    public function findAll(): array;

    public function findById(int $id): ?Product;

    public function create(array $data): void;

    public function update(int $id, array $data): ?Product;

    public function delete(int $id): void;
}
