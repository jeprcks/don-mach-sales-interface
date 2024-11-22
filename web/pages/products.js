import { useRouter } from 'next/router';
import React, { useState } from 'react';
import ProductList from '../components/productlist'; // Import the ProductList component

export default function CoffeeList() {
  const router = useRouter();

  const [products, setProducts] = useState([
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
  ]);

  const [editingProductId, setEditingProductId] = useState(null);
  const [editingProduct, setEditingProduct] = useState({});
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [newProduct, setNewProduct] = useState({
    name: '',
    description: '',
    price: 0,
    stock: 0,
    image: '',
  });

  // Handle editing product
  const handleEditClick = (product) => {
    setEditingProductId(product.id);
    setEditingProduct({ ...product }); // Copy the product into editing state
  };

  const handleInputChange = (e) => {
    const { name, value } = e.target;

    setEditingProduct({
      ...editingProduct,
      [name]: name === 'price' || name === 'stock' ? parseFloat(value) || 0 : value,
    });
  };

  const handleSaveClick = () => {
    setProducts((prevProducts) =>
      prevProducts.map((product) =>
        product.id === editingProduct.id ? { ...editingProduct } : product
      )
    );
    setEditingProductId(null); // Clear editing state
  };

  const handleDeleteClick = (productId) => {
    setProducts((prevProducts) => prevProducts.filter((product) => product.id !== productId));
  };

  const handleImageChange = (e, productId) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setProducts((prevProducts) =>
          prevProducts.map((product) =>
            product.id === productId ? { ...product, image: reader.result } : product
          )
        );
      };
      reader.readAsDataURL(file); // Convert to base64
    }
  };

  const handleBackClick = () => {
    router.push('/homepage');
  };

  // Add Product Functions
  const handleNewProductChange = (e) => {
    const { name, value } = e.target;

    setNewProduct({
      ...newProduct,
      [name]: name === 'price' || name === 'stock' ? parseFloat(value) || 0 : value,
    });
  };

  const handleNewProductImageChange = (e) => {
    const file = e.target.files[0];
    if (file) {
      const reader = new FileReader();
      reader.onload = () => {
        setNewProduct((prevProduct) => ({
          ...prevProduct,
          image: reader.result, // Save the base64 string of the image
        }));
      };
      reader.readAsDataURL(file);
    }
  };

  const validateNewProduct = () => {
    const { name, description, price, stock, image } = newProduct;
    return name && description && price > 0 && stock >= 0 && image;
  };

  const handleAddNewProduct = () => {
    if (!validateNewProduct()) {
      alert('Please fill in all fields before saving.');
      return;
    }

    setProducts([
      ...products,
      {
        ...newProduct,
        id: Math.max(0, ...products.map((product) => product.id)) + 1, // Generate unique ID
      },
    ]);
    setNewProduct({
      name: '',
      description: '',
      price: 0,
      stock: 0,
      image: '',
    });
    setIsModalOpen(false); // Close the modal
  };

  return (
    <div style={styles.container}>
      <button onClick={handleBackClick} style={styles.backButton}>
        ← Back
      </button>
      <h1 style={styles.header}>Coffee Menu</h1>
      <ProductList
        products={products}
        editingProductId={editingProductId}
        editingProduct={editingProduct}
        handleEditClick={handleEditClick}
        handleDeleteClick={handleDeleteClick}
        handleInputChange={handleInputChange}
        handleSaveClick={handleSaveClick}
        handleImageChange={handleImageChange}
      />
      <button onClick={() => setIsModalOpen(true)} style={styles.addButton}>
        Add Product
      </button>

      {/* Add Product Modal */}
      {isModalOpen && (
        <div
          style={styles.modalOverlay}
          onClick={(e) => {
            if (e.target === e.currentTarget) setIsModalOpen(false);
          }}
        >
          <div style={styles.modal}>
            <h2 style={styles.modalTitle}>Add New Product</h2>
            <input
              type="text"
              name="name"
              value={newProduct.name}
              onChange={handleNewProductChange}
              placeholder="Product Name"
              style={styles.input}
            />
            <textarea
              name="description"
              value={newProduct.description}
              onChange={handleNewProductChange}
              placeholder="Product Description"
              style={styles.textarea}
            />
            <input
              type="number"
              name="price"
              value={newProduct.price}
              onChange={handleNewProductChange}
              placeholder="Product Price"
              style={styles.input}
            />
            <input
              type="number"
              name="stock"
              value={newProduct.stock}
              onChange={handleNewProductChange}
              placeholder="Product Stock"
              style={styles.input}
            />
            <label htmlFor="new-product-image" style={styles.fileInputLabel}>
              Upload Image
            </label>
            <input
              id="new-product-image"
              type="file"
              accept="image/*"
              onChange={handleNewProductImageChange}
              style={styles.fileInput}
            />
            {newProduct.image && (
              <img
                src={newProduct.image}
                alt="Preview"
                style={styles.imagePreview}
              />
            )}
            <button onClick={handleAddNewProduct} style={styles.saveButton}>
              Save
            </button>
            <button onClick={() => setIsModalOpen(false)} style={styles.cancelButton}>
              Cancel
            </button>
          </div>
        </div>
      )}
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
  addButton: {
    position: 'absolute', // Positioning to make it float
    top: '20px',          // Distance from the top
    right: '20px',        // Distance from the right
    padding: '15px',
    backgroundColor: '#28a745',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1.2rem',
    fontWeight: 'bold',
    zIndex: 1000,         // Ensure it stays above other elements
  },
  
  modalOverlay: {
    position: 'fixed',
    top: 0,
    left: 0,
    width: '100%',
    height: '100%',
    backgroundColor: 'rgba(0, 0, 0, 0.5)',
    display: 'flex',
    justifyContent: 'center',
    alignItems: 'center',
    zIndex: 1000,
  },
  modal: {
    backgroundColor: '#fff',
    padding: '70px',
    borderRadius: '12px',
    width: '400px',
    boxShadow: '0px 4px 8px rgba(0, 0, 0, 0.2)',
    textAlign: 'center',
  },
  modalTitle: {
    fontSize: '1.5rem',
    color: '#4b3025',
    marginBottom: '20px',
  },
  input: {
    width: '100%',
    padding: '10px',
    marginBottom: '10px',
    borderRadius: '8px',
    border: '1px solid #ddd',
    fontSize: '1rem',
  },
  textarea: {
    width: '100%',
    padding: '10px',
    marginBottom: '10px',
    borderRadius: '8px',
    border: '1px solid #ddd',
    fontSize: '1rem',
  },
  fileInput: {
    display: 'none', // Hide the actual file input
  },
  fileInputLabel: {
    padding: '10px',
    backgroundColor: '#9e602b',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
    display: 'inline-block',
    marginBottom: '10px',
  },
  imagePreview: {
    marginTop: '10px',
    marginBottom: '10px',
    height: '100px',
    maxWidth: '100%',
    borderRadius: '8px',
  },
  saveButton: {
    padding: '10px',
    backgroundColor: '#28a745',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
    marginRight: '10px',
  },
  cancelButton: {
    padding: '10px',
    backgroundColor: '#d9534f',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
  },
};
