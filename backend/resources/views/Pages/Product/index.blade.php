@extends('Layout.app')

@section('title', 'Products')

@include('Components.NaBar.navbar')

@section('content')

    <div style="padding: 20px; background-color: #f7f0e3; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">

        <div style="display: flex; justify-content: flex-end; gap: 10px;">
            <a href="{{ route('product.archive') }}"
                style="padding: 10px; background-color: #6b4226; color: white; text-decoration: none; border-radius: 8px; margin-bottom: 20px;">
                View Archived Products
            </a>
            <button onclick="showAddProductModal()"
                style="padding: 10px; background-color: #4b3025; color: white; border: none; border-radius: 8px; cursor: pointer; margin-bottom: 20px;">
                + Add Product
            </button>
        </div>
        <h1 style="text-align: center; margin-bottom: 2rem; font-size: 2.5rem; color: #6b4226; font-weight: bold;">
            Coffee Menu
        </h1>

        @if (session('error'))
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                {{ session('error') }}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        @endif

        <div id="product-container" style="display: grid; grid-template-columns: repeat(3, 1fr); gap: 30px; padding: 20px;">
            @if (count($products) > 0)
                @foreach ($products as $product)
                    <div
                        style="background-color: white; border-radius: 15px; padding: 20px; box-shadow: 0 4px 8px rgba(0,0,0,0.1); display: flex; flex-direction: column; height: 100%;">
                        {{-- <div
                            style="margin-bottom: 15px; height: 500px; border-radius: 12px; overflow: hidden; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                            <img src="{{ asset('images/' . ($product['product_image'] ?? 'default.jpg')) }}"
                                alt="{{ $product['product_name'] }}"
                                style="max-width: 100%; max-height: 100%; object-fit: contain; width: auto; height: auto;"
                                onerror="this.src='{{ asset('images/default.jpg') }}'">
                        </div> --}}
                        <div
                            style="margin-bottom: 15px; height: 500px; border-radius: 12px; overflow: hidden; display: flex; align-items: center; justify-content: center; background-color: #f8f8f8;">
                            <!-- Add loading="lazy" and cache control -->
                            <img src="{{ asset('images/' . ($product['product_image'] ?? 'default.jpg')) }}"
                                alt="{{ $product['product_name'] }}"
                                style="max-width: 100%; max-height: 100%; object-fit: contain; width: auto; height: auto;"
                                loading="lazy" onerror="this.src='{{ asset('images/default.jpg') }}'; this.onerror=null;"
                                data-product-id="{{ $product['product_id'] }}">
                        </div>
                        <div style="flex-grow: 1; display: flex; flex-direction: column;">
                            <h2 style="font-size: 1.5rem; color: #4b3025; margin-bottom: 10px;">
                                {{ $product['product_name'] }}</h2>
                            <p style="color: #6b4226; font-weight: bold; margin-bottom: 8px;">
                                ₱{{ $product['product_price'] }}</p>
                            <p
                                style="color: {{ $product['product_stock'] < 50 ? '#dc3545' : '#666' }}; margin-bottom: 8px;">
                                Stock: {{ $product['product_stock'] }}
                                @if ($product['product_stock'] < 50)
                                    <span style="font-weight: bold; color: #dc3545;"> (Low Stock)</span>
                                @endif
                            </p>
                            <p style="color: #666; margin-bottom: 15px;">{{ $product['description'] }}</p>

                            <div style="margin-top: auto;">
                                <div style="display: flex; gap: 10px;">
                                    <button onclick="editProduct({{ $loop->index }})"
                                        style="flex: 1; padding: 8px; background-color: #4b3025; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                                        Edit
                                    </button>
                                    <button onclick="return confirm('Are you sure you want to delete this product?')"
                                        type="submit" form="delete-form-{{ $product['product_id'] }}"
                                        style="flex: 1; padding: 8px; background-color: #dc3545; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                                        Delete
                                    </button>
                                    <form id="delete-form-{{ $product['product_id'] }}"
                                        action="{{ route('product.delete', $product['product_id']) }}" method="POST"
                                        style="display: none;">
                                        @csrf
                                        @method('DELETE')
                                    </form>
                                </div>
                            </div>
                        </div>
                    </div>
                @endforeach
            @else
                <div style="text-align: center; grid-column: span 3; padding: 20px;">
                    <p style="color: #666;">No products available.</p>
                </div>
            @endif
        </div>
        {{-- id="edit-modal-form" --}}
        <div id="edit-modal-form" class="modal"
            style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 500px; margin: auto;">
            <form action="{{ route('product.update') }}" method="POST" enctype="multipart/form-data">
                @csrf
                @method('POST')
                <input type="hidden" id="edit-product-id" name="productID">
                <div class="modal-content"
                    style="background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
                    <h2>Edit Product</h2>
                    <input type="hidden" name="user_id" value="{{ Auth::id() }}"><br>
                    <label for="edit-product-name-update">Name</label>
                    <input type="text" id="edit-product-name-update"
                        style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productName">

                    <label for="edit-product-description-update">Description</label>
                    <textarea id="edit-product-description-update" style="width: 100%; padding: 8px; margin-bottom: 10px; height: 100px;"
                        name="productDescription"></textarea>

                    <label for="edit-product-price-update">Price</label>
                    <input type="number" id="edit-product-price-update"
                        style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productPrice">

                    <label for="edit-product-stock-update">Stock</label>
                    <input type="number" id="edit-product-stock-update"
                        style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productStock">

                    <label for="edit-product-image-update">Image</label>
                    <input type="file" id="edit-product-image-update"
                        style="width: 100%; padding: 8px; margin-bottom: 10px;" name="productImage">

                    <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                        <button type="submit"
                            style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                            Update Product
                        </button>
                        <button type="button" onclick="closeEditModalForm()"
                            style="padding: 10px 20px; background-color: #f44336; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                            Cancel
                        </button>
                    </div>
                </div>
            </form>
        </div>




        <div id="edit-modal" class="modal"
            style="display: none; position: fixed; top: 50%; left: 50%; transform: translate(-50%, -50%); z-index: 9999; width: 500px; margin: auto;">
            <form id="addProductForm" action="{{ route('product.create') }}" method="POST" enctype="multipart/form-data">
                @csrf
                <div class="modal-content"
                    style="background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
                    <h2>Add Product</h2>

                    <div id="validation-errors"
                        style="display: none; background-color: #fee2e2; border: 1px solid #ef4444; padding: 10px; border-radius: 8px; margin-bottom: 15px;">
                        <ul style="list-style: none; margin: 0; padding: 0;">

                        </ul>
                    </div>
                    <input type="hidden" name="user_id" value="{{ Auth::id() }}"><br>

                    <label for="edit-product-name">Name</label>
                    <input type="text" id="edit-product-name" style="width: 100%; padding: 8px; margin-bottom: 10px;"
                        name="product_name" required>

                    <label for="edit-product-description">Description</label>
                    <textarea id="edit-product-description" style="width: 100%; padding: 8px; margin-bottom: 10px; height: 100px;"
                        name="productDescription" required></textarea>

                    <label for="edit-product-price">Price</label>
                    <input type="number" id="edit-product-price" style="width: 100%; padding: 8px; margin-bottom: 10px;"
                        name="productPrice" required step="0.01" min="0">

                    <label for="edit-product-stock">Stock</label>
                    <input type="number" id="edit-product-stock" style="width: 100%; padding: 8px; margin-bottom: 10px;"
                        name="productStock" required min="0">

                    <label for="edit-product-image">Image</label>
                    <input type="file" id="edit-product-image" style="width: 100%; padding: 8px; margin-bottom: 10px;"
                        name="productImage" accept="image/*">

                    <div style="display: flex; justify-content: space-between;
                        margin-top: 20px;">
                        <button type="submit"
                            style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">
                            Save Changes
                        </button>
                        <button type="submit" onclick="closeEditModal(event)"
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

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script>
        // Edit product function
        function editProduct(index) {
            const products = @json($products);
            if (products && products[index]) {
                const product = products[index];
                document.getElementById('edit-product-id').value = product.product_id;
                document.getElementById('edit-product-name-update').value = product.product_name;
                document.getElementById('edit-product-description-update').value = product.description;
                document.getElementById('edit-product-price-update').value = product.product_price;
                document.getElementById('edit-product-stock-update').value = product.product_stock;
                document.getElementById('edit-modal-form').style.display = 'block';
                document.getElementById('overlay').style.display = 'block';
            }
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

        // document.getElementById('addProductForm').addEventListener('submit', function(e) {
        //     e.preventDefault();

        //     const formData = new FormData(this);
        //     const validationErrors = document.getElementById('validation-errors');
        //     const errorList = validationErrors.querySelector('ul');

        //     // Clear previous errors
        //     errorList.innerHTML = '';
        //     validationErrors.style.display = 'none';

        //     fetch(this.action, {
        //             method: 'POST',
        //             body: formData,
        //             credentials: 'same-origin'
        //         })
        //         .then(response => {
        //             if (!response.ok) {
        //                 throw new Error('Network response was not ok');
        //             }
        //             return response.json();
        //         })
        //         .then(data => {
        //             if (data.errors) {
        //                 // Display validation errors
        //                 Object.values(data.errors).forEach(error => {
        //                     const li = document.createElement('li');
        //                     li.style.color = '#dc2626';
        //                     li.style.marginBottom = '5px';
        //                     li.textContent = error[0];
        //                     errorList.appendChild(li);
        //                 });
        //                 validationErrors.style.display = 'block';
        //             } else {
        //                 // Close modal and refresh page on success
        //                 closeEditModal();
        //                 window.location.reload();
        //             }
        //         })
        //         .catch(error => {
        //             console.error('Error:', error);
        //             const li = document.createElement('li');
        //             li.style.color = '#dc2626';
        //             li.textContent = 'ProductName is exist. Please try again.';
        //             errorList.appendChild(li);
        //             validationErrors.style.display = 'block';
        //         });
        // });

        function closeEditModalForm() {
            document.getElementById('edit-modal-form').style.display = 'none';
            document.getElementById('overlay').style.display = 'none';
        }

        // document.querySelector('form[action="{{ route('product.update') }}"]').addEventListener('submit', function(e) {
        //     e.preventDefault();

        //     const formData = new FormData(this);

        //     fetch(this.action, {
        //             method: 'POST',
        //             body: formData,
        //             credentials: 'same-origin'
        //         })
        //         .then(response => {
        //             if (!response.ok) {
        //                 throw new Error('Network response was not ok');
        //             }
        //             return response.json();
        //         })
        //         .then(data => {
        //             if (data.errors) {
        //                 // Show error message
        //                 alert('Error updating product: ' + Object.values(data.errors).flat().join('\n'));
        //             } else {
        //                 // Close modal and refresh page on success
        //                 closeEditModalForm();
        //                 window.location.reload();
        //             }
        //         })
        //         .catch(error => {
        //             console.error('Error:', error);
        //             alert('An error occurred while updating the product');
        //         });
        // });
    </script>
@endsection
