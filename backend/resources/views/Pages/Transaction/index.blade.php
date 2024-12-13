@extends('Layout.app')
@section('title', 'Transactions')
@include('Components.NaBar.navbar')
@section('content')
    <div class="container-fluid py-4" style="background-color: #fff8e7; min-height: calc(100vh - 56px);">
        <div class="row">
            <!-- Main Transaction Table -->
            <div class="col-md-8">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2 class="text-brown mb-0">Transaction History</h2>
                    <div class="d-flex gap-3">
                        <input type="text" id="searchInput" class="form-control" placeholder="Search transactions..."
                            style="width: 250px;">
                        <select id="sortOrder" class="form-select" style="width: 150px;">
                            <option value="newest">Newest First</option>
                            <option value="oldest">Oldest First</option>
                        </select>
                    </div>
                </div>

                @if (count($transactions) > 0)
                    @foreach ($transactions as $transaction)
                        <div class="card shadow-sm mb-3">
                            <div class="card-body">
                                <div class="d-flex justify-content-between align-items-start mb-2">
                                    <div>
                                        <h5 class="mb-1">
                                            <span class="badge bg-success ms-2">Completed</span>
                                        </h5>
                                        <p class="text-muted mb-0">
                                            {{ $transaction->created_at->setTimezone('Asia/Manila')->format('M d, Y h:i A') }}
                                        </p>
                                    </div>
                                    <h5 class="text-success mb-0">₱{{ number_format($transaction->total_order, 2) }}</h5>
                                </div>

                                <div class="mt-3">
                                    <h6 class="mb-2">Order Details:</h6>
                                    <div class="table-responsive">
                                        <table class="table table-sm">
                                            <thead class="table-light">
                                                <tr>
                                                    <th>Item</th>
                                                    <th>Qty</th>
                                                    <th>Price</th>
                                                    <th>Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                @php
                                                    $orderList = json_decode($transaction->order_list, true);
                                                @endphp
                                                @foreach ($orderList as $item)
                                                    <tr>
                                                        <td>{{ $item['name'] }}</td>
                                                        <td>{{ $item['quantity'] }}</td>
                                                        <td>₱{{ number_format($item['price'], 2) }}</td>
                                                        <td>₱{{ number_format($item['price'] * $item['quantity'], 2) }}</td>
                                                    </tr>
                                                @endforeach
                                            </tbody>
                                        </table>
                                    </div>
                                    <p class="text-muted mb-0">Total Items: {{ $transaction->quantity }}</p>
                                </div>
                            </div>
                        </div>
                    @endforeach
                @else
                    <div class="text-center py-5">
                        <i class="fas fa-receipt fa-3x text-muted mb-3"></i>
                        <h3 class="text-muted">No transactions found</h3>
                        <p class="text-muted">Transactions will appear here once sales are made.</p>
                    </div>
                @endif
            </div>

            <!-- Summary Section -->
            <div class="col-md-4">
                <div class="card shadow-lg border-0">
                    <div class="card-header bg-brown text-white py-3">
                        <h3 class="mb-0">Transaction Summary</h3>
                    </div>
                    <div class="card-body">
                        @php
                            $totalSales = 0;
                            $totalItems = 0;

                            foreach ($transactions as $transaction) {
                                $totalSales += $transaction->total_order;
                                $totalItems += $transaction->quantity;
                            }
                        @endphp

                        <div class="summary-item mb-4">
                            <h4 class="text-brown">Total Transactions</h4>
                            <p class="h2 mb-0">{{ count($transactions) }}</p>
                        </div>

                        <div class="summary-item mb-4">
                            <h4 class="text-brown">Total Revenue</h4>
                            <p class="h2 mb-0">₱{{ number_format($totalSales, 2) }}</p>
                        </div>

                        <div class="summary-item">
                            <h4 class="text-brown">Total Items Sold</h4>
                            <p class="h2 mb-0">{{ number_format($totalItems) }}</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        .bg-brown {
            background-color: #6b4226;
        }

        .text-brown {
            color: #6b4226;
        }

        .card {
            border-radius: 10px;
            border: none;
        }

        .summary-item {
            padding: 15px;
            border-radius: 10px;
            background-color: #fff8e7;
        }

        .summary-item h4 {
            font-size: 1.1rem;
            margin-bottom: 8px;
        }

        .table th {
            font-weight: 600;
            color: #4b3025;
        }

        .badge {
            padding: 0.5em 0.75em;
        }

        .form-control,
        .form-select {
            border-color: #d4b8a5;
        }

        .form-control:focus,
        .form-select:focus {
            border-color: #6b4226;
            box-shadow: 0 0 0 0.2rem rgba(107, 66, 38, 0.25);
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchInput');
            const sortOrder = document.getElementById('sortOrder');
            const transactionCards = document.querySelectorAll('.card.shadow-sm.mb-3');
            const transactionContainer = transactionCards[0]?.parentElement;

            function filterAndSortTransactions() {
                const searchTerm = searchInput.value.toLowerCase();
                const isNewest = sortOrder.value === 'newest';

                let visibleTransactions = Array.from(transactionCards).filter(card => {
                    const orderDetails = card.textContent.toLowerCase();
                    return orderDetails.includes(searchTerm);
                });

                // Sort transactions
                visibleTransactions.sort((a, b) => {
                    const dateA = new Date(a.querySelector('.text-muted').textContent.trim());
                    const dateB = new Date(b.querySelector('.text-muted').textContent.trim());
                    return isNewest ? dateB - dateA : dateA - dateB;
                });

                // Clear and re-append sorted/filtered transactions
                transactionCards.forEach(card => card.style.display = 'none');
                visibleTransactions.forEach(card => {
                    card.style.display = 'block';
                    transactionContainer.appendChild(card);
                });
            }

            searchInput.addEventListener('input', filterAndSortTransactions);
            sortOrder.addEventListener('change', filterAndSortTransactions);
        });
    </script>
@endsection
