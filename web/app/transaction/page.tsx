'use client';

import { useState } from 'react';
import { TransactionDetail } from '@/context/transactioncontext';
import { useTransactions } from '../Hooks/UseTransaction/useTransaction';
import { useRouter } from 'next/navigation';

export default function TransactionPage() {
    const router = useRouter();
    const { transactions, loading, error } = useTransactions();
    const [searchTerm, setSearchTerm] = useState('');
    const [sortOrder, setSortOrder] = useState<'newest' | 'oldest'>('newest');
    const [showModal, setShowModal] = useState(false);
    const [transactionDetails, setTransactionDetails] = useState<TransactionDetail | null>(null);

    const filteredAndSortedTransactions = transactions
        .filter(transaction =>
            JSON.stringify(transaction).toLowerCase().includes(searchTerm.toLowerCase())
        )
        .sort((a, b) => {
            const dateA = new Date(a.date).getTime();
            const dateB = new Date(b.date).getTime();
            return sortOrder === 'newest' ? dateB - dateA : dateA - dateB;
        });

    const calculateTotalSales = () =>
        transactions.reduce((sum, transaction) => sum + transaction.total, 0);

    const calculateTotalItems = () =>
        transactions.reduce((sum, transaction) => sum + transaction.items.length, 0);

    const handleTransactionClick = (transaction: TransactionDetail) => {
        setTransactionDetails({
            orderId: transaction.orderId,
            date: new Date(transaction.date).toLocaleDateString('en-US', {
                year: 'numeric',
                month: 'long',
                day: 'numeric'
            }),
            items: transaction.items.map(item => ({
                ...item,
                total: item.price * item.quantity
            })),
            total: transaction.total
        });
        setShowModal(true);
    };

    if (loading) {
        return (
            <div className="flex justify-center items-center min-h-screen bg-[#fff8e7]">
                <div className="animate-spin rounded-full h-12 w-12 border-t-2 border-b-2 border-[#6b4226]"></div>
            </div>
        );
    }

    if (error) {
        return (
            <div className="flex justify-center items-center min-h-screen bg-[#fff8e7]">
                <div className="text-red-600">Error: {error}</div>
            </div>
        );
    }

    return (
        <div className="container-fluid py-4 bg-[#fff8e7] min-h-screen">
            <button
                onClick={() => router.push('/homepage')}
                className="mb-6 px-6 py-2 bg-[#6b4226] text-white rounded-lg hover:bg-[#5a371f] transition-colors flex items-center gap-2"
            >
                <svg xmlns="http://www.w3.org/2000/svg" className="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
                    <path fillRule="evenodd" d="M9.707 16.707a1 1 0 01-1.414 0l-6-6a1 1 0 010-1.414l6-6a1 1 0 011.414 1.414L5.414 9H17a1 1 0 110 2H5.414l4.293 4.293a1 1 0 010 1.414z" clipRule="evenodd" />
                </svg>
                Back
            </button>

            <div className="flex flex-col lg:flex-row gap-6">
                {/* Main Transaction Table */}
                <div className="lg:w-2/3">
                    <div className="flex justify-between items-center mb-4">
                        <h2 className="text-[#6b4226] text-2xl font-bold">Transaction History</h2>
                        <div className="flex gap-3">
                            <input
                                type="text"
                                placeholder="Search transactions..."
                                className="form-input border-[#d4b8a5] focus:border-[#6b4226] rounded-lg"
                                value={searchTerm}
                                onChange={(e) => setSearchTerm(e.target.value)}
                            />
                            <select
                                className="form-select border-[#d4b8a5] focus:border-[#6b4226] rounded-lg"
                                value={sortOrder}
                                onChange={(e) => setSortOrder(e.target.value as 'newest' | 'oldest')}
                            >
                                <option value="newest">Newest First</option>
                                <option value="oldest">Oldest First</option>
                            </select>
                        </div>
                    </div>

                    {filteredAndSortedTransactions.length > 0 ? (
                        filteredAndSortedTransactions.map((transaction) => (
                            <div
                                key={transaction.orderId}
                                className="bg-white rounded-lg shadow-sm mb-3 p-4 cursor-pointer hover:shadow-md transition-shadow"
                                onClick={() => handleTransactionClick(transaction)}
                            >
                                <div className="flex justify-between items-start mb-2">
                                    <div>
                                        <h5 className="text-lg font-semibold">
                                            Order #{transaction.orderId}
                                            <span className="ml-2 bg-green-500 text-white text-sm px-2 py-1 rounded">
                                                Completed
                                            </span>
                                        </h5>
                                        <p className="text-gray-600">
                                            {new Date(transaction.date).toLocaleString()}
                                        </p>
                                    </div>
                                    <h5 className="text-green-600 font-semibold">
                                        ₱{transaction.total.toFixed(2)}
                                    </h5>
                                </div>

                                <div className="mt-3">
                                    <h6 className="font-semibold mb-2">Order Details:</h6>
                                    <div className="overflow-x-auto">
                                        <table className="min-w-full">
                                            <thead className="bg-gray-50">
                                                <tr>
                                                    <th className="px-4 py-2 text-left text-[#4b3025]">Item</th>
                                                    <th className="px-4 py-2 text-left text-[#4b3025]">Qty</th>
                                                    <th className="px-4 py-2 text-left text-[#4b3025]">Price</th>
                                                    <th className="px-4 py-2 text-left text-[#4b3025]">Subtotal</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                {transaction.items.map((item, index) => (
                                                    <tr key={index}>
                                                        <td className="px-4 py-2">{item.name}</td>
                                                        <td className="px-4 py-2">{item.quantity}</td>
                                                        <td className="px-4 py-2">₱{item.price.toFixed(2)}</td>
                                                        <td className="px-4 py-2">
                                                            ₱{(item.price * item.quantity).toFixed(2)}
                                                        </td>
                                                    </tr>
                                                ))}
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        ))
                    ) : (
                        <div className="text-center py-10">
                            <i className="fas fa-receipt text-4xl text-gray-400 mb-3"></i>
                            <h3 className="text-gray-500 text-xl">No transactions found</h3>
                            <p className="text-gray-400">Transactions will appear here once sales are made.</p>
                        </div>
                    )}
                </div>

                {/* Transaction Summary */}
                <div className="lg:w-1/3">
                    <div className="bg-white rounded-lg shadow-lg">
                        <div className="bg-[#6b4226] text-white p-4 rounded-t-lg">
                            <h3 className="text-xl font-bold">Transaction Summary</h3>
                        </div>
                        <div className="p-4">
                            <div className="bg-[#fff8e7] rounded-lg p-4 mb-4">
                                <h4 className="text-[#6b4226] text-lg mb-2">Total Transactions</h4>
                                <p className="text-2xl font-bold">{transactions.length}</p>
                            </div>

                            <div className="bg-[#fff8e7] rounded-lg p-4 mb-4">
                                <h4 className="text-[#6b4226] text-lg mb-2">Total Revenue</h4>
                                <p className="text-2xl font-bold">₱{calculateTotalSales().toFixed(2)}</p>
                            </div>

                            <div className="bg-[#fff8e7] rounded-lg p-4">
                                <h4 className="text-[#6b4226] text-lg mb-2">Total Items Sold</h4>
                                <p className="text-2xl font-bold">{calculateTotalItems()}</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            {showModal && transactionDetails && (
                <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                    <div className="bg-white rounded-lg p-8 max-w-md w-full mx-4">
                        <div className="flex justify-between items-center mb-6">
                            <h2 className="text-2xl font-bold text-[#4b3025]">Transaction Summary</h2>
                            <button
                                onClick={() => setShowModal(false)}
                                className="text-gray-500 hover:text-gray-700"
                            >
                                <span className="text-2xl">×</span>
                            </button>
                        </div>

                        <div className="mb-6">
                            <h3 className="text-xl font-semibold mb-2">Order #{transactionDetails.orderId}</h3>
                            <p className="text-gray-600">{transactionDetails.date}</p>
                        </div>

                        <div className="space-y-4 mb-6">
                            {transactionDetails.items.map((item, index) => (
                                <div key={index} className="flex justify-between text-[#4b3025]">
                                    <span>{item.name} - {item.quantity} × ₱{item.price.toFixed(2)}</span>
                                    <span>₱{item.total.toFixed(2)}</span>
                                </div>
                            ))}
                        </div>

                        <div className="border-t pt-4">
                            <div className="flex justify-between items-center text-xl font-bold text-[#4b3025]">
                                <span>Total:</span>
                                <span>₱{transactionDetails.total.toFixed(2)}</span>
                            </div>
                        </div>
                    </div>
                </div>
            )}
        </div>
    );
}
