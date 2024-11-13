import axios from 'axios';

const API_URL = 'http://localhost:8000/api';

// get all chat sessions for the user
export const getChatSessions = async () => {
  return await axios.get(`/api/tickets/chat-sessions/`);
};

export const createChatSession = async () => {
  return await axios.post(`/api/tickets/chat-sessions/`);
};

// get  messages in a session
export const getChatMessages = async (sessionId) => {
  return await axios.get(`/api/tickets/chat-sessions/${sessionId}/messages/`);
};

// send chat message
export const sendChatMessage = async (sessionId, messageData) => {
  return await axios.post(`/api/tickets/chat-sessions/${sessionId}/messages/`, messageData);
};

