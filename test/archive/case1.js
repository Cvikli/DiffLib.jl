import React, { useState, useEffect, useCallback } from 'react';
import { useParams } from 'react-router-dom';
import styled, { keyframes } from 'styled-components';
import ChatComponent from './ChatComponent';
import ServerSettings from './ServerSettings';
import { useAppContext } from '../contexts/AppContext';
import { Button } from './SharedStyles';

const DefaultMessage = styled.div`
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  height: 100%;
  font-family: 'Courier New', monospace;
  color: ${props => props.theme.textColor};
  background-color: ${props => props.theme.backgroundColor};
  text-align: center;
  padding: 20px;
`;

const MessageContent = styled.div`
  max-width: 600px;
  width: 100%;
`;

const Title = styled.h2`
  margin-bottom: 20px;
`;

const Instructions = styled.ol`
  text-align: left;
  margin: 20px 0;
  padding-left: 20px;
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

function ChatPage() {
  const { conversationId } = useParams();
  const { conversations, theme, serverIP, serverPort } = useAppContext();
  const [isServerConnected, setIsServerConnected] = useState(false);
  const [isLoading, setIsLoading] = useState(true);

  const attemptConnection = useCallback(async () => {
    setIsLoading(true);
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

  useEffect(() => {
    attemptConnection();
  }, [attemptConnection]);

  if (isLoading) {
    return (
      <DefaultMessage theme={theme}>
        <MessageContent>
          <p>Connecting to server...</p>
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
          <SettingsRow>
            <ServerSettings />
            <RetryButton onClick={attemptConnection}>Retry Connection</RetryButton>
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