// src/services/api.js

import axios from 'axios';

// Create an Axios instance with the base URL of your backend
const api = axios.create({
    baseURL: 'http://localhost:8000', // Adjust if your backend is hosted elsewhere
    withCredentials: true, // Include cookies if using Session-Based Auth
    headers: {
        'Content-Type': 'application/json',
    },
});

// If using Token-Based Auth (e.g., JWT), set the Authorization header
const accessToken = localStorage.getItem('access_token');
if (accessToken) {
    api.defaults.headers.common['Authorization'] = `Bearer ${accessToken}`;
}

export default api;

