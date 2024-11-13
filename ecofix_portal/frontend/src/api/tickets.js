import axios from 'axios';

const API_URL = 'http://localhost:8000/api'; //

// Get all tickets for the logged-in user
export const getTickets = async () => {
  return await axios.get(`${API_URL}/tickets/`, {
    // include auth token if needed// FIX ME
  });
};

// Get ticket details by ID
export const getTicketById = async (ticketId) => {
  return await axios.get(`${API_URL}/tickets/${ticketId}/`);
};

// Create a new ticket
export const createTicket = async (ticketData) => {
  return await axios.post(`${API_URL}/tickets/`, ticketData);
};

// Add a comment to a ticket
export const addTicketComment = async (ticketId, commentData) => {
  return await axios.post(`${API_URL}/tickets/${ticketId}/comments/`, commentData);
};

