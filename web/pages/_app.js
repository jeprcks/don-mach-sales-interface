// _app.js
import { TransactionProvider } from '../context/transactioncontext'; // Import TransactionProvider

function MyApp({ Component, pageProps }) {
  return (
    <TransactionProvider>
      <Component {...pageProps} />
    </TransactionProvider>
  );
}

export default MyApp;
