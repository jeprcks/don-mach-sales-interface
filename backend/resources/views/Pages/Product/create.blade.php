@extends('layout.app')

@section('content')
<div class="container mx-auto px-4 py-8">
    <div class="max-w-2xl mx-auto bg-white p-8 rounded-lg shadow-md">
        <h1 class="text-2xl font-bold mb-6">Create New Product</h1>

        @if(session('error'))
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded mb-4">
                {{ session('error') }}
            </div>
        @endif

        <form action="{{ route('products.store') }}" method="POST">
            @csrf
            <div class="mb-4">
                <label for="name" class="block text-gray-700 font-bold mb-2">Product Name</label>
                <input type="text" name="name" id="name" value="{{ old('name') }}" 
                    class="w-full px-3 py-2 border rounded-lg @error('name') border-red-500 @enderror">
                @error('name')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="description" class="block text-gray-700 font-bold mb-2">Description</label>
                <textarea name="description" id="description" rows="4" 
                    class="w-full px-3 py-2 border rounded-lg @error('description') border-red-500 @enderror">{{ old('description') }}</textarea>
                @error('description')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="price" class="block text-gray-700 font-bold mb-2">Price</label>
                <input type="number" name="price" id="price" value="{{ old('price') }}" step="0.01" 
                    class="w-full px-3 py-2 border rounded-lg @error('price') border-red-500 @enderror">
                @error('price')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-4">
                <label for="stock" class="block text-gray-700 font-bold mb-2">Stock</label>
                <input type="number" name="stock" id="stock" value="{{ old('stock') }}" 
                    class="w-full px-3 py-2 border rounded-lg @error('stock') border-red-500 @enderror">
                @error('stock')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="mb-6">
                <label for="category" class="block text-gray-700 font-bold mb-2">Category</label>
                <input type="text" name="category" id="category" value="{{ old('category') }}" 
                    class="w-full px-3 py-2 border rounded-lg @error('category') border-red-500 @enderror">
                @error('category')
                    <p class="text-red-500 text-sm mt-1">{{ $message }}</p>
                @enderror
            </div>

            <div class="flex justify-end">
                <a href="{{ route('products.index') }}" 
                    class="bg-gray-500 text-white px-4 py-2 rounded-lg mr-2 hover:bg-gray-600">
                    Cancel
                </a>
                <button type="submit" 
                    class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600">
                    Create Product
                </button>
            </div>
        </form>
    </div>
</div>
@endsection
