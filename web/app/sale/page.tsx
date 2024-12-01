'use client';
import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useSales } from '../Hooks/useSales/useSales';
import Image from 'next/image';

export default function Sales(): JSX.Element {
    const router = useRouter();
    const { products, loading, error, cart, setCart, addToCart } = useSales();
    const [showModal, setShowModal] = useState(false);
    const [transactionDetails, setTransactionDetails] = useState<{
        orderId: number;
        date: string;
        items: Array<{
            name: string;
            quantity: number;
            price: number;
            total: number;
        }>;
        total: number;
    } | null>(null);

    const incrementQuantity = (productId: string) => {
        setCart(cart.map(item =>
            item.product_id === productId
                ? { ...item, quantity: item.quantity + 1 }
                : item
        ));
    };

    const decrementQuantity = (productId: string) => {
        setCart(cart.map(item =>
            item.product_id === productId && item.quantity > 1
                ? { ...item, quantity: item.quantity - 1 }
                : item
        ));
    };

    const removeFromCart = (productId: string) => {
        setCart(cart.filter(item => item.product_id !== productId));
    };

    if (loading) return <div className="flex justify-center items-center h-screen">Loading...</div>;
    if (error) return <div className="flex justify-center items-center h-screen">Error: {error}</div>;

    const calculateTotal = () => {
        return cart.reduce((sum, item) => sum + (item.product_price * item.quantity), 0);
    };

    const handleCheckout = async () => {
        if (cart.length === 0) {
            alert('Cart is empty!');
            return;
        }

        try {
            const response = await fetch('http://localhost:8000/api/createSales', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Accept': 'application/json',
                },
                body: JSON.stringify({
                    order_list: cart.map(item => ({
                        product_id: item.product_id,
                        name: item.product_name,
                        price: item.product_price,
                        quantity: item.quantity,
                        totalPrice: item.product_price * item.quantity
                    })),
                    total_order: calculateTotal(),
                    quantity: cart.reduce((sum, item) => sum + item.quantity, 0)
                })
            });

            const data = await response.json();

            if (!response.ok) {
                throw new Error(data.error || 'Failed to process transaction');
            }

            setTransactionDetails({
                orderId: data.transaction_id,
                date: new Date().toLocaleDateString('en-US', {
                    year: 'numeric',
                    month: 'long',
                    day: 'numeric'
                }),
                items: cart.map(item => ({
                    name: item.product_name,
                    quantity: item.quantity,
                    price: item.product_price,
                    total: item.product_price * item.quantity
                })),
                total: calculateTotal()
            });

            setShowModal(true);
            setCart([]);
        } catch (err) {
            console.error('Transaction error:', err);
            alert('Error processing transaction: ' + (err instanceof Error ? err.message : 'Unknown error'));
        }
    };

    return (
        <div className="min-h-screen bg-[#f7f0e3] p-6">
            <div className="max-w-[1400px] mx-auto px-4">
                <div className="text-center mb-8">
                    <div className="relative flex justify-center items-center">
                        <button
                            onClick={() => router.push('/homepage')}
                            className="absolute left-0 bg-[#6b4226] text-white px-4 py-2 rounded-lg hover:bg-[#3a2117] transition-colors"
                        >
                            ← Back
                        </button>
                        <h1 className="text-3xl font-bold text-[#6b4226]">Sales Interface</h1>
                    </div>
                </div>

                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-4 xl:grid-cols-4 gap-6 justify-items-center mx-auto">
                    {products.map((product) => (
                        <div key={product.product_id} className="bg-white rounded-lg shadow-lg overflow-hidden w-full max-w-[250px]">
                            <div className="relative h-[200px] bg-[#fff8e7] border-b border-gray-200">
                                <Image
                                    src={`http://localhost:8000/images/${product.product_image}`}
                                    alt={product.product_name}
                                    fill
                                    className="object-contain p-4"
                                    sizes="(max-width: 768px) 50vw, (max-width: 1200px) 33vw, 25vw"
                                />
                            </div>
                            <div className="p-4 text-center">
                                <h2 className="text-lg font-bold text-[#4b3025] mb-2">{product.product_name}</h2>
                                <p className="text-[#6b4226] text-lg font-bold mb-3">₱{product.product_price.toFixed(2)}</p>
                                <button
                                    onClick={() => addToCart(product)}
                                    className="w-full bg-[#6b4226] text-white py-2 rounded-lg hover:bg-[#4b3025] transition-colors font-semibold"
                                >
                                    Add to Cart
                                </button>
                            </div>
                        </div>
                    ))}
                </div>

                <div className="mt-8 bg-white rounded-lg shadow-lg p-6">
                    <h2 className="text-2xl font-bold text-[#4b3025] mb-4">Your Cart</h2>
                    {cart.length === 0 ? (
                        <p className="text-gray-600">Your cart is empty</p>
                    ) : (
                        <>
                            <table className="w-full mb-4">
                                <thead>
                                    <tr className="border-b">
                                        <th className="text-left py-2 text-[#4b3025]">Product</th>
                                        <th className="text-left py-2 text-[#4b3025]">Price</th>
                                        <th className="text-left py-2 text-[#4b3025]">Quantity</th>
                                        <th className="text-left py-2 text-[#4b3025]">Action</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    {cart.map((item) => (
                                        <tr key={item.product_id} className="border-b">
                                            <td className="py-3 text-[#4b3025]">{item.product_name}</td>
                                            <td className="py-3 text-[#6b4226]">₱{item.product_price.toFixed(2)}</td>
                                            <td className="py-3">
                                                <div className="flex items-center gap-2">
                                                    <button
                                                        onClick={() => decrementQuantity(item.product_id)}
                                                        className="bg-gray-500 text-white w-8 h-8 rounded-lg hover:bg-gray-600"
                                                    >
                                                        -
                                                    </button>
                                                    <span className="w-8 text-center">{item.quantity}</span>
                                                    <button
                                                        onClick={() => incrementQuantity(item.product_id)}
                                                        className="bg-gray-500 text-white w-8 h-8 rounded-lg hover:bg-gray-600"
                                                    >
                                                        +
                                                    </button>
                                                </div>
                                            </td>
                                            <td className="py-3">
                                                <button
                                                    onClick={() => removeFromCart(item.product_id)}
                                                    className="bg-red-500 text-white px-4 py-1 rounded-lg hover:bg-red-600"
                                                >
                                                    Remove
                                                </button>
                                            </td>
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                            <div className="flex justify-between items-center mt-6 border-t pt-4">
                                <span className="text-xl font-bold text-[#4b3025]">Subtotal:</span>
                                <span className="text-xl font-bold text-[#6b4226]">₱{calculateTotal().toFixed(2)}</span>
                            </div>
                            <button
                                onClick={handleCheckout}
                                className="w-full bg-green-600 text-white py-3 rounded-lg mt-6 hover:bg-green-700 transition-colors font-semibold"
                            >
                                Proceed to Checkout
                            </button>
                        </>
                    )}
                </div>
            </div>
            {showModal && transactionDetails && (
                <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50">
                    <div className="bg-white rounded-lg p-8 max-w-md w-full mx-4">
                        <div className="flex justify-between items-center mb-6">
                            <h2 className="text-2xl font-bold text-[#4b3025]">Transaction Summary</h2>
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

                        <button
                            onClick={() => setShowModal(false)}
                            className="w-full bg-red-500 text-white py-2 rounded-lg mt-6 hover:bg-red-600 transition-colors"
                        >
                            Close
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}
