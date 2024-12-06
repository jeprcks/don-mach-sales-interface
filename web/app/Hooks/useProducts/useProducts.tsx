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
            setLoading(true);
            const response = await fetch('http://localhost:8000/api/products');

            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }

            const data = await response.json();
            if (!data.products) {
                throw new Error('Products data is missing from response');
            }

            setProducts(data.products);
        } catch (err) {
            setError(err instanceof Error ? err.message : 'An error occurred');
            console.error('Error fetching products:', err);
        } finally {
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
