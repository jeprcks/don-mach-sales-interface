@extends('layout.app')

@section('content')
<div class="container mx-auto px-4 py-8">
    <h1 class="text-3xl font-bold mb-6">Welcome to Product Management</h1>
    <div class="bg-white rounded-lg shadow-md p-6">
        <p class="mb-4">Please use the navigation to manage products.</p>
        <a href="{{ route('products.index') }}" 
           class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
            Go to Products
        </a>
    </div>
</div>
@endsection 