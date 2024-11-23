'use client';
import React, { useState } from 'react';
import { useTransactions } from '@/context/transactioncontext';
import { useRouter } from 'next/navigation';

interface Product {
    id: number;
    name: string;
    price: number;
    quantity: number;
}

interface Transaction {
    orderNumber: number;
    date: string;
    orderList: Product[];
    totalPrice: number;
}

export default function Sales(): JSX.Element {
    const router = useRouter();
    const [products, setProducts] = useState<Product[]>([
        { id: 1, name: 'Brown Spanish Latte', price: 39, quantity: 0 },
        { id: 2, name: 'Oreo Coffee', price: 39, quantity: 0 },
        { id: 3, name: 'Black Forest', price: 39, quantity: 0 },
        { id: 4, name: 'Don Darko', price: 39, quantity: 0 },
        { id: 5, name: 'Donya Berry', price: 39, quantity: 0 },
        { id: 6, name: 'Iced Caramel', price: 39, quantity: 0 },
        { id: 7, name: 'Macha Berry', price: 39, quantity: 0 },
        { id: 8, name: 'Macha', price: 39, quantity: 0 },
    ]);

    const { addTransaction, transactions = [] } = useTransactions();

    const [transaction, setTransaction] = useState<Transaction | null>(null);
    const [showModal, setShowModal] = useState<boolean>(false);
    const [orderNumber, setOrderNumber] = useState<number>(1);

    const incrementQuantity = (id: number): void => {
        setProducts((prev) =>
            prev.map((product) =>
                product.id === id
                    ? { ...product, quantity: product.quantity + 1 }
                    : product
            )
        );
    };

    const decrementQuantity = (id: number): void => {
        setProducts((prev) =>
            prev.map((product) =>
                product.id === id && product.quantity > 0
                    ? { ...product, quantity: product.quantity - 1 }
                    : product
            )
        );
    };

    const calculateTotal = (): number => {
        return products.reduce(
            (sum, product) => sum + product.price * product.quantity,
            0
        );
    };

    const handleCheckout = (): void => {
        const orderedProducts = products.filter((product) => product.quantity > 0);

        if (orderedProducts.length === 0) {
            alert('No products selected for checkout.');
            return;
        }

        const totalPrice = calculateTotal();
        const newTransaction: Transaction = {
            orderNumber: orderNumber,
            date: new Date().toLocaleString(),
            orderList: orderedProducts,
            totalPrice: totalPrice,
        };

        addTransaction(newTransaction);
        setTransaction(newTransaction);
        setShowModal(true);
        setOrderNumber(orderNumber + 1);
    };

    const closeModal = (): void => {
        setShowModal(false);
        setProducts((prev) =>
            prev.map((product) => ({ ...product, quantity: 0 }))
        );
    };

    return (
        <div style={styles.container}>
            <header style={styles.header}>
                <button
                    style={styles.backButton}
                    onClick={() => router.push('/homepage')}
                >
                    ←
                </button>
                <h1 style={styles.title}>Sales Interface</h1>
            </header>

            <div style={styles.productList}>
                {products.map((product) => (
                    <div key={product.id} style={styles.productCard}>
                        <div>
                            <h2 style={styles.productName}>{product.name}</h2>
                            <p style={styles.productPrice}>₱{product.price.toFixed(2)}</p>
                        </div>
                        <div style={styles.quantityControls}>
                            <button
                                style={styles.decrementButton}
                                onClick={() => decrementQuantity(product.id)}
                            >
                                −
                            </button>
                            <span style={styles.quantity}>{product.quantity}</span>
                            <button
                                style={styles.incrementButton}
                                onClick={() => incrementQuantity(product.id)}
                            >
                                +
                            </button>
                        </div>
                    </div>
                ))}
            </div>

            <footer style={styles.footer}>
                <div style={styles.totalContainer}>
                    <span style={styles.totalLabel}>Total:</span>
                    <span style={styles.totalPrice}>
                        ₱{calculateTotal().toFixed(2)}
                    </span>
                </div>
                <button style={styles.checkoutButton} onClick={handleCheckout}>
                    Checkout
                </button>
            </footer>

            {showModal && transaction && (
                <div style={styles.modalOverlay}>
                    <div style={styles.modal}>
                        <h2 style={styles.modalTitle}>TRANSACTION SUCCESSFUL</h2>
                        <p>Order Number: {transaction.orderNumber}</p>
                        <p>Date: {transaction.date}</p>
                        <h3>Order List:</h3>
                        <ul>
                            {transaction.orderList.map((item) => (
                                <li key={item.id}>
                                    {item.name} - {item.quantity} × ₱{item.price.toFixed(2)}
                                </li>
                            ))}
                        </ul>
                        <p>
                            Total: <strong>₱{transaction.totalPrice.toFixed(2)}</strong>
                        </p>
                        <button style={styles.modalButton} onClick={closeModal}>
                            OK
                        </button>
                    </div>
                </div>
            )}
        </div>
    );
}

const styles: { [key: string]: React.CSSProperties } = {
    container: {
        fontFamily: 'Arial, sans-serif',
        backgroundColor: '#f7f0e3',
        height: '100vh',
        display: 'flex',
        flexDirection: 'column',
    },
    header: {
        backgroundColor: '#6b4226',
        color: 'white',
        padding: '10px 20px',
        display: 'flex',
        alignItems: 'center',
    },
    backButton: {
        marginRight: '10px',
        padding: '10px',
        backgroundColor: '#4b3025',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
    },
    title: {
        fontSize: '1.5rem',
    },
    productList: {
        flex: 1,
        overflowY: 'auto',
        padding: '20px',
    },
    productCard: {
        backgroundColor: '#fff8e7',
        borderRadius: '8px',
        padding: '15px 20px',
        marginBottom: '15px',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
        boxShadow: '0px 4px 6px rgba(0, 0, 0, 0.1)',
    },
    productName: {
        fontSize: '1.2rem',
        fontWeight: 'bold',
        color: '#4b3025',
    },
    productPrice: {
        fontSize: '1rem',
        color: '#6b4226',
    },
    quantityControls: {
        display: 'flex',
        alignItems: 'center',
    },
    decrementButton: {
        padding: '10px',
        backgroundColor: '#d9534f',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
    },
    incrementButton: {
        padding: '10px',
        backgroundColor: '#5cb85c',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
    },
    quantity: {
        margin: '0 15px',
        fontSize: '1.2rem',
        fontWeight: 'bold',
    },
    footer: {
        backgroundColor: '#fff',
        padding: '20px',
        borderTop: '1px solid #ddd',
        display: 'flex',
        justifyContent: 'space-between',
        alignItems: 'center',
    },
    totalContainer: {
        display: 'flex',
        alignItems: 'center',
    },
    totalLabel: {
        fontSize: '1.2rem',
        marginRight: '10px',
        fontWeight: 'bold',
        color: '#4b3025',
    },
    totalPrice: {
        fontSize: '1.5rem',
        fontWeight: 'bold',
        color: '#6b4226',
    },
    checkoutButton: {
        padding: '15px 30px',
        backgroundColor: '#6b4226',
        color: 'white',
        fontSize: '1.2rem',
        fontWeight: 'bold',
        border: 'none',
        borderRadius: '8px',
        cursor: 'pointer',
    },
    modalOverlay: {
        position: 'fixed',
        top: 0,
        left: 0,
        width: '100vw',
        height: '100vh',
        backgroundColor: 'rgba(0, 0, 0, 0.5)',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
    },
    modal: {
        backgroundColor: '#fff',
        borderRadius: '12px',
        padding: '20px',
        maxWidth: '400px',
        textAlign: 'center',
    },
    modalTitle: {
        fontSize: '1.5rem',
        fontWeight: 'bold',
        marginBottom: '20px',
    },
    modalButton: {
        padding: '10px 20px',
        backgroundColor: '#6b4226',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
        marginTop: '20px',
    },
};
