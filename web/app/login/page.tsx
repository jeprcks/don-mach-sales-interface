'use client';
import { useReducer, FormEvent } from 'react';
import { useRouter } from 'next/navigation';

interface Styles {
  container: React.CSSProperties;
  title: React.CSSProperties;
  header: React.CSSProperties;
  form: React.CSSProperties;
  inputGroup: React.CSSProperties;
  label: React.CSSProperties;
  input: React.CSSProperties;
  button: React.CSSProperties;
  error: React.CSSProperties;
  togglePassword: React.CSSProperties;
  buttonHover: React.CSSProperties;
  errorMessage: React.CSSProperties;
}

const styles: Styles = {
  container: {
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    height: '100vh',
    backgroundColor: '#f3e5dc', // Warm cream background
    padding: '20px',
  },
  title: {
    fontSize: '3.5rem',
    color: '#6f4e37', // Coffee brown
    marginBottom: '1.5rem',
    fontFamily: `'Playfair Display', serif`,
    textAlign: 'center',
    marginTop: '2rem', // Moved higher
  },
  header: {
    textAlign: 'center',
    marginBottom: '2rem',
    fontSize: '2rem',
    color: '#6f4e37',
    fontFamily: `'Playfair Display', serif`,
  },
  form: {
    display: 'flex',
    flexDirection: 'column',
    width: '100%',
    maxWidth: '400px',
    backgroundColor: '#fffdf8',
    padding: '30px',
    borderRadius: '12px',
    boxShadow: '0 6px 20px rgba(0, 0, 0, 0.2)',
  },
  inputGroup: {
    marginBottom: '1.5rem',
  },
  label: {
    marginBottom: '0.5rem',
    fontWeight: 'bold',
    color: '#6f4e37',
    fontSize: '1rem',
  },
  input: {
    padding: '12px',
    border: '1px solid #d0c7c1',
    borderRadius: '6px',
    width: '100%',
    outline: 'none',
    fontSize: '1rem',
    fontFamily: `'Lato', sans-serif`,
    backgroundColor: '#fefcfb',
  },
  button: {
    padding: '12px',
    backgroundColor: '#6f4e37',
    color: 'white',
    border: 'none',
    borderRadius: '8px',
    cursor: 'pointer',
    fontSize: '1rem',
    fontWeight: 'bold',
    fontFamily: `'Lato', sans-serif`,
    transition: 'transform 0.2s, background-color 0.3s',
    boxShadow: '0 4px 10px rgba(0, 0, 0, 0.2)',
  },
  buttonHover: {
    transform: 'scale(1.05)',
    backgroundColor: '#5a3c2d',
  },
  error: {
    color: 'red',
    fontSize: '0.9rem',
    marginBottom: '1rem',
    textAlign: 'center',
    fontFamily: `'Lato', sans-serif`,
  },
  togglePassword: {
    marginTop: '10px',
    fontSize: '0.9rem',
    color: '#6f4e37',
    cursor: 'pointer',
    textAlign: 'right',
    textDecoration: 'underline',
  },
  errorMessage: {
    position: 'fixed',
    top: '20px',
    left: '50%',
    transform: 'translateX(-50%)',
    backgroundColor: '#ffebee',
    color: '#c62828',
    padding: '12px 24px',
    borderRadius: '8px',
    boxShadow: '0 2px 10px rgba(0, 0, 0, 0.1)',
    zIndex: 1000,
    fontFamily: `'Lato', sans-serif`,
    display: 'flex',
    alignItems: 'center',
    gap: '8px',
  },
};

interface FormState {
  username: string;
  password: string;
  showPassword: boolean;
  error: string;
  isLoading: boolean;
}

type Action =
  | { type: 'SET_FIELD'; field: keyof FormState; value: string | boolean }
  | { type: 'SET_ERROR'; error: string }
  | { type: 'SET_LOADING'; isLoading: boolean }
  | { type: 'RESET_FORM' };

const initialState: FormState = {
  username: '',
  password: '',
  showPassword: false,
  error: '',
  isLoading: false,
};

const reducer = (state: FormState, action: Action): FormState => {
  switch (action.type) {
    case 'SET_FIELD':
      return { ...state, [action.field]: action.value };
    case 'RESET_FORM':
      return initialState;
    default:
      return state;
  }
};

export default function LoginPage() {
  const [state, dispatch] = useReducer(reducer, initialState);
  const router = useRouter();

  const handleLogin = async (e: FormEvent<HTMLFormElement>) => {
    e.preventDefault();
    dispatch({ type: 'SET_ERROR', error: '' });
    dispatch({ type: 'SET_LOADING', isLoading: true });
    dispatch({ type: 'SET_ERROR', error: 'Attempting to log in...' });

    try {
      const loginResponse = await fetch('http://localhost:8000/api/login', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify({
          username: state.username,
          password: state.password,
        }),
      });

      if (!loginResponse.ok) {
        dispatch({ type: 'SET_ERROR', error: 'Username or password is incorrect' });
        return;
      }

      const loginData = await loginResponse.json();

      if (loginData.token) {
        dispatch({ type: 'SET_ERROR', error: 'Login successful! Redirecting...' });
        localStorage.setItem('token', loginData.token);
        localStorage.setItem('userId', loginData.user.id.toString());
        localStorage.setItem('isAuthenticated', 'true');
        setTimeout(() => {
          router.push('/homepage');
        }, 1000);
      } else {
        throw new Error('Authentication failed');
      }
    } catch (error) {
      console.error('Login error:', error);
      dispatch({ type: 'SET_ERROR', error: 'Login failed. Please try again.' });
    } finally {
      dispatch({ type: 'SET_LOADING', isLoading: false });
    }
  };

  return (
    <>
      {state.error && (
        <div style={styles.errorMessage}>
          <svg width="20" height="20" viewBox="0 0 24 24" fill="currentColor">
            <path d="M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-2h2v2zm0-4h-2V7h2v6z" />
          </svg>
          {state.error}
        </div>
      )}
      <div style={styles.container}>
        <h1 style={styles.title}>Don Macchiatos Sales Interface System</h1>
        <h2 style={styles.header}>Welcome Back!</h2>
        <form onSubmit={handleLogin} style={styles.form}>
          <div style={styles.inputGroup}>
            <label style={styles.label} htmlFor="username">
              Username
            </label>
            <input
              id="username"
              type="text"
              value={state.username}
              onChange={(e) =>
                dispatch({ type: 'SET_FIELD', field: 'username', value: e.target.value })
              }
              required
              style={styles.input}
              aria-labelledby="username-label"
            />
          </div>
          <div style={styles.inputGroup}>
            <label style={styles.label} htmlFor="password">
              Password
            </label>
            <input
              id="password"
              type={state.showPassword ? 'text' : 'password'}
              value={state.password}
              onChange={(e) =>
                dispatch({ type: 'SET_FIELD', field: 'password', value: e.target.value })
              }
              required
              style={styles.input}
              aria-labelledby="password-label"
            />
          </div>
          <button
            type="submit"
            style={{
              ...styles.button,
              ...(state.isLoading ? {} : styles.buttonHover),
            }}
            disabled={state.isLoading}
          >
            {state.isLoading ? 'Logging in...' : 'Login'}
          </button>
        </form>
      </div>
    </>
  );
}
