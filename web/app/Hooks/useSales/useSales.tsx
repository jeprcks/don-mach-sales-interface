import { useState, useEffect } from 'react';

interface Product {
    product_id: string;
    product_name: string;
    product_price: number;
    product_stock: number;
    product_image: string;
    quantity: number;
}

export const useSales = () => {
    const [products, setProducts] = useState<Product[]>([]);
    const [cart, setCart] = useState<Product[]>([]);
    const [loading, setLoading] = useState(true);
    const [error, setError] = useState<string | null>(null);

    const fetchProducts = async () => {
        try {
            const response = await fetch('http://localhost:8000/api/products');
            if (!response.ok) {
                throw new Error('Failed to fetch products');
            }
            const data = await response.json();
            const formattedProducts = data.products.map((product: Product) => ({
                ...product,
                quantity: 0
            }));
            setProducts(formattedProducts);
            setLoading(false);
        } catch (err) {
            setError(err instanceof Error ? err.message : 'An error occurred');
            setLoading(false);
        }
    };

    const addToCart = (product: Product) => {
        const existingItem = cart.find(item => item.product_id === product.product_id);

        // Check if there's enough stock
        const currentQuantity = existingItem ? existingItem.quantity : 0;
        if (currentQuantity + 1 > product.product_stock) {
            alert('Not enough stock available!');
            return;
        }

        if (existingItem) {
            setCart(cart.map(item =>
                item.product_id === product.product_id
                    ? { ...item, quantity: item.quantity + 1 }
                    : item
            ));
        } else {
            setCart([...cart, { ...product, quantity: 1 }]);
        }
    };

    useEffect(() => {
        fetchProducts();
    }, []);

    return {
        products,
        cart,
        setCart,
        loading,
        error,
        addToCart,
    };
};
