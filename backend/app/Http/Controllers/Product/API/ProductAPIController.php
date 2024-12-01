<?php

namespace App\Http\Controllers\Product\API;

use App\Application\Product\RegisterProducts;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;

class ProductAPIController extends Controller
{
    private RegisterProducts $registerProducts;

    public function __construct(RegisterProducts $registerProducts)
    {
        $this->registerProducts = $registerProducts;
    }

    public function findAll()
    {
        try {
            $productModel = $this->registerProducts->findAll();
            if (! $productModel) {
                return response()->json(['message' => 'No products found.'], 404);
            }
            $products = array_map(fn ($productModel) => $productModel->toArray(), $productModel);

            return response()->json(compact('products'), 200);
        } catch (\Exception $e) {
            return response()->json(['message' => $e->getMessage()], 404);
        }
    }

    public function createProducts(Request $request)
    {
        $data = $request->all();
        $validate = Validator::make($data, [
            'productName' => 'required|string',
            'productPrice' => 'required|numeric',
            'productStock' => 'required|numeric',
            'productImage' => 'nullable|file|image',
            'productDescription' => 'required|string',
        ]);

        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }
        if ($request->file('image')) {
            $image = $request->file('image');
            $destinationpath = 'images';

            $imageName = time().'.'.$image->getClientOriginalExtension();
            $image->move($destinationpath, $imageName);

            $data['image'] = $imageName;
        } else {
            $data['image'] = 'default.jpg';
        }

        $this->registerProducts->create(
            $this->generateProductId(),
            $data['productName'],
            $data['productPrice'],
            'default.jpg',
            $data['productStock'],
            $data['productDescription'],
        );

        return response()->json(['message' => 'test']);
    }

    public function generateProductId()
    {
        do {
            $product_id = $this->generateRandomAlphaNumeric(15);
        } while ($this->registerProducts->findByProductID($product_id));

        return $product_id;
    }

    public function generateRandomAlphaNumeric(int $length = 15): string
    {
        return substr(bin2hex(random_bytes($length / 2)), 0, $length);
    }

    public function updateProduct(Request $request)
    {
        $validate = Validator::make($request->all(), [
            'productID' => 'required|string',
            'productName' => 'required|string',
            'productPrice' => 'required|numeric',
            'productStock' => 'required|numeric',
            'productImage' => 'nullable|image,',
            'productDescription' => 'required|string',
        ]);
        if ($validate->fails()) {
            return response()->json($validate->errors(), 422);
        }
        $data = $request->all();

        $existingProduct = $this->registerProducts->findByProductID($data['productID']);
        if (! $existingProduct) {
            return response()->json(['message' => 'Product Not Found!', 'id' => $data['productID']], 404);
        }

        if ($request->file('image')) {

            if ($existingProduct->getProduct_image() !== 'default.jpg') {
                File::delete('images/'.$existingProduct->getProduct_image());

            }
            $image = $request->file('image');
            $destination = 'images';
            $imageName = time().'.'.$image->getClientOriginalExtension();
            $image->move($destinationPath, $imageName);
            $data['image'] = $imageName;
        } else {
            if ($existingProduct->getProduct_image() === null) {
                $data['image'] = 'default.jpg';
            } else {
                $data['image'] = $existingProduct->getProduct_image();
            }
        }
        $this->registerProducts->update(
            $data['productID'],
            $data['productName'],
            $data['productPrice'],
            $data['image'],
            $data['productStock'],
            $data['productDescription']
        );

        return response()->json(true, 200);
    }

    public function destroy($id)
    {
        try {
            $products = $this->registerProducts->findAll();
            $product = collect($products)->first(function ($product) use ($id) {
                return $product->getId() == $id;
            });

            if (!$product) {
                return response()->json(['message' => 'Product not found'], 404);
            }

            $this->registerProducts->delete($product->getProduct_id());

            return response()->json([
                'message' => 'Product deleted successfully'
            ], 200);
        } catch (\Exception $e) {
            return response()->json([
                'message' => 'Error deleting product',
                'error' => $e->getMessage()
            ], 500);
        }
    }
}
