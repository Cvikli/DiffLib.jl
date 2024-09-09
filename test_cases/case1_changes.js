import React, { useState, useEffect, useCallback } from 'react';
import { useParams } from 'react-router-dom';
import styled, { keyframes } from 'styled-components';
import ChatComponent from './ChatComponent';
import ServerSettings from './ServerSettings';
import { useAppContext } from '../contexts/AppContext';
import { Button } from './SharedStyles';

// ... (existing styled components)

const pulse = keyframes`
  0% {
    opacity: 1;
  }
  50% {
    opacity: 0.5;
  }
  100% {
    opacity: 1;
  }
`;

const SettingsRow = styled.div`
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 20px;
`;

const RetryButton = styled(Button)`
  margin-left: 10px;
`;

const PulsingText = styled.p`
  animation: ${pulse} 2s infinite ease-in-out;
`;

function ChatPage() {
  const { conversationId } = useParams();
  const { conversations, theme, serverIP, serverPort, initializeApp } = useAppContext();
  const [isServerConnected, setIsServerConnected] = useState(false);
  const [isLoading, setIsLoading] = useState(true);
  const [retryCount, setRetryCount] = useState(0);

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

  useEffect(() => {
    attemptConnection();
    const intervalId = setInterval(() => {
      if (!isServerConnected) {
        attemptConnection();
      }
    }, 2000);

    return () => clearInterval(intervalId);
  }, [attemptConnection, isServerConnected]);

  if (isLoading) {
    return (
      <DefaultMessage theme={theme}>
        <MessageContent>
          <PulsingText>Connecting to server...</PulsingText>
        </MessageContent>
      </DefaultMessage>
    );
  }

  if (!isServerConnected) {
    return (
      <DefaultMessage theme={theme}>
        <MessageContent>
          <Title>Server Connection Error</Title>
          <p>Unable to connect to the backend server. Please follow these steps to set up:</p>
          <Instructions>
            <li>Make sure the backend server is running on {serverIP}:{serverPort}</li>
            <li>Check if you have started the server using the run.sh script</li>
            <li>Ensure all dependencies are installed</li>
          </Instructions>
          <PulsingText>Attempting to reconnect... (Attempt {retryCount})</PulsingText>
          <SettingsRow>
            <ServerSettings />
            <RetryButton onClick={attemptConnection}>Retry Now</RetryButton>
          </SettingsRow>
        </MessageContent>
      </DefaultMessage>
    );
  }

  if (!conversations[conversationId]) {
    return (
      <DefaultMessage theme={theme}>
        <MessageContent>
          <p>No conversation selected. Please choose a conversation from the sidebar or start a new one.</p>
        </MessageContent>
      </DefaultMessage>
    );
  }

  return <ChatComponent />;
}

export default ChatPage;