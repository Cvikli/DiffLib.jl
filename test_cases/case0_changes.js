import React, { useCallback } from 'react';
import ChatComponent from './ChatComponent';

function ChatPage() {
  // ... (existing code)

  const attemptConnection = useCallback(async () => {
    setIsLoading(true);
    try {
      await initializeApp();
      setIsServerConnected(true);
      setIsLoading(false);
    } catch (error) {
      console.error('Error at initialization: ', error);
      setIsServerConnected(false);
      setIsLoading(false);
      setRetryCount(prev => prev + 1);
    }
  }, [initializeApp]);

  return <DefaultMessage theme={theme}/>;
}

export default ChatPage;