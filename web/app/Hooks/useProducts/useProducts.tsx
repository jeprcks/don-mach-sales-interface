import { useState, useEffect } from 'react';

interface Product {
    product_id: string;
    product_name: string;
    description: string;
    product_price: number;
    product_stock: number;
    product_image: string;
}

export const useProducts = () => {
    const [products, setProducts] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchProducts = async () => {
        try {
            const response = await fetch('http://localhost:8000/api/products');
            if (!response.ok) {
                throw new Error('Failed to fetch products');
            }
            const data = await response.json();
            setProducts(data.products);
            setLoading(false);
        } catch (err) {
            setError(err instanceof Error ? err.message : 'An error occurred');
            setLoading(false);
        }
    };

    const refreshProducts = async () => {
        setLoading(true);
        await fetchProducts();
    };

    useEffect(() => {
        fetchProducts();
    }, []);

    return { products, loading, error, refreshProducts };
};
