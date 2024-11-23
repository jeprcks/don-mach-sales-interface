import Link from 'next/link';
import { useState } from 'react';
import { CSSProperties } from 'react';

interface Styles {
  sidebar: CSSProperties;
  toggleButton: CSSProperties;
  avatarContainer: CSSProperties;
  avatar: CSSProperties;
  avatarName: CSSProperties;
  list: CSSProperties;
  listItem: CSSProperties;
  link: CSSProperties;
  linkText: CSSProperties;
  icon: CSSProperties;
  linkHover: CSSProperties;
}

export default function Sidebar(): JSX.Element {
  const [collapsed, setCollapsed] = useState<boolean>(false);

  const toggleSidebar = (): void => setCollapsed(!collapsed);

  return (
    <div style={{ ...styles.sidebar, width: collapsed ? '80px' : '240px' }}>
      <button onClick={toggleSidebar} style={styles.toggleButton}>
        {collapsed ? '☰' : '✕'}
      </button>

      {/* Avatar Section */}
      <div style={styles.avatarContainer}>
        <img
          src="/images/donmac.jpg" // Replace with the actual avatar image path
          alt="Admin Avatar"
          style={styles.avatar}
        />
        {!collapsed && <h3 style={styles.avatarName}>Admin</h3>}
      </div>

      {/* Menu Section */}
      <ul style={styles.list}>
        {/* <li style={styles.listItem}>
          <Link href="/dashboard" style={styles.link}>
            <i style={styles.icon} className="fas fa-tachometer-alt"></i>
            {!collapsed && <span style={styles.linkText}>Dashboard</span>}
          </Link>
        </li> */}
        <li style={styles.listItem}>
          <Link href="/products" style={styles.link}>
            <i style={styles.icon} className="fas fa-box"></i>
            {!collapsed && <span style={styles.linkText}>Products</span>}
          </Link>
        </li>
        <li style={styles.listItem}>
          <Link href="/sale" style={styles.link}>
            <i style={styles.icon} className="fas fa-chart-line"></i>
            {!collapsed && <span style={styles.linkText}>Sales</span>}
          </Link>
        </li>
        <li style={styles.listItem}>
          <Link href="/transaction" style={styles.link}>
            <i style={styles.icon} className="fas fa-history"></i>
            {!collapsed && <span style={styles.linkText}>Transaction History</span>}
          </Link>
        </li>
        {/* <li style={styles.listItem}>
          <Link href="/settings" style={styles.link}>
            <i style={styles.icon} className="fas fa-cog"></i>
            {!collapsed && <span style={styles.linkText}>Settings</span>}
          </Link>
        </li> */}
        <li style={styles.listItem}>
          <Link href="/login" style={styles.link}>
            <i style={styles.icon} className="fas fa-sign-out-alt"></i>
            {!collapsed && <span style={styles.linkText}>Logout</span>}
          </Link>
        </li>
      </ul>
    </div>
  );
}

const styles: Styles = {
  sidebar: {
    backgroundColor: '#2c3e50',
    color: '#ecf0f1',
    height: '100vh',
    position: 'fixed',
    transition: 'width 0.3s ease',
    overflow: 'hidden',
    boxShadow: '2px 0px 10px rgba(0, 0, 0, 0.1)',
  },
  toggleButton: {
    backgroundColor: '#3498db',
    color: '#fff',
    border: 'none',
    padding: '10px',
    cursor: 'pointer',
    width: '100%',
    fontSize: '1.2rem',
    textAlign: 'center',
    marginBottom: '10px',
    transition: 'background-color 0.3s ease',
  },
  avatarContainer: {
    textAlign: 'center',
    marginBottom: '20px',
    transition: 'opacity 0.3s ease',
  },
  avatar: {
    width: '60px',
    height: '60px',
    borderRadius: '50%',
    display: 'block',
    margin: '0 auto',
    border: '2px solid #3498db',
  },
  avatarName: {
    marginTop: '10px',
    fontSize: '1rem',
    color: '#ecf0f1',
  },
  list: {
    listStyleType: 'none',
    padding: '0',
    margin: '0',
  },
  listItem: {
    marginBottom: '15px',
  },
  link: {
    display: 'flex',
    alignItems: 'center',
    padding: '10px 15px',
    color: '#ecf0f1',
    textDecoration: 'none',
    fontSize: '1rem',
    transition: 'background-color 0.3s ease, color 0.3s ease',
  },
  linkText: {
    marginLeft: '10px',
    fontSize: '1rem',
  },
  icon: {
    fontSize: '1.2rem',
  },
  linkHover: {
    backgroundColor: '#34495e',
    color: '#1abc9c',
  },
};
