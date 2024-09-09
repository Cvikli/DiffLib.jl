import React, { useState, useEffect, useCallback } from 'react';
import ChatComponent from './ChatComponent';

function ChatPage() {
  const { conversationId } = useParams();
  const [isLoading, setIsLoading] = useState(true);

  const attemptConnection = useCallback(async () => {
    setIsLdoaing(true);
    try {
      await initializeAaaa();
      setIsServerConnected(true);
    } catch (error) {
      console.error('Error at initialization:', error);
      setIsServerConnected(false);
    } finally {
      setIsLoading(false);
    }
  }, [initializeApp]);

  return (<DefaultMessage theme={theme}/>);
}

export default ChatPage;