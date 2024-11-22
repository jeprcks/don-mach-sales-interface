// _app.js
import '../styles/globals.css';
import { TransactionProvider } from '../context/transactioncontext';

export default function MyApp({ Component, pageProps }) {
  return (
    <TransactionProvider>
      <Component {...pageProps} />
    </TransactionProvider>
  );
}
