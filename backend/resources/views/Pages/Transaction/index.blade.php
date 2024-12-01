@extends('Layout.app')
@section('title', 'Transaction History')
@include('Components.NaBar.navbar')
@section('content')
    <div class="container mt-4">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <div class="d-flex align-items-center">
                <h2 class="mb-0 text-coffee">Transaction History</h2>
            </div>
            <div class="d-flex align-items-center">
                <div class="input-group me-3" style="width: 300px;">
                    <input type="text" id="searchTransaction" class="form-control coffee-input"
                        placeholder="Search transactions...">
                    <button class="btn btn-coffee" type="button">
                        <i class="fas fa-search"></i>
                    </button>
                </div>
                <select class="form-select coffee-select" id="sortTransactions" style="width: 200px;">
                    <option value="newest">Newest First</option>
                    <option value="oldest">Oldest First</option>
                    <option value="highest">Highest Amount</option>
                    <option value="lowest">Lowest Amount</option>
                </select>
            </div>
        </div>

        @if (count($transactions ?? []) > 0)
            <div class="row">
                <div class="col-md-8">
                    <div class="transaction-list">
                        @foreach ($transactions as $transaction)
                            <div class="card mb-3 transaction-card" data-amount="{{ $transaction->total_order }}">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-start">
                                        <div>
                                            <div class="d-flex align-items-center mb-2">
                                                <h5 class="mb-0 text-coffee">Order #{{ $transaction->id }}</h5>
                                                <span class="badge bg-coffee-success ms-2">Completed</span>
                                            </div>
                                            <p class="text-coffee-muted mb-2">
                                                <i class="far fa-calendar-alt me-2"></i>
                                                {{ $transaction->created_at->format('M d, Y h:i A') }}
                                            </p>

                                            <div class="mt-3">
                                                <h6 class="mb-2 text-coffee"><i
                                                        class="fas fa-shopping-basket me-2"></i>Order Details:</h6>
                                                @php
                                                    $orderList = json_decode($transaction->order_list, true);
                                                @endphp
                                                <div class="table-responsive">
                                                    <table class="table table-sm table-borderless mb-0">
                                                        <thead class="text-coffee-muted">
                                                            <tr>
                                                                <th>Item</th>
                                                                <th class="text-center">Qty</th>
                                                                <th class="text-end">Price</th>
                                                                <th class="text-end">Subtotal</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            @foreach ($orderList as $item)
                                                                <tr class="text-coffee-dark">
                                                                    <td>{{ $item['name'] }}</td>
                                                                    <td class="text-center">{{ $item['quantity'] }}</td>
                                                                    <td class="text-end">
                                                                        ₱{{ number_format($item['price'], 2) }}</td>
                                                                    <td class="text-end">
                                                                        ₱{{ number_format($item['price'] * $item['quantity'], 2) }}
                                                                    </td>
                                                                </tr>
                                                            @endforeach
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="text-end">
                                            <h4 class="mb-1 text-coffee-success">
                                                ₱{{ number_format($transaction->total_order, 2) }}</h4>
                                            <small class="text-coffee-muted">Total Items:
                                                {{ $transaction->quantity }}</small>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        @endforeach
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card summary-card">
                        <div class="card-body">
                            <h5 class="card-title mb-4 text-coffee">Transaction Summary</h5>
                            <div class="summary-stats">
                                <div class="mb-3">
                                    <label class="text-coffee-muted">Total Transactions</label>
                                    <h3 class="text-coffee">{{ count($transactions) }}</h3>
                                </div>
                                <div class="mb-3">
                                    <label class="text-coffee-muted">Total Revenue</label>
                                    <h3 class="text-coffee-success">
                                        ₱{{ number_format($transactions->sum('total_order'), 2) }}</h3>
                                </div>
                                <div class="mb-3">
                                    <label class="text-coffee-muted">Total Items Sold</label>
                                    <h3 class="text-coffee">{{ $transactions->sum('quantity') }}</h3>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        @else
            <div class="text-center my-5">
                <i class="fas fa-receipt fa-3x text-coffee-muted mb-3"></i>
                <h4 class="text-coffee-muted">No transactions yet</h4>
                <p class="text-coffee-muted">Start making sales to see your transaction history here.</p>
                <a href="{{ url('/sales') }}" class="btn btn-coffee mt-2">
                    <i class="fas fa-shopping-cart me-2"></i>Go to Sales
                </a>
            </div>
        @endif
    </div>

    <style>
        :root {
            --coffee-primary: #4b3025;
            --coffee-secondary: #8b5e3c;
            --coffee-light: #d4b8a5;
            --coffee-lighter: #f5e6d3;
            --coffee-dark: #2c1810;
            --coffee-success: #5d8b3c;
            --coffee-muted: #8c7b75;
            --coffee-bg: #fff8e7;
        }

        body {
            background-color: var(--coffee-bg);
        }

        .text-coffee {
            color: var(--coffee-primary);
        }

        .text-coffee-dark {
            color: var(--coffee-dark);
        }

        .text-coffee-muted {
            color: var(--coffee-muted);
        }

        .text-coffee-success {
            color: var(--coffee-success);
        }

        .bg-coffee {
            background-color: var(--coffee-primary);
            color: white;
        }

        .bg-coffee-success {
            background-color: var(--coffee-success);
            color: white;
        }

        .btn-coffee {
            background-color: var(--coffee-primary);
            color: white;
            border: none;
        }

        .btn-coffee:hover {
            background-color: var(--coffee-dark);
            color: white;
        }

        .btn-outline-coffee {
            color: var(--coffee-primary);
            border-color: var(--coffee-primary);
        }

        .btn-outline-coffee:hover {
            background-color: var(--coffee-primary);
            color: white;
        }

        .coffee-input {
            border-color: var(--coffee-light);
        }

        .coffee-input:focus {
            border-color: var(--coffee-primary);
            box-shadow: 0 0 0 0.2rem rgba(75, 48, 37, 0.25);
        }

        .coffee-select {
            border-color: var(--coffee-light);
            color: var(--coffee-dark);
        }

        .coffee-select:focus {
            border-color: var(--coffee-primary);
            box-shadow: 0 0 0 0.2rem rgba(75, 48, 37, 0.25);
        }

        .transaction-card {
            transition: transform 0.2s ease-in-out;
            border: 1px solid var(--coffee-light);
            background-color: white;
            box-shadow: 0 2px 4px rgba(75, 48, 37, 0.05);
        }

        .transaction-card:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(75, 48, 37, 0.1);
        }

        .summary-card {
            background-color: white;
            border: 1px solid var(--coffee-light);
            box-shadow: 0 2px 4px rgba(75, 48, 37, 0.05);
        }

        .badge {
            padding: 0.5em 1em;
            font-weight: 500;
        }

        .summary-stats label {
            font-size: 0.875rem;
            margin-bottom: 0.25rem;
        }

        .summary-stats h3 {
            font-weight: 600;
            margin: 0;
        }

        .table th {
            font-weight: 500;
            font-size: 0.875rem;
            color: var(--coffee-muted);
        }

        .table td {
            font-size: 0.875rem;
            color: var(--coffee-dark);
        }

        #searchTransaction {
            border-right: none;
        }

        #sortTransactions {
            border-color: var(--coffee-light);
        }

        /* Custom scrollbar for webkit browsers */
        ::-webkit-scrollbar {
            width: 8px;
        }

        ::-webkit-scrollbar-track {
            background: var(--coffee-lighter);
        }

        ::-webkit-scrollbar-thumb {
            background: var(--coffee-light);
            border-radius: 4px;
        }

        ::-webkit-scrollbar-thumb:hover {
            background: var(--coffee-secondary);
        }
    </style>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const searchInput = document.getElementById('searchTransaction');
            const sortSelect = document.getElementById('sortTransactions');
            const transactionList = document.querySelector('.transaction-list');
            const transactionCards = document.querySelectorAll('.transaction-card');

            // Search functionality
            searchInput.addEventListener('input', function(e) {
                const searchTerm = e.target.value.toLowerCase();
                transactionCards.forEach(card => {
                    const text = card.textContent.toLowerCase();
                    card.style.display = text.includes(searchTerm) ? '' : 'none';
                });
            });

            // Sort functionality
            sortSelect.addEventListener('change', function(e) {
                const sortValue = e.target.value;
                const cardsArray = Array.from(transactionCards);

                cardsArray.sort((a, b) => {
                    const aAmount = parseFloat(a.dataset.amount);
                    const bAmount = parseFloat(b.dataset.amount);
                    const aDate = new Date(a.querySelector('.text-muted').textContent.trim());
                    const bDate = new Date(b.querySelector('.text-muted').textContent.trim());

                    switch (sortValue) {
                        case 'newest':
                            return bDate - aDate;
                        case 'oldest':
                            return aDate - bDate;
                        case 'highest':
                            return bAmount - aAmount;
                        case 'lowest':
                            return aAmount - bAmount;
                        default:
                            return 0;
                    }
                });

                cardsArray.forEach(card => transactionList.appendChild(card));
            });
        });
    </script>
@endsection
