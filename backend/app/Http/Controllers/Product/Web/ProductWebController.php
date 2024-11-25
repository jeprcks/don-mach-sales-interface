<?php

namespace App\Http\Controllers\Product\Web;

use App\Http\Controllers\Controller;
use App\Application\Product\RegisterProducts;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductWebController extends Controller
{
    private RegisterProducts $registerProducts;

    public function __construct(RegisterProducts $registerProducts)
    {
        $this->registerProducts = $registerProducts;
    }

    public function index()
    {
        try {
            \Log::info('Attempting to load dashboard view');
            return view('dashboard');
        } catch (\Exception $e) {
            \Log::error('Error in index method: ' . $e->getMessage());
            dd($e->getMessage()); // This will show the error in the browser
        }
    }

    public function create()
    {
        return view('Pages.Product.create');
    }

    public function store(Request $request)
    {
        dd($request->all());
        $data = $request->all();

        $validate = Validator::make($data, [
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'category' => 'required|string'
        ]);

        if ($validate->fails()) {
            return redirect()
                ->back()
                ->withErrors($validate)
                ->withInput();
        }

        try {
            $this->registerProducts->execute($data);
            return redirect()
                ->route('products.index')
                ->with('success', 'Product created successfully');
        } catch (\Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Failed to create product: ' . $e->getMessage())
                ->withInput();
        }
    }

    public function edit($id)
    {
        $product = $this->registerProducts->findById($id);
        return view('Pages.Product.edit', compact('product'));
    }

    public function update(Request $request, $id)
    {
        $data = $request->all();

        $validate = Validator::make($data, [
            'name' => 'required|string|max:255',
            'description' => 'required|string',
            'price' => 'required|numeric',
            'stock' => 'required|integer',
            'category' => 'required|string'
        ]);

        if ($validate->fails()) {
            return redirect()
                ->back()
                ->withErrors($validate)
                ->withInput();
        }

        try {
            $this->registerProducts->update($id, $data);
            return redirect()
                ->route('products.index')
                ->with('success', 'Product updated successfully');
        } catch (\Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Failed to update product: ' . $e->getMessage())
                ->withInput();
        }
    }

    public function destroy($id)
    {
        try {
            $this->registerProducts->delete($id);
            return redirect()
                ->route('products.index')
                ->with('success', 'Product deleted successfully');
        } catch (\Exception $e) {
            return redirect()
                ->back()
                ->with('error', 'Failed to delete product: ' . $e->getMessage());
        }
    }
}
