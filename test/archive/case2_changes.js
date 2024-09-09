import React, { createContext, useState, useEffect, useContext, useCallback, useMemo, useRef } from 'react';
import { useNavigate } from 'react-router-dom';
import axios from 'axios';
import { lightTheme, darkTheme } from '../theme';
import { setCookie, getCookie } from '../cookies';

// ... (previous imports and code)

export const AppProvider = ({ children }) => {
  // ... (previous state declarations)

  const [autoReconnect, setAutoReconnect] = useState(() => getCookie('autoReconnect') !== 'false');

  // ... (previous code)

  const toggleAutoReconnect = useCallback(() => {
    setAutoReconnect(prev => {
      const newValue = !prev;
      setCookie('autoReconnect', newValue);
      return newValue;
    });
  }, []);

  // ... (previous code)

  const value = useMemo(() => ({
    // ... (previous values)
    autoReconnect,
    toggleAutoReconnect,
    // ... (previous values)
  }), [
    // ... (previous dependencies)
    autoReconnect,
    toggleAutoReconnect,
    // ... (previous dependencies)
  ]);

  return <AppContext.Provider value={value}>{children}</AppContext.Provider>;
};

// ... (rest of the file)