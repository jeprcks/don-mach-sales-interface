import { useState } from "react";
import { useRouter } from "next/router";

export default function Dashboard() {
  const [activeTab, setActiveTab] = useState("Stock"); // State for active tab
  const [stockData, setStockData] = useState([
    { id: 1, name: "Espresso", stock: 1000 },
    { id: 2, name: "Latte", stock: 1000 },
    { id: 3, name: "Cappuccino", stock: 1000 },
    { id: 4, name: "Macchiato", stock: 1000 },
    { id: 5, name: "Americano", stock: 1000 },
  ]);

  const router = useRouter(); // For back navigation

  const [newCoffee, setNewCoffee] = useState({ name: "", stock: "" });
  const [isEditing, setIsEditing] = useState(null);

  // Sales and performance data for tabs
  const salesData = [
    { label: "Daily", value: 5000 },
    { label: "Weekly", value: 35000 },
    { label: "Monthly", value: 150000 },
  ];

  const performanceData = [
    { product: "Espresso", revenue: 12000 },
    { product: "Latte", revenue: 15000 },
    { product: "Cappuccino", revenue: 18000 },
    { product: "Macchiato", revenue: 8000 },
  ];

  // Tab rendering logic
  const renderContent = () => {
    if (activeTab === "Stock") {
      return (
        <div style={styles.stockContainer}>
          <h2 style={styles.sectionHeader}>Manage Coffee Stock</h2>
          <div style={styles.form}>
            <input
              type="text"
              placeholder="Coffee Name"
              value={newCoffee.name}
              onChange={(e) => setNewCoffee({ ...newCoffee, name: e.target.value })}
              style={styles.input}
            />
            <input
              type="number"
              placeholder="Stock"
              value={newCoffee.stock}
              onChange={(e) => setNewCoffee({ ...newCoffee, stock: e.target.value })}
              style={styles.input}
            />
            <button onClick={handleAddStock} style={styles.addButton}>
              Add
            </button>
          </div>
          <ul style={styles.stockList}>
            {stockData.map((coffee) => (
              <li key={coffee.id} style={styles.stockItem}>
                {isEditing === coffee.id ? (
                  <>
                    <input
                      type="text"
                      value={coffee.name}
                      onChange={(e) => handleEditChange(coffee.id, "name", e.target.value)}
                      style={styles.inputInline}
                    />
                    <input
                      type="number"
                      value={coffee.stock}
                      onChange={(e) => handleEditChange(coffee.id, "stock", e.target.value)}
                      style={styles.inputInline}
                    />
                    <button onClick={() => handleSaveEdit(coffee.id)} style={styles.saveButton}>
                      Save
                    </button>
                  </>
                ) : (
                  <>
                    <span style={styles.stockName}>{coffee.name}</span>
                    <span style={styles.stockText}>Stock: {coffee.stock}</span>
                    <button onClick={() => setIsEditing(coffee.id)} style={styles.editButton}>
                      ✏️
                    </button>
                  </>
                )}
              </li>
            ))}
          </ul>
        </div>
      );
    } else if (activeTab === "Sales") {
      return (
        <div>
          <h2 style={styles.sectionHeader}>Sales Trends</h2>
          <ul style={styles.list}>
            {salesData.map((item, index) => (
              <li key={index} style={styles.listItem}>
                <span>{item.label}</span>
                <span style={styles.value}>{`₱${item.value.toFixed(2)}`}</span>
              </li>
            ))}
          </ul>
        </div>
      );
    } else if (activeTab === "Performance") {
      return (
        <div>
          <h2 style={styles.sectionHeader}>Product Performance</h2>
          <ul style={styles.list}>
            {performanceData.map((item, index) => (
              <li key={index} style={styles.listItem}>
                <span>{item.product}</span>
                <span style={styles.value}>{`₱${item.revenue.toFixed(2)}`}</span>
              </li>
            ))}
          </ul>
        </div>
      );
    }
  };

  const handleAddStock = () => {
    if (newCoffee.name && newCoffee.stock) {
      setStockData([
        ...stockData,
        { id: Date.now(), name: newCoffee.name, stock: parseInt(newCoffee.stock, 10) },
      ]);
      setNewCoffee({ name: "", stock: "" });
    }
  };

  const handleEditChange = (id, field, value) => {
    setStockData((prev) =>
      prev.map((item) => (item.id === id ? { ...item, [field]: value } : item))
    );
  };

  const handleSaveEdit = (id) => {
    setIsEditing(null);
  };

  return (
    <div style={styles.container}>
      <div style={styles.content}>
        <button onClick={() => router.push("/homepage")} style={styles.backButton}>
          ← Back to Homepage
        </button>
        <h1 style={styles.header}>Dashboard</h1>
        <div style={styles.tabs}>
          <button
            onClick={() => setActiveTab("Stock")}
            style={activeTab === "Stock" ? styles.activeTab : styles.tab}
          >
            Stock
          </button>
          <button
            onClick={() => setActiveTab("Sales")}
            style={activeTab === "Sales" ? styles.activeTab : styles.tab}
          >
            Sales
          </button>
          <button
            onClick={() => setActiveTab("Performance")}
            style={activeTab === "Performance" ? styles.activeTab : styles.tab}
          >
            Performance
          </button>
        </div>
        {renderContent()}
      </div>
    </div>
  );
}

const styles = {
  container: {
    fontFamily: "'Segoe UI', sans-serif",
    backgroundColor: "#fdf3e1",
    padding: "20px",
    minHeight: "100vh",
  },
  content: {
    maxWidth: "2000px",
    margin: "0 auto",
    backgroundColor: "#ffffff",
    borderRadius: "8px",
    boxShadow: "0px 4px 8px rgba(0, 0, 0, 0.1)",
    padding: "20px",
  },
  backButton: {
    marginBottom: "1rem",
    padding: "10px 15px",
    backgroundColor: "#d7ccc8",
    color: "#6f4e37",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
    fontWeight: "bold",
  },
  header: {
    textAlign: "center",
    color: "#6f4e37",
    fontSize: "2rem",
    marginBottom: "1.5rem",
  },
  tabs: {
    display: "flex",
    justifyContent: "space-evenly",
    marginBottom: "20px",
  },
  tab: {
    padding: "10px 20px",
    cursor: "pointer",
    backgroundColor: "#f5f5f5",
    borderRadius: "5px",
    fontWeight: "bold",
    border: "none",
    transition: "all 0.3s ease",
    color: "#555",
  },
  activeTab: {
    backgroundColor: "#d7ccc8",
    color: "#000",
    fontWeight: "bold",
  },
  stockContainer: {
    padding: "1rem",
    backgroundColor: "#fdfdfd",
    borderRadius: "8px",
    boxShadow: "0 2px 5px rgba(0, 0, 0, 0.1)",
  },
  form: {
    display: "flex",
    marginBottom: "1rem",
    gap: "10px",
  },
  input: {
    flex: 1,
    padding: "10px",
    border: "1px solid #ddd",
    borderRadius: "5px",
  },
  addButton: {
    backgroundColor: "#4caf50",
    color: "#fff",
    padding: "10px 20px",
    border: "none",
    borderRadius: "5px",
    cursor: "pointer",
  },
  stockList: {
    listStyle: "none",
    padding: "0",
  },
  stockItem: {
    display: "flex",
    justifyContent: "space-between",
    alignItems: "center",
    padding: "10px 0",
    borderBottom: "1px solid #ddd",
  },
  stockName: {
    flex: 1,
    fontWeight: "bold",
    color: "#333",
  },
  stockText: {
    marginLeft: "10px",
    color: "#777",
  },
  editButton: {
    backgroundColor: "#ffc107",
    border: "none",
    padding: "5px 10px",
    borderRadius: "5px",
    cursor: "pointer",
  },
  saveButton: {
    backgroundColor: "#4caf50",
    border: "none",
    padding: "5px 10px",
    borderRadius: "5px",
    cursor: "pointer",
  },
};
