
import React, { useState, useEffect } from 'react';
import api from '../services/api'; // FIXME pointing to your Axios instance

const ChatWindow = () => {
  const [chatSessions, setChatSessions] = useState([]);
  const [currentSession, setCurrentSession] = useState(null);
  const [messageText, setMessageText] = useState('');
  const [messages, setMessages] = useState([]);
  const [agentId, setAgentId] = useState('');
  const [error, setError] = useState(null);

  // fetch existing chat sessions t
  useEffect(() => {
    const fetchChatSessions = async () => {
      try {
        const response = await api.get('/api/tickets/chat-sessions/');
        setChatSessions(response.data);
      } catch (error) {
        console.error('Error fetching chat sessions:', error.response ? error.response.data : error.message);
        setError('Failed to load chat sessions.');
      }
    };

    fetchChatSessions();
  }, []);

  //  start a new chat session
  const handleStartChat = async () => {
    if (agentId.trim() === '') {
      setError('Agent ID cannot be empty.');
      return;
    }

    try {
      const response = await api.post('/api/tickets/chat-sessions/', {
        agent: agentId, 
      });
      setChatSessions([...chatSessions, response.data]);
      setAgentId(''); 
      setError(null);
    } catch (error) {
      console.error('Error starting chat session:', error.response ? error.response.data : error.message);
      setError('Failed to start chat session.');
    }
  };

  // select a chat session and fetch its messages
  const handleSelectSession = async (sessionId) => {
    try {
      const response = await api.get(`/api/tickets/chat-sessions/${sessionId}/messages/`);
      setMessages(response.data);
      setCurrentSession(sessionId);
      setError(null);
    } catch (error) {
      console.error('Error fetching messages:', error.response ? error.response.data : error.message);
      setError('Failed to load messages for the selected chat session.');
    }
  };

  // send message in the current chat session
  const handleSendMessage = async () => {
    if (!currentSession) {
      setError('No chat session selected.');
      return;
    }

    if (messageText.trim() === '') {
      setError('Message cannot be empty.');
      return;
    }

    try {
      const response = await api.post(`/api/tickets/chat-sessions/${currentSession}/messages/`, {
        message_text: messageText,
      });
      setMessages([...messages, response.data]);
      setMessageText(''); 
      setError(null); 
    } catch (error) {
      console.error('Error sending message:', error.response ? error.response.data : error.message);
      setError('Failed to send message.');
    }
  };

  return (
    <div style={{ padding: '20px', maxWidth: '800px', margin: '0 auto' }}>
      <h1>Chat</h1>

      {/* display error messages */}
      {error && <div style={{ color: 'red', marginBottom: '10px' }}>{error}</div>}

      {/* start a new chat session */}
      <div style={{ marginBottom: '20px' }}>
        <h2>Start a New Chat Session</h2>
        <input
          type="text"
          placeholder="Agent ID"
          value={agentId}
          onChange={(e) => setAgentId(e.target.value)}
          style={{ marginRight: '10px', padding: '5px', width: '200px' }}
        />
        <button onClick={handleStartChat} style={{ padding: '5px 10px' }}>
          Start Chat
        </button>
      </div>

      {/* list active chat sessions */}
      <div style={{ marginBottom: '20px' }}>
        <h2>Active Chat Sessions</h2>
        {chatSessions.length === 0 ? (
          <p>No active chat sessions.</p>
        ) : (
          <ul style={{ listStyleType: 'none', padding: '0' }}>
            {chatSessions.map((session) => (
              <li key={session.session_id} style={{ marginBottom: '5px', display: 'flex', alignItems: 'center' }}>
                <span style={{ flex: 1 }}>
                  Session {session.session_id} with {session.agent ? session.agent.username : 'Unassigned'}
                </span>
                <button onClick={() => handleSelectSession(session.session_id)} style={{ padding: '2px 5px' }}>
                  Select
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>

      {/* section to display and send messages in selected chat session */}
      {currentSession && (
        <div>
          <h2>Chat Session {currentSession}</h2>
          <div
            style={{
              border: '1px solid #ccc',
              padding: '10px',
              height: '300px',
              overflowY: 'scroll',
              marginBottom: '10px',
              backgroundColor: '#f9f9f9',
            }}
          >
            {messages.length === 0 ? (
              <p>No messages yet.</p>
            ) : (
              messages.map((message) => (
                <p key={message.message_id} style={{ margin: '5px 0' }}>
                  <strong>{message.sender ? message.sender.username : 'Unknown'}:</strong> {message.message_text}
                </p>
              ))
            )}
          </div>
          <textarea
            value={messageText}
            onChange={(e) => setMessageText(e.target.value)}
            placeholder="Type your message..."
            rows="3"
            style={{ width: '100%', padding: '5px' }}
          ></textarea>
          <button onClick={handleSendMessage} style={{ marginTop: '5px', padding: '5px 10px' }}>
            Send
          </button>
        </div>
      )}
    </div>
  );
};

export default ChatWindow;

