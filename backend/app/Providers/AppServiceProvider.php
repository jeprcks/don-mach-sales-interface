<?php

namespace App\Providers;

use App\Domain\Product\ProductRepository;
use App\Domain\Users\UserRepository;
// Eloquent.
use App\Infrastructure\Persistence\Eloquent\Product\EloquentProductRepository;
use App\Infrastructure\Persistence\Eloquent\User\EloquentUserRepository;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        $this->app->bind(ProductRepository::class, EloquentProductRepository::class);
        $this->app->bind(UserRepository::class, EloquentUserRepository::class);
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        //
    }
}
