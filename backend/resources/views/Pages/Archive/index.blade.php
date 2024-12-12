@extends('Layout.app')

@section('title', 'Archived Products')

@include('Components.NaBar.navbar')

@section('content')
    <div style="padding: 20px; background-color: #f7f0e3; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
        <h1 style="text-align: center; margin-bottom: 2rem; font-size: 2.5rem; color: #6b4226; font-weight: bold;">
            Archived Products
        </h1>

        <div id="product-container" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; padding: 20px;">

            @if (count($archivedProducts) > 0)
                @foreach ($archivedProducts as $product)
                    <div
                        style="background-color: white; border-radius: 15px; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1);">
                        <img src="{{ asset('images/' . ($product['product_image'] ?? 'default.jpg')) }}"
                            alt="{{ $product['product_name'] }}"
                            style="width: 100%; height: 300px; object-fit: cover; border-radius: 8px; margin-bottom: 15px;">
                        <h2 style="font-size: 1.5rem; color: #4b3025; margin-bottom: 10px;">
                            {{ $product['product_name'] }}
                        </h2>
                        <p style="color: #6b4226; margin-bottom: 8px;">₱{{ $product['product_price'] }}</p>
                        <p style="color: #666; margin-bottom: 15px;">{{ $product['description'] }}</p>

                        <form action="{{ route('product.restore', $product['product_id']) }}" method="POST">
                            @csrf
                            <button type="submit"
                                style="width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                                Restore Product
                            </button>
                        </form>
                    </div>
                @endforeach
            @else
                <div style="text-align: center; grid-column: span 3; padding: 20px;">
                    <p style="color: #666;">No archived products available.</p>
                </div>
            @endif
        </div>

        <div style="text-align: center; margin-top: 20px;">
            <a href="{{ route('product.index', ['user_id' => $userId]) }}"
                style="display: inline-block; padding: 10px 20px; background-color: #4b3025; color: white; text-decoration: none; border-radius: 8px;">
                Back to Products
            </a>
        </div>
    </div>
@endsection
