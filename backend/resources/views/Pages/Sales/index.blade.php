@extends('Layout.app')
@section('title', 'Sales Interface')
@include('Components.NaBar.navbar')

@section('content')

    <style>
        .product-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            text-align: center;
            background-color: #f9f9f9;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }

        .product-list {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
            justify-content: center;
            margin-bottom: 30px;
        }

        .product-list .product-card {
            width: 220px;
        }

        .cart-table th,
        .cart-table td {
            text-align: center;
        }

        .checkout-btn {
            width: 100%;
        }

        .cart-summary {
            display: flex;
            justify-content: space-between;
            margin-top: 20px;
        }

        .cart-summary p {
            font-size: 18px;
        }

        .cart-summary .total-price {
            font-weight: bold;
            font-size: 20px;
        }

        .quantity-controls {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 10px;
        }

        .quantity-controls button {
            font-size: 18px;
            padding: 5px 10px;
        }

        .quantity-controls input {
            text-align: center;
            width: 50px;
            font-size: 16px;
        }

        .remove-btn {
            display: inline-block;
            padding: 5px 15px;
            margin-left: 10px;
            color: white;
            background-color: red;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            font-weight: bold;
        }

        .remove-btn:hover {
            background-color: darkred;
        }

        /* Modal styles */
        .modal-content {
            padding: 20px;
            text-align: center;
            border-radius: 8px;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .modal-header {
            border-bottom: 2px solid #ddd;
            padding-bottom: 10px;
        }

        .modal-body {
            padding: 20px 0;
        }

        .modal-footer {
            padding-top: 10px;
            border-top: 2px solid #ddd;
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            display: none;
            justify-content: center;
            align-items: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        /* Additional Styling for Transaction Modal */
        .transaction-summary h5 {
            font-size: 24px;
            margin-bottom: 10px;
            color: #333;
        }

        .transaction-summary ul {
            list-style: none;
            padding: 0;
            margin-bottom: 20px;
            font-size: 16px;
            color: #666;
        }

        .transaction-summary li {
            padding: 5px 0;
        }

        .transaction-summary .total {
            font-weight: bold;
            font-size: 20px;
            color: #333;
        }
    </style>

    <div class="container my-5">
        <div class="row mb-4">
            <div class="col-12 text-center">
                <h2>Sales Interface</h2>
                <p>Browse and add items to your cart.</p>
                <div id="order-info" class="text-center mb-4">
                    <h4>Order #: <span id="order-number">001</span></h4>
                    <p id="order-date"></p>
                </div>
            </div>
        </div>

        <div class="product-list">
            <!-- Product Cards -->
            <div class="product-card">
                <h5>Product 1</h5>
                <p>$10.00</p>
                <button class="btn btn-primary add-to-cart" data-product="Product 1" data-price="10.00">Add to Cart</button>
            </div>
            <div class="product-card">
                <h5>Product 2</h5>
                <p>$15.00</p>
                <button class="btn btn-primary add-to-cart" data-product="Product 2" data-price="15.00">Add to Cart</button>
            </div>
            <div class="product-card">
                <h5>Product 3</h5>
                <p>$20.00</p>
                <button class="btn btn-primary add-to-cart" data-product="Product 3" data-price="20.00">Add to Cart</button>
            </div>
            <div class="product-card">
                <h5>Product 4</h5>
                <p>$25.00</p>
                <button class="btn btn-primary add-to-cart" data-product="Product 4" data-price="25.00">Add to Cart</button>
            </div>
        </div>

        <div class="row">
            <div class="col-12">
                <h4>Your Cart</h4>
                <table class="table table-bordered cart-table">
                    <thead>
                        <tr>
                            <th>Product</th>
                            <th>Price</th>
                            <th>Quantity</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody id="cart-body">
                        <!-- Cart Items Will Be Inserted Here -->
                    </tbody>
                </table>

                <div class="cart-summary">
                    <p>Subtotal:</p>
                    <p class="total-price" id="subtotal">$0.00</p>
                </div>

                <button class="btn btn-success checkout-btn" onclick="showCheckoutModal()">Proceed to Checkout</button>
            </div>
        </div>
    </div>

    <div id="checkoutModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-header">
                <h5>Transaction Summary</h5>
            </div>
            <div class="modal-body transaction-summary" id="transaction-details">
                <!-- Transaction details will be inserted here -->
            </div>
            <div class="modal-footer">
                <button class="btn btn-danger" onclick="closeCheckoutModal()">Close</button>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        let cart = [];
        let orderNumber = 1;

        // Get current date in the format "Month Day, Year"
        function getCurrentDate() {
            const today = new Date();
            const options = {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            };
            return today.toLocaleDateString(undefined, options);
        }

        // Update cart items on the table
        function updateCart() {
            let cartBody = document.getElementById('cart-body');
            cartBody.innerHTML = '';

            let subtotal = 0;
            cart.forEach((item, index) => {
                subtotal += item.totalPrice;
                let row = document.createElement('tr');
                row.innerHTML = `
                    <td>${item.name}</td>
                    <td>$${item.price.toFixed(2)}</td>
                    <td>
                        <div class="quantity-controls">
                            <button class="btn btn-sm btn-secondary" onclick="updateQuantity(${index}, -1)">-</button>
                            <input type="number" class="form-control" value="${item.quantity}" min="1" max="10" onchange="updateQuantity(${index}, this.value)">
                            <button class="btn btn-sm btn-secondary" onclick="updateQuantity(${index}, 1)">+</button>
                        </div>
                    </td>
                    <td><span class="remove-btn" onclick="removeFromCart(${index})">Remove</span></td>
                `;
                cartBody.appendChild(row);
            });

            document.getElementById('subtotal').textContent = `$${subtotal.toFixed(2)}`;
        }

        // Add item to the cart
        function addToCart(productName, productPrice) {
            const existingProduct = cart.find(item => item.name === productName);
            if (existingProduct) {
                existingProduct.quantity++;
                existingProduct.totalPrice = existingProduct.quantity * existingProduct.price;
            } else {
                cart.push({
                    name: productName,
                    price: parseFloat(productPrice),
                    quantity: 1,
                    totalPrice: parseFloat(productPrice)
                });
            }

            updateCart();
        }

        // Update item quantity
        function updateQuantity(index, change) {
            const quantityInput = document.querySelectorAll('.quantity-controls input')[index];
            let newQuantity = parseInt(quantityInput.value) + change;

            if (newQuantity >= 1 && newQuantity <= 10) {
                cart[index].quantity = newQuantity;
                cart[index].totalPrice = cart[index].quantity * cart[index].price;
            }
            updateCart();
        }

        // Remove item from cart
        function removeFromCart(index) {
            cart.splice(index, 1);
            updateCart();
        }

        // Show the checkout modal
        function showCheckoutModal() {
            let modal = document.getElementById('checkoutModal');
            let transactionDetails = document.getElementById('transaction-details');

            // Set order number and date
            document.getElementById('order-number').textContent = orderNumber.toString().padStart(3, '0');
            document.getElementById('order-date').textContent = getCurrentDate();

            // Generate transaction details
            let transactionContent = `<h5>Order #${orderNumber}</h5><p>${getCurrentDate()}</p><ul>`;
            cart.forEach(item => {
                transactionContent +=
                    `<li>${item.name} - ${item.quantity} x $${item.price} = $${item.totalPrice.toFixed(2)}</li>`;
            });
            transactionContent +=
                `</ul><p><strong>Total: $${cart.reduce((sum, item) => sum + item.totalPrice, 0).toFixed(2)}</strong></p>`;

            transactionDetails.innerHTML = transactionContent;

            // Show modal
            modal.classList.add('active');

            // Clear cart after checkout
            cart = [];
            updateCart();

            // Increment order number
            orderNumber++;
        }

        // Close the checkout modal
        function closeCheckoutModal() {
            let modal = document.getElementById('checkoutModal');
            modal.classList.remove('active');
        }

        // Event listener for adding products to the cart
        document.querySelectorAll('.add-to-cart').forEach(button => {
            button.addEventListener('click', () => {
                addToCart(button.getAttribute('data-product'), button.getAttribute('data-price'));
            });
        });

        // Initialize order info with today's date
        document.getElementById('order-date').textContent = getCurrentDate();

        // Initial update of the cart
        updateCart();
    </script>

@endsection
