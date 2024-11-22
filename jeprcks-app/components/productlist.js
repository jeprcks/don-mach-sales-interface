import React from 'react';
import Image from 'next/image'; // Import Next.js Image component

export default function ProductList({
  products,
  editingProductId,
  editingProduct,
  handleEditClick,
  handleDeleteClick,
  handleInputChange,
  handleSaveClick,
  handleImageChange, // Add this new prop for handling image changes
}) {
  return (
    <div style={styles.productList}>
      {products.map((product) => (
        <div key={product.id} style={styles.productCard}>
          {/* Product Image */}
          {product.image.startsWith('data:image/') ? (
            <img
              src={product.image}
              alt={product.name}
              style={{ borderRadius: '8px', width: '330px', height: '300px' }}
            />
          ) : (
            <Image
              src={product.image}
              alt={product.name}
              width={330}
              height={300}
              style={{ borderRadius: '8px' }}
            />
          )}
          {editingProductId === product.id ? (
            <>
              <input
                type="text"
                name="name"
                value={editingProduct.name}
                onChange={handleInputChange}
                style={styles.input}
              />
              <textarea
                name="description"
                value={editingProduct.description}
                onChange={handleInputChange}
                style={styles.textarea}
              />
              <input
                type="number"
                name="price"
                value={editingProduct.price}
                onChange={handleInputChange}
                style={styles.input}
              />
              <input
                type="number"
                name="stock"
                value={editingProduct.stock}
                onChange={handleInputChange}
                style={styles.input}
              />
              {/* File Input for Image */}
              <label
                htmlFor={`file-input-${product.id}`}
                style={styles.fileInputLabel}
              >
                Upload Image
              </label>
              <input
                id={`file-input-${product.id}`}
                type="file"
                accept="image/*"
                onChange={(e) => handleImageChange(e, product.id)}
                style={styles.fileInput}
              />
              <button onClick={handleSaveClick} style={styles.button}>
                Save
              </button>
            </>
          ) : (
            <>
              <h2 style={styles.productName}>{product.name}</h2>
              <p style={styles.productDescription}>{product.description}</p>
              <p style={styles.productPrice}>₱{product.price.toFixed(2)}</p>
              <p style={styles.productStock}>Stock: {product.stock}</p>
              <button
                onClick={() => handleEditClick(product)}
                style={styles.button}
              >
                Edit
              </button>
              <button
                onClick={() => handleDeleteClick(product.id)}
                style={styles.deleteButton}
              >
                Delete
              </button>
            </>
          )}
        </div>
      ))}
    </div>
  );
}

const styles = {
  productList: {
    display: 'grid',
    gridTemplateColumns: 'repeat(3, 1fr)', // 3 items per row
    gap: '20px', // Space between items
  },
  productCard: {
    backgroundColor: '#fff8e7',
    borderRadius: '12px',
    padding: '20px',
    textAlign: 'center',
    boxShadow: '0px 4px 8px rgba(0, 0, 0, 0.1)',
    transition: 'transform 0.2s ease-in-out, box-shadow 0.2s ease-in-out',
    cursor: 'pointer',
  },
  productName: {
    fontSize: '1.5rem',
    marginBottom: '10px',
    color: '#4b3025',
    fontWeight: 'bold',
  },
  productDescription: {
    fontSize: '1rem',
    color: '#6b4226',
    marginBottom: '10px',
  },
  productPrice: {
    fontSize: '1.5rem',
    fontWeight: 'bold',
    color: '#9e602b',
    marginBottom: '5px', // Adjusted for space above stock
  },
  productStock: {
    fontSize: '1.2rem',
    color: '#6b4226',
    marginBottom: '15px',
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
    display: 'none', // Hide the file input
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
  button: {
    padding: '10px',
    backgroundColor: '#9e602b',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
    marginBottom: '10px',
    transition: 'background-color 0.2s ease-in-out',
  },
  deleteButton: {
    padding: '10px',
    backgroundColor: '#d9534f',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
    marginTop: '10px',
    transition: 'background-color 0.2s ease-in-out',
  },
};
