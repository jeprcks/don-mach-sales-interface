<?php

namespace App\Http\Controllers\Product;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function ProductUpdate(Request $request)
    {

        $id = $request->id;
        $product = $this->RegisterProducts->findByID($id);

        if (! $product) {
            return redirect()->back()->with('error', 'Product not found');
        }

        try {
            $request->validate([
                'name' => [
                    'required',
                    'string',
                    function ($attribute, $value, $fail) {
                        $exist = DB::table('special_product')
                            ->where('product_name', $value)
                            ->exists();
                        if ($exist) {
                            $fail('This product name already exist.');

                        }

                    },
                ],
                'price' => 'required|numeric|min:0',
                'description' => 'required|sring',
                'image' => 'nullable|image',
            ]);
            $imageName = $product->getImage();
            if ($request->hasFile('image')) {
                $image = $request->file('image');
                $destinationPath = 'images';
                $imageName = time().'.'.$image->getClientOriginalExtension();
                $image->move($destinationPath, $imageName);
            }

            $this->RegisterProducts->update(
                $id,
                $request->name,
                $floatval($request->price),
                $imageName,
                $request->description,
                $product->getCreated_at(),
                Carbon::now()->toDateTimeString()
            );

            return redirect('/')->with('success', 'Product Updated Successfully');
        } catch (\Illuminate\Validation\ValidationException $e) {
            return redirect()->back()->with('error', $e->getMessage());
        } catch (\Exception $e) {
            return redirect()->back()->with('error', 'An error occured while updating the product');
        }

    }
}
