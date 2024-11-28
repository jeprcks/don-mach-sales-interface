<?php

namespace App\Http\Controllers\Product\WEB;

use App\Application\Product\RegisterProducts;
use App\Http\Controllers\Controller;
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

        $productModel = $this->registerProducts->findAll();
        $products = array_map(fn ($productModel) => $productModel->toArray(), $productModel);
        // dd($products);

        return view('Pages.Product.index', compact('products'));
    }

    // public function findAll()
    // {
    //     try {
    //         $productModel = $this->registerProducts->findAll();
    //         if (! $productModel) {
    //             return response()->json(['message' => 'No products found.'], 404);
    //         }

    //         $products = array_map(fn ($productModel) => $productModel->toArray(), $productModel);

    //         return response()->json(compact('products'), 200);
    //     } catch (\Exception $e) {
    //         return response()->json(['message' => $e->getMessage()], 404);
    //     }
    // }

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
        if ($request->file('productImage')) {
            $image = $request->file('productImage');
            $destinationpath = 'images';

            $imageName = time().'.'.$image->getClientOriginalExtension();
            $image->move($destinationpath, $imageName);

            $data['image'] = $imageName;
        } else {
            $data['image'] = 'default.jpg';
        }

        // dd($data);

        $this->registerProducts->create(
            $this->generateProductId(),
            $data['productName'],
            $data['productPrice'],
            'default.jpg',
            $data['productStock'],
            $data['productDescription'],
        );

        return redirect()->route('product.index')->with('success', 'Product successfullly created');
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
        // dd($data);

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

    public function deleteitem($id)
    {
        $deletedProduct = $this->registerProducts->delete($id);
        if (! $deletedProduct) {
            return redirect()->route('product.index')->with('error', 'Product not found');
        }

        return redirect()->route('product.index')->with('success', 'Product deleted successfully');
    }
}
