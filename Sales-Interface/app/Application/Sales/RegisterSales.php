<?php

namespace App\Application\Sales\RegisterSales;

use App\Domain\Entities\Sales;
use App\Domain\Entities\SalesRepository;

class RegisterSales
{
    private SalesRepository $salesRepository;

    public function __construct(SalesRepository $salesRepository)
    {
        $this->salesRepository = $salesRepository;
    }

    public function create(Sales $sales)
    {
        $this->salesRepository->create($sales);
    }
}
