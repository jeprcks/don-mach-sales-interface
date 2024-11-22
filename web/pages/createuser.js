import React, { useState } from 'react';
import { useRouter } from 'next/router'; // For navigation

export default function CreateUser() {
  const router = useRouter();

  const [users, setUsers] = useState([]); // List of users
  const [formData, setFormData] = useState({
    username: '',
    email: '',
    password: '',
  });
  const [isEditing, setIsEditing] = useState(false);
  const [editingUserId, setEditingUserId] = useState(null);

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleCreateUser = () => {
    if (!formData.username || !formData.email || !formData.password) {
      alert('Please fill in all fields');
      return;
    }

    if (isEditing) {
      setUsers((prevUsers) =>
        prevUsers.map((user, index) =>
          index === editingUserId ? { ...formData } : user
        )
      );
      setIsEditing(false);
      setEditingUserId(null);
    } else {
      setUsers([...users, formData]);
    }

    setFormData({ username: '', email: '', password: '' });
  };

  const handleEditUser = (index) => {
    setEditingUserId(index);
    setFormData(users[index]);
    setIsEditing(true);
  };

  const handleDeleteUser = (index) => {
    setUsers((prevUsers) => prevUsers.filter((_, i) => i !== index));
  };

  const handleBackClick = () => {
    router.back(); // Navigate to the previous page
  };

  return (
    <div style={styles.page}>
      <div style={styles.header}>
        <button onClick={handleBackClick} style={styles.backButton}>
          ← Back
        </button>
        <h1 style={styles.title}>Create User</h1>
      </div>
      <div style={styles.flex}>
        <div style={styles.form}>
          <input
            type="text"
            name="username"
            placeholder="Username"
            value={formData.username}
            onChange={handleInputChange}
            style={styles.input}
          />
          <input
            type="email"
            name="email"
            placeholder="Email"
            value={formData.email}
            onChange={handleInputChange}
            style={styles.input}
          />
          <input
            type="password"
            name="password"
            placeholder="Password"
            value={formData.password}
            onChange={handleInputChange}
            style={styles.input}
          />
          <button onClick={handleCreateUser} style={styles.createButton}>
            {isEditing ? 'Update User' : 'Create User'}
          </button>
        </div>
        <div style={styles.tableContainer}>
          <table style={styles.table}>
            <thead>
              <tr>
                <th style={styles.th}>Username</th>
                <th style={styles.th}>Email</th>
                <th style={styles.th}>Password</th>
                <th style={styles.th}>Actions</th>
              </tr>
            </thead>
            <tbody>
              {users.map((user, index) => (
                <tr key={index} style={styles.tr}>
                  <td style={styles.td}>{user.username}</td>
                  <td style={styles.td}>{user.email}</td>
                  <td style={styles.td}>******</td>
                  <td style={styles.td}>
                    <button
                      onClick={() => handleEditUser(index)}
                      style={styles.editButton}
                    >
                      ✏️
                    </button>
                    <button
                      onClick={() => handleDeleteUser(index)}
                      style={styles.deleteButton}
                    >
                      🗑️
                    </button>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
}

const styles = {
  page: {
    minHeight: '100vh',
    display: 'flex',
    flexDirection: 'column',
    padding: '20px',
    backgroundColor: '#f9f9f9',
    boxSizing: 'border-box',
  },
  header: {
    marginBottom: '20px',
    display: 'flex',
    alignItems: 'center',
  },
  backButton: {
    padding: '10px',
    backgroundColor: '#4b3025',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontWeight: 'bold',
    fontSize: '14px',
    marginRight: '10px',
    transition: 'background-color 0.2s ease-in-out',
  },
  title: {
    fontSize: '24px',
    color: '#4b3025',
    fontWeight: 'bold',
  },
  flex: {
    display: 'flex',
    flexDirection: 'column',
    gap: '20px',
    flexGrow: 1,
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
    gap: '10px',
  },
  input: {
    padding: '10px',
    borderRadius: '6px',
    border: '1px solid #ccc',
    fontSize: '14px',
    outline: 'none',
  },
  createButton: {
    padding: '10px',
    backgroundColor: '#4CAF50',
    color: 'white',
    border: 'none',
    borderRadius: '6px',
    fontSize: '16px',
    cursor: 'pointer',
    transition: 'background-color 0.2s',
  },
  tableContainer: {
    flexGrow: 1,
    overflowX: 'auto', // For horizontal scrolling if necessary
  },
  table: {
    width: '100%',
    borderCollapse: 'collapse',
  },
  th: {
    textAlign: 'left',
    padding: '10px',
    backgroundColor: '#f0eae4',
    color: '#4b3025',
    fontWeight: 'bold',
  },
  tr: {
    borderBottom: '1px solid #ccc',
  },
  td: {
    padding: '10px',
  },
  editButton: {
    backgroundColor: '#FFC107',
    color: 'white',
    border: 'none',
    borderRadius: '6px',
    cursor: 'pointer',
    padding: '6px',
    marginRight: '6px',
  },
  deleteButton: {
    backgroundColor: '#F44336',
    color: 'white',
    border: 'none',
    borderRadius: '6px',
    cursor: 'pointer',
    padding: '6px',
  },
};
