// _app.tsx
import { AppProps } from 'next/app';
import { TransactionProvider } from '@/context/transactioncontext'; // Import TransactionProvider

function MyApp({ Component, pageProps }: AppProps): JSX.Element {
    return (
        <TransactionProvider>
            <Component {...pageProps} />
        </TransactionProvider>
    );
}

export default MyApp;
