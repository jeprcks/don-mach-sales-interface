<?php

namespace App\Providers;

use App\Domain\Entities\ProductRepository;
use App\Infrastructure\Persistence\Eloquent\Product\EloquentProductRepository;
use App\Application\Product\RegisterProducts;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
        $this->app->bind(ProductRepository::class, EloquentProductRepository::class);
        $this->app->bind(RegisterProducts::class, function ($app) {
            return new RegisterProducts();
        });
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
