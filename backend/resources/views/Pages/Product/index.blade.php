@extends('Layout.app')

@section('title', 'Products')

@include('Components.NaBar.navbar')

@section('content')

    @if(session('success'))
    <script>alert('session("success")')</script>
    @endif

    @if(session('error'))
    <script>alert('session("error")')</script>
    
    @endif
    <div style="padding: 20px; background-color: #f7f0e3; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
        
        <div style="display: flex; justify-content: flex-start;">
            <div class="col-6">
            <button onclick="window.location.href='/homepage'"
            style="padding: 10px; background-color: #4b3025; color: white; border: none; border-radius: 8px; cursor: pointer; margin-bottom: 20px; font-weight: bold; font-size: 1rem; transition: background-color 0.2s ease-in-out;">
            ← Back
        </button>   
            </div>
      
            <button onclick="showAddProductModal()"
                style="padding: 10px; background-color: #4b3025; color: white; border: none; border-radius: 8px; cursor: pointer; margin-bottom: 20px; font-weight: bold; font-size: 1rem; transition: background-color 0.2s ease-in-out;">
                + Add Product
            </button>
        </div>
        <h1 style="text-align: center; margin-bottom: 2rem; font-size: 2.5rem; color: #6b4226; font-weight: bold;">
            Coffee Menu
        </h1>

        <div id="product-container" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
           @foreach ($products as $product)
           <div style="display: flex; justify-content: space-between; margin-bottom: 20px;">
               <div style="width: 48%;">
                   <h2>{{$product['product_name']}}</h2>
                   <!-- <h2>{{$product['id']}}</h2> -->
                   <p>Price: {{$product['product_price']}}</p>
                   <p>Stock: {{$product['product_stock']}}</p>
                   <p>Description: {{$product['description']}}</p>
                   <button onclick="editProduct({{ $loop->index }})"
                       style="padding: 5px 10px; background-color: #4b3025; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">
                       Edit
                   </button>                  
                   <form action="/deleteitem/{{$product['id']}}" method="post">
                    @csrf
                    <button style="margin-top:10px; padding: 5px 10px; background-color: #4b3025; color: white; border: none; border-radius: 5px; cursor: pointer; font-weight: bold;">
                            Delete
                        </button>
                   </form>
                    
               </div>
               <div style="width: 48%;">
                   <img src="{{asset('images/' . $product['product_image'])}}" alt="{{$product['product_name']}}">
               </div>
           </div>
           @endforeach
        </div>

        <div id="edit-modal-form" class="modal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 500px; margin: auto;">
    <form action="{{ route('product.update') }}" method="POST" enctype="multipart/form-data">
        @csrf
        @method('post')
        <input type="hidden" id="edit-product-id" name="productID" value="{{$product['product_id']}}">
        <div class="modal-content" style="background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
            <h2>Edit Product</h2>

            <label for="edit-product-name-update">Name</label>
            <input type="text" id="edit-product-name-update" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productName">

            <label for="edit-product-description-update">Description</label>
            <textarea id="edit-product-description-update" style="width: 100%; padding: 8px; margin-bottom: 10px; height: 100px;" name="productDescription"></textarea>

            <label for="edit-product-price-update">Price</label>
            <input type="number" id="edit-product-price-update" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productPrice">

            <label for="edit-product-stock-update">Stock</label>
            <input type="number" id="edit-product-stock-update" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productStock">

            <label for="edit-product-image-update">Image</label>
            <input type="file" id="edit-product-image-update" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productImage">

            <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                <button type="submit" style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                    Update Product
                </button>
                <button type="button" onclick="closeEditModalForm()" style="padding: 10px 20px; background-color: #f44336; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                    Cancel
                </button>
            </div>
        </div>
    </form>
</div>




        <div id="edit-modal" class="modal" style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 500px; margin: auto;">
            <form action="{{ route('product.create') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="modal-content"
                    style="background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
                    <h2>Add Product</h2>

                    <label for="edit-product-name">Name</label>
                    <input type="text" id="edit-product-name" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productName">

                    <label for="edit-product-description">Description</label>
                    <textarea id="edit-product-description" style="width: 100%; padding: 8px; margin-bottom: 10px; height: 100px;" name="productDescription"></textarea>

                    <label for="edit-product-price">Price</label>
                    <input type="number" id="edit-product-price" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productPrice">

                    <label for="edit-product-stock">Stock</label>
                    <input type="number" id="edit-product-stock" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productStock">

                    <label for="edit-product-image">Image</label>
                    <input type="file" id="edit-product-image" style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productImage>

                    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                        <button onclick="saveEdit()"
                            type="submit"
                            style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                            Save Changes
                        </button>
                        <button onclick="closeEditModal(event)"
                            style="padding: 10px 20px; background-color: #f44336; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                            Cancel
                        </button>
                       
                    </div>
                </div>
            </form>
        </div>
        <div id="overlay"
            style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;">
        </div>
    </div>

    <script>

        // Edit product function
        function editProduct(index) {
            const product = products[index];
            document.getElementById('edit-product-name').value = product.name;
            document.getElementById('edit-product-description').value = product.description;
            document.getElementById('edit-product-price').value = product.price;
            document.getElementById('edit-product-stock').value = product.stock;
            showModal();
            document.getElementById('edit-modal').setAttribute('data-index', index); // Store product index for saving
        }

        // Show the modal
        function showModal() {
            document.getElementById('edit-modal').style.display = 'block';
            document.getElementById('overlay').style.display = 'block';
        }

        // Close the modal
        function closeEditModal(event) {
        if (event) {
            event.preventDefault();
        }
        document.getElementById('edit-modal').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }

        // Save the changes made to the product
        function saveEdit() {
            const index = document.getElementById('edit-modal').getAttribute('data-index');
            const updatedProduct = {
                name: document.getElementById('edit-product-name').value,
                description: document.getElementById('edit-product-description').value,
                price: document.getElementById('edit-product-price').value,
                stock: document.getElementById('edit-product-stock').value,
                image: document.getElementById('edit-product-image').value, // Get the image input value
            };
            products[index] = updatedProduct;
            closeEditModal();
            displayProducts();
        }

        // Delete product function
        function deleteProduct(index) {
            products.splice(index, 1);
            displayProducts();
        }

        // Show the modal for adding a product
        function showAddProductModal() {
            // Clear the input fields for a new product
            document.getElementById('edit-product-name').value = '';
            document.getElementById('edit-product-description').value = '';
            document.getElementById('edit-product-price').value = '';
            document.getElementById('edit-product-stock').value = '';
            document.getElementById('edit-product-image').value = ''; // Clear the image input field
            document.getElementById('edit-modal').setAttribute('data-index', 'new'); // Indicate new product
            showModal();
        }

        // Initial display
        displayProducts();


        function editProduct(index) {
        const product = @json($products);
        document.getElementById('edit-product-id').value = product[index].id;
        document.getElementById('edit-product-name-update').value = product[index].product_name;
        document.getElementById('edit-product-description-update').value = product[index].description;
        document.getElementById('edit-product-price-update').value = product[index].product_price;
        document.getElementById('edit-product-stock-update').value = product[index].product_stock;
        document.getElementById('edit-modal-form').style.display = 'block';
        document.getElementById('overlay').style.display = 'block';
    }

    function closeEditModalForm() {
        document.getElementById('edit-modal-form').style.display = 'none';
        document.getElementById('overlay').style.display = 'none';
    }
    </script>
@endsection
