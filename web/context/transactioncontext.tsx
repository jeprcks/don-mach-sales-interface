import React, { createContext, useContext, useState, ReactNode, useEffect } from 'react';

interface Product {
  id: number;
  name: string;
  price: number;
  quantity: number;
}

interface Transaction {
  orderNumber: number;
  date: string;
  orderList: Product[];
  totalPrice: number;
}

interface TransactionContextType {
  transactions: Transaction[];
  addTransaction: (transaction: Transaction) => void;
}

// Create the Transaction Context with default value
const TransactionContext = createContext<TransactionContextType>({
  transactions: [],
  addTransaction: () => { } // Default empty function
});

interface TransactionProviderProps {
  children: ReactNode;
}

// Define the Provider Component
export function TransactionProvider({ children }: TransactionProviderProps) {
  // Load initial state from localStorage if available
  const [transactions, setTransactions] = useState<Transaction[]>(() => {
    if (typeof window !== 'undefined') {
      const saved = localStorage.getItem('transactions');
      return saved ? JSON.parse(saved) : [];
    }
    return [];
  });

  // Save to localStorage whenever transactions change
  useEffect(() => {
    if (typeof window !== 'undefined') {
      localStorage.setItem('transactions', JSON.stringify(transactions));
    }
  }, [transactions]);

  // Add a new transaction
  const addTransaction = (transaction: Transaction) => {
    setTransactions((prev) => [...prev, transaction]);
  };

  // Provide transactions and the addTransaction function
  return (
    <TransactionContext.Provider value={{ transactions, addTransaction }}>
      {children}
    </TransactionContext.Provider>
  );
}

// Hook to use the Transaction Context
export function useTransactions(): TransactionContextType {
  const context = useContext(TransactionContext);
  if (!context) {
    throw new Error('useTransactions must be used within a TransactionProvider');
  }
  return context;
}
