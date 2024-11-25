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
  | { type: 'SET_LOADING'; isLoading: boolean };

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
    case 'SET_ERROR':
      return { ...state, error: action.error };
    case 'SET_LOADING':
      return { ...state, isLoading: action.isLoading };
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

    // Simulated login process
    await new Promise((resolve) => setTimeout(resolve, 1000));

    if (state.username === 'user' && state.password === 'password') {
      router.push('/homepage');
    } else {
      dispatch({ type: 'SET_ERROR', error: 'Invalid username or password' });
    }

    dispatch({ type: 'SET_LOADING', isLoading: false });
  };

  return (
    <div style={styles.container}>
      <h1 style={styles.title}>Don Macchiatos Sales Interface System</h1>
      <h2 style={styles.header}>Welcome Back!</h2>
      <form onSubmit={handleLogin} style={styles.form}>
        {state.error && <div style={styles.error}>{state.error}</div>}
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
  );
}
