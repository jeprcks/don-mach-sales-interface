'use client';
import React from 'react';
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

export default function Transaction(): JSX.Element {
    const { transactions } = useTransactions();
    const router = useRouter();

    return (
        <div style={styles.container}>
            {/* Back Button */}
            <header style={styles.header}>
                <button
                    style={styles.backButton}
                    onClick={() => router.push('/homepage')}
                >
                    ← Back
                </button>
                <h1 style={styles.pageTitle}>Transaction History</h1>
            </header>

            {transactions.length === 0 ? (
                <p style={styles.noTransactions}>No transactions yet.</p>
            ) : (
                transactions.map((transaction: Transaction) => (
                    <div key={transaction.orderNumber} style={styles.card}>
                        <h2 style={styles.orderNumber}>
                            Order Number: <span style={styles.highlight}>{transaction.orderNumber}</span>
                        </h2>
                        <p style={styles.date}>
                            <strong>Date:</strong> {transaction.date}
                        </p>
                        <h3 style={styles.orderListTitle}>Order List:</h3>
                        <div style={styles.orderList}>
                            {transaction.orderList.map((item: Product, index: number) => (
                                <div key={index} style={styles.orderRow}>
                                    <span style={styles.itemName}>{item.name}</span>
                                    <span style={styles.itemQuantity}>{item.quantity} ×</span>
                                    <span style={styles.itemPrice}>₱{item.price.toFixed(2)}</span>
                                </div>
                            ))}
                        </div>
                        <h3 style={styles.totalPrice}>
                            Total Price: <span style={styles.highlight}>₱{transaction.totalPrice.toFixed(2)}</span>
                        </h3>
                    </div>
                ))
            )}
        </div>
    );
}

const styles: { [key: string]: React.CSSProperties } = {
    container: {
        fontFamily: "'Segoe UI', Tahoma, Geneva, Verdana, sans-serif",
        backgroundColor: '#f7f0e3',
        padding: '20px',
        minHeight: '100vh',
    },
    header: {
        display: 'flex',
        alignItems: 'center',
        marginBottom: '20px',
    },
    backButton: {
        padding: '10px',
        backgroundColor: '#4b3025',
        color: 'white',
        border: 'none',
        borderRadius: '5px',
        cursor: 'pointer',
        marginRight: '15px',
        fontWeight: 'bold',
        fontSize: '1rem',
    },
    pageTitle: {
        fontSize: '2rem',
        color: '#6b4226', // Coffee-themed color
        fontWeight: 'bold',
    },
    noTransactions: {
        textAlign: 'center' as const,
        fontSize: '1.5rem',
        color: '#6b4226',
        marginTop: '50px',
    },
    card: {
        backgroundColor: '#fff8e7', // Coffee theme
        padding: '20px',
        marginBottom: '20px',
        borderRadius: '12px',
        boxShadow: '0px 4px 8px rgba(0, 0, 0, 0.1)',
    },
    orderNumber: {
        fontSize: '1.5rem',
        color: '#4b3025',
        marginBottom: '10px',
    },
    highlight: {
        color: '#9e602b', // Highlight color
        fontWeight: 'bold',
    },
    date: {
        fontSize: '1rem',
        color: '#6b4226',
        marginBottom: '15px',
    },
    orderListTitle: {
        fontSize: '1.2rem',
        fontWeight: 'bold',
        color: '#4b3025',
        marginBottom: '10px',
    },
    orderList: {
        display: 'grid',
        gridTemplateColumns: '2fr 1fr 1fr', // Align items in columns
        rowGap: '10px',
        columnGap: '10px',
        marginBottom: '15px',
    },
    orderRow: {
        display: 'contents',
    },
    itemName: {
        fontWeight: 'bold',
        color: '#4b3025',
    },
    itemQuantity: {
        textAlign: 'right' as const,
        color: '#6b4226',
    },
    itemPrice: {
        textAlign: 'right' as const,
        color: '#9e602b',
        fontWeight: 'bold',
    },
    totalPrice: {
        fontSize: '1.3rem',
        fontWeight: 'bold',
        color: '#4b3025',
        marginTop: '15px',
    },
};
