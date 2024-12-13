'use client';
import React, { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useSales } from '../Hooks/useSales/useSales';
import Image from 'next/image';
import { Receipt } from '../../components/receipt';
export default function Sales(): JSX.Element {
    const { products, cart, loading, error, addToCart, setCart, handleCheckout, showReceipt, setShowReceipt, currentTransaction } = useSales();

    console.log('Products:', products);

    const calculateSubtotal = () => {
        return cart.reduce((total, item) => total + (item.product_price * item.quantity), 0);
    };

    const updateQuantity = (productId: string, newQuantity: number) => {
        const product = products.find(p => p.product_id === productId);
        if (!product) return;

        if (newQuantity > product.product_stock) {
            alert('Not enough stock available!');
            return;
        }

        if (newQuantity <= 0) {
            setCart(cart.filter(item => item.product_id !== productId));
            return;
        }

        setCart(cart.map(item =>
            item.product_id === productId
                ? { ...item, quantity: newQuantity }
                : item
        ));
    };

    const removeFromCart = (productId: string) => {
        setCart(cart.filter(item => item.product_id !== productId));
    };

    if (loading) {
        return <div className="flex justify-center items-center h-screen">Loading products...</div>;
    }

    if (error) {
        return <div className="flex justify-center items-center h-screen flex-col gap-4">
            <div className="text-red-500">Error: {error}</div>
        </div>;
    }

    return (
        <div className="min-h-screen bg-[#fff8e7]">
            <div className="container mx-auto px-4 py-8">
                <div className="flex justify-between items-center mb-8">
                    <button
                        onClick={() => window.location.href = '/homepage'}
                        className="bg-[#6b4226] text-white px-4 py-2 rounded-lg hover:bg-[#3a2117] transition-colors"
                    >
                        ← Back
                    </button>
                    <h1 className="text-3xl font-bold text-center text-[#4b3025]">Sales Interface</h1>
                    <div className="w-[76px]"></div> {/* Spacer for alignment */}
                </div>

                {/* Debug info */}
                <div className="grid grid-cols-1 sm:grid-cols-2 md:grid-cols-3 gap-6">
                    {products && products.map((product) => (
                        <div key={product.product_id}
                            className="product-card bg-white rounded-lg shadow-lg overflow-hidden hover:transform hover:-translate-y-1 transition-transform duration-200"
                        >
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
                                <h2 className="text-xl font-bold text-[#4b3025] mb-2">{product.product_name}</h2>
                                <p className="text-[#6b4226] text-lg font-bold mb-3">₱{product.product_price?.toFixed(2)}</p>
                                <button
                                    onClick={() => addToCart(product)}
                                    className="w-full bg-[#6b4226] text-white py-2 rounded hover:bg-[#4b3025] transition-colors"
                                >
                                    Add to Cart
                                </button>
                            </div>
                        </div>
                    ))}
                </div>

                <div className="bg-white rounded-lg shadow-lg p-6 mt-8">
                    <h2 className="text-2xl font-bold text-[#4b3025] mb-4">Your Cart</h2>
                    <div className="overflow-x-auto">
                        <table className="w-full mb-4">
                            <thead>
                                <tr className="border-b">
                                    <th className="text-left p-2">Product</th>
                                    <th className="text-left p-2">Price</th>
                                    <th className="text-left p-2">Quantity</th>
                                    <th className="text-left p-2">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                {cart.map((item) => (
                                    <tr key={item.product_id} className="border-b">
                                        <td className="p-2">{item.product_name}</td>
                                        <td className="p-2">₱{item.product_price.toFixed(2)}</td>
                                        <td className="p-2">
                                            <div className="flex items-center gap-2">
                                                <button
                                                    onClick={() => updateQuantity(item.product_id, item.quantity - 1)}
                                                    className="px-2 py-1 bg-gray-200 rounded"
                                                >
                                                    -
                                                </button>
                                                <input
                                                    type="number"
                                                    value={item.quantity}
                                                    onChange={(e) => updateQuantity(item.product_id, parseInt(e.target.value))}
                                                    className="w-16 text-center border rounded p-1"
                                                    min="1"
                                                    max={item.product_stock}
                                                />
                                                <button
                                                    onClick={() => updateQuantity(item.product_id, item.quantity + 1)}
                                                    className="px-2 py-1 bg-gray-200 rounded"
                                                >
                                                    +
                                                </button>
                                            </div>
                                        </td>
                                        <td className="p-2">
                                            <button
                                                onClick={() => removeFromCart(item.product_id)}
                                                className="text-red-500 hover:text-red-700"
                                            >
                                                Remove
                                            </button>
                                        </td>
                                    </tr>
                                ))}
                            </tbody>
                        </table>
                    </div>
                    <div className="flex justify-between items-center mt-4">
                        <div className="text-lg font-bold text-[#4b3025]">
                            Subtotal: ₱{calculateSubtotal().toFixed(2)}
                        </div>
                        <button
                            onClick={handleCheckout}
                            className="bg-[#10b981] text-white px-6 py-2 rounded hover:bg-[#059669] transition-colors"
                            disabled={cart.length === 0}
                        >
                            Proceed to Checkout
                        </button>
                    </div>
                </div>
            </div>
            {showReceipt && currentTransaction && (
                <Receipt
                    transaction={currentTransaction}
                    onClose={() => setShowReceipt(false)}
                    onPrint={() => window.print()}
                />
            )}
        </div>
    );
}
