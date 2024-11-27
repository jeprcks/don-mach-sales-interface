@extends('Layout.app')

@section('title', 'Products')

@include('Components.NaBar.navbar')

@section('content')
    <div style="padding: 20px; background-color: #f7f0e3; font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;">
        <button onclick="window.location.href='/homepage'"
            style="padding: 10px; background-color: #4b3025; color: white; border: none; border-radius: 8px; cursor: pointer; margin-bottom: 20px; font-weight: bold; font-size: 1rem; transition: background-color 0.2s ease-in-out;">
            ← Back
        </button>
        <h1 style="text-align: center; margin-bottom: 2rem; font-size: 2.5rem; color: #6b4226; font-weight: bold;">
            Coffee Menu
        </h1>

        <div id="product-container" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px;">
            <!-- Product Cards will be injected here dynamically -->
        </div>

        <!-- Edit Product Modal -->
        <div id="edit-modal" class="modal" style="display: none;">
            <div class="modal-content"
                style="background-color: white; padding: 20px; border-radius: 8px; box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);">
                <h2>Edit Product</h2>

                <label for="edit-product-name">Name</label>
                <input type="text" id="edit-product-name" style="width: 100%; padding: 8px; margin-bottom: 10px;">

                <label for="edit-product-description">Description</label>
                <textarea id="edit-product-description" style="width: 100%; padding: 8px; margin-bottom: 10px; height: 100px;"></textarea>

                <label for="edit-product-price">Price</label>
                <input type="number" id="edit-product-price" style="width: 100%; padding: 8px; margin-bottom: 10px;">

                <label for="edit-product-stock">Stock</label>
                <input type="number" id="edit-product-stock" style="width: 100%; padding: 8px; margin-bottom: 10px;">

                <div style="display: flex; justify-content: space-between; margin-top: 20px;">
                    <button onclick="saveEdit()"
                        style="padding: 10px 20px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">Save
                        Changes</button>
                    <button onclick="closeEditModal()"
                        style="padding: 10px 20px; background-color: #f44336; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold;">Cancel</button>
                </div>
            </div>
        </div>
        <div id="overlay"
            style="display: none; position: fixed; top: 0; left: 0; width: 100%; height: 100%; background-color: rgba(0, 0, 0, 0.5); z-index: 999;">
        </div>
    </div>

    <script>
        const products = [{
                name: 'Brown Spanish',
                description: 'Brown Spanish Latte is basically espresso-based coffee with milk.',
                price: 39,
                stock: 100,
                image: '/images/Productlist/donmacnew.jpg',
            },
            {
                name: 'Oreo Coffee',
                description: 'Oreo Iced Coffee Recipe is perfect for a hot summer day.',
                price: 39,
                stock: 50,
                image: '/images/Productlist/donmacnew.jpg',
            },
            {
                name: 'Black Forest',
                description: 'A decadent symphony of flavors featuring Belgian dark chocolate and Taiwanese strawberries.',
                price: 39,
                stock: 50,
                image: '/images/Productlist/blackforest.jpg',
            },
            {
                name: 'Don Darko',
                description: 'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk.',
                price: 39,
                stock: 50,
                image: '/images/Productlist/dondarko.jpg',
            }
        ];

        // Function to display products
        function displayProducts() {
            const productContainer = document.getElementById('product-container');
            productContainer.innerHTML = ''; // Clear existing products
            products.forEach((product, index) => {
                const productCard = document.createElement('div');
                productCard.style = `
                    background-color: #fff;
                    border-radius: 12px;
                    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
                    overflow: hidden;
                    display: flex;
                    flex-direction: column;
                    align-items: center;
                `;
                productCard.innerHTML = `
                    <div style="width: 100%; display: flex; justify-content: center; align-items: center; padding: 10px; background-color: #fff8e7; border-bottom: 1px solid #ddd;">
                        <img src="${product.image}" alt="${product.name}" style="max-width: 60%; height: auto; object-fit: cover; border-radius: 8px;">
                    </div>
                    <div style="padding: 15px; text-align: center;">
                        <h2 style="font-size: 1.5rem; font-weight: bold; color: #4b3025; margin-bottom: 10px;">${product.name}</h2>
                        <p style="font-size: 1rem; color: #555; margin-bottom: 10px;">${product.description}</p>
                        <p style="font-size: 1.2rem; font-weight: bold; color: #6b4226; margin-bottom: 10px;">Price: ₱${product.price}</p>
                        <p style="font-size: 1rem; color: #4b4225;">Stock: ${product.stock}</p>
                        <div style="display: flex; justify-content: center; margin-top: 10px;">
                            <button onclick="editProduct(${index})" style="padding: 5px; background-color: #4CAF50; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 1rem; transition: background-color 0.2s ease-in-out;">Edit</button>
                            <button onclick="deleteProduct(${index})" style="padding: 5px; background-color: #f44336; color: white; border: none; border-radius: 8px; cursor: pointer; font-weight: bold; font-size: 1rem; transition: background-color 0.2s ease-in-out;">Delete</button>
                        </div>
                    </div>
                `;
                productContainer.appendChild(productCard);
            });
        }

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
        function closeEditModal() {
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
                image: products[index].image, // Keep the original image
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

        // Initial display
        displayProducts();
    </script>
@endsection
