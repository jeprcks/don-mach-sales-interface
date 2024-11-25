"use client";

import { useState } from 'react';
import { useRouter } from 'next/navigation';

interface Product {
    id: number;
    name: string;
    description: string;
    price: number;
    stock: number;
    image: string;
}

export default function CoffeeList() {
    const router = useRouter();

    const [products, setProducts] = useState<Product[]>([
        {
            id: 1,
            name: 'Brown Spanish',
            description: 'Brown Spanish Latte is basically espresso-based coffee with milk.',
            price: 39,
            stock: 100,
            image: '/images/Productlist/donmacnew.jpg',
        },
        {
            id: 2,
            name: 'Oreo Coffee',
            description: 'Oreo Iced Coffee Recipe is perfect for a hot summer day.',
            price: 39,
            stock: 50,
            image: '/images/Productlist/donmacnew.jpg',
        },
        {
            id: 3,
            name: 'Black Forest',
            description: 'A decadent symphony of flavors featuring luxurious Belgian dark chocolate and succulent Taiwanese strawberries, delicately infused with velvety milk',
            price: 39,
            stock: 50,
            image: '/images/Productlist/blackforest.jpg',
        },
        {
            id: 4,
            name: 'Don darko',
            description: 'Crafted from the finest Belgian dark chocolate, harmoniously blended with creamy milk',
            price: 39,
            stock: 50,
            image: '/images/Productlist/dondarko.jpg',
        },
        {
            id: 5,
            name: 'Donya Berry',
            description: 'A tantalizing fusion of succulent Taiwanese strawberries mingled with creamy milk',
            price: 39,
            stock: 50,
            image: '/images/Productlist/donyaberry.jpg',
        },
        {
            id: 6,
            name: 'Iced Caramel',
            description: 'An exquisite blend of freshly pulled espresso, smooth milk, and luscious caramel syrup, served over a bed of ice',
            price: 39,
            stock: 50,
            image: '/images/Productlist/icedcaramel.jpg',
        }
    ]);

    const handleBackClick = () => {
        router.push('/homepage');
    };

    return (
        <div style={styles.container}>
            <button onClick={handleBackClick} style={styles.backButton}>
                ← Back
            </button>
            <h1 style={{ ...styles.header, textAlign: 'center' as const }}>Coffee Menu</h1>
            <div style={{ ...styles.productGrid, display: 'grid' as const, gridTemplateColumns: 'repeat(2, 1fr)' as const, gap: '20px' as const }}>
                {products.map((product) => (
                    <div key={product.id} style={{ ...styles.productCard, display: 'flex' as const, flexDirection: 'column' as const, alignItems: 'center' as const }}>
                        <div style={styles.imageWrapper}>
                            <img
                                src={product.image}
                                alt={product.name}
                                style={{ ...styles.productImage, objectFit: 'cover' as const }}
                            />
                        </div>
                        <div style={{ ...styles.cardContent, textAlign: 'center' as const }}>
                            <h2 style={styles.productName}>{product.name}</h2>
                            <p style={styles.productDescription}>{product.description}</p>
                            <p style={styles.productPrice}>Price: ₱{product.price}</p>
                            <p style={styles.productStock}>Stock: {product.stock}</p>
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
        gridTemplateColumns: 'repeat(2, 1fr)', // Two cards per row
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
        maxWidth: '60%', // Ensures the image doesn't exceed card width
        height: 'auto', // Maintains aspect ratio
        objectFit: 'cover', // Crops image nicely
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
};
