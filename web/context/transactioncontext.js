// context/transactioncontext.js
import React, { createContext, useContext, useState } from 'react';

// Create the Transaction Context
const TransactionContext = createContext();

// Define the Provider Component
export function TransactionProvider({ children }) {
  const [transactions, setTransactions] = useState([]);

  // Add a new transaction
  const addTransaction = (transaction) => {
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
export function useTransactions() {

    const context = useContext(TransactionContext);
    if (!context) {
      throw new Error('useTransactions must be used within a TransactionProvider');
    }
    return context;
  }


