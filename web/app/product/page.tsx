"use client";

import { useState } from 'react';
import { useRouter } from 'next/navigation';
import { useProducts } from '../Hooks/useProducts/useProducts';

interface Product {
    product_id: string;
    product_name: string;
    description: string;
    product_price: number;
    product_stock: number;
    product_image: string;
}

export default function CoffeeList() {
    const router = useRouter();
    const { products, loading, error } = useProducts();

    const handleBackClick = () => {
        router.push('/homepage');
    };

    if (loading) {
        return <div style={styles.loading}>Loading...</div>;
    }

    if (error) {
        return <div style={styles.error}>Error: {error}</div>;
    }

    return (
        <div style={styles.container}>
            <button onClick={handleBackClick} style={styles.backButton}>
                ← Back
            </button>
            <h1 style={{ ...styles.header, textAlign: 'center' as const }}>Coffee Menu</h1>
            <div style={{ ...styles.productGrid, display: 'grid' as const, gridTemplateColumns: 'repeat(3, 1fr)' as const, gap: '20px' as const }}>
                {products.map((product) => (
                    <div key={product.product_id} style={{ ...styles.productCard, display: 'flex' as const, flexDirection: 'column' as const, alignItems: 'center' as const }}>
                        <div style={styles.imageWrapper}>
                            <img
                                src={`http://localhost:8000/images/${product.product_image}`}
                                alt={product.product_name}
                                style={{ ...styles.productImage, objectFit: 'cover' as const }}
                            />
                        </div>
                        <div style={{ ...styles.cardContent, textAlign: 'center' as const }}>
                            <h2 style={styles.productName}>{product.product_name}</h2>
                            <p style={styles.productDescription}>{product.description}</p>
                            <p style={styles.productPrice}>Price: ₱{product.product_price}</p>
                            <p style={styles.productStock}>Stock: {product.product_stock}</p>
                        </div>
                    </div>
                ))}
            </div>
        </div>
    );
}

const styles = {
    container: {
        padding: '20px',
        backgroundColor: '#f7f0e3',
        fontFamily: `'Segoe UI', Tahoma, Geneva, Verdana, sans-serif`,
    },
    header: {
        textAlign: 'center',
        marginBottom: '2rem',
        fontSize: '2.5rem',
        color: '#6b4226',
        fontWeight: 'bold',
    },
    backButton: {
        padding: '10px',
        backgroundColor: '#4b3025',
        color: 'white',
        border: 'none',
        borderRadius: '8px',
        cursor: 'pointer',
        marginBottom: '20px',
        fontWeight: 'bold',
        fontSize: '1rem',
        transition: 'background-color 0.2s ease-in-out',
    },
    productGrid: {
        display: 'grid',
        gridTemplateColumns: 'repeat(3, 1fr)', // Changed from 2 to 3 cards per row
        gap: '20px',
    },
    productCard: {
        backgroundColor: '#fff',
        borderRadius: '12px',
        boxShadow: '0 4px 8px rgba(0, 0, 0, 0.1)',
        overflow: 'hidden',
        display: 'flex',
        flexDirection: 'column',
        alignItems: 'center',
    },
    imageWrapper: {
        width: '100%',
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        padding: '10px',
        backgroundColor: '#fff8e7', // Subtle background for contrast
        borderBottom: '1px solid #ddd', // Separator line
    },
    productImage: {
        maxWidth: '75%', // Increased from 60% to 75% for slightly larger images
        height: 'auto',
        objectFit: 'cover',
        borderRadius: '8px',
    },
    cardContent: {
        padding: '15px',
        textAlign: 'center',
    },
    productName: {
        fontSize: '1.5rem',
        fontWeight: 'bold',
        color: '#4b3025',
        marginBottom: '10px',
    },
    productDescription: {
        fontSize: '1rem',
        color: '#555',
        marginBottom: '10px',
    },
    productPrice: {
        fontSize: '1.2rem',
        fontWeight: 'bold',
        color: '#6b4226',
        marginBottom: '10px',
    },
    productStock: {
        fontSize: '1rem',
        color: '#4b4225',
    },
    loading: {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
        fontSize: '1.5rem',
        color: '#6b4226',
    },
    error: {
        display: 'flex',
        justifyContent: 'center',
        alignItems: 'center',
        height: '100vh',
        fontSize: '1.5rem',
        color: '#dc3545',
    },
};
