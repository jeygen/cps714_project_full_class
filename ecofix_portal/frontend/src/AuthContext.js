// maybe not needed ROSS
import React, { createContext, useState, useEffect } from 'react';
import axios from 'axios';

export const AuthContext = createContext();

export const AuthProvider = ({ children }) => {
  const [user, setUser] = useState(null);

  // Fetch user info on mount
  useEffect(() => {
    async function fetchUser() {
      try {
        const response = await axios.get('/api/user/');
        setUser(response.data);
      } catch (error) {
        console.error('Error fetching user:', error);
        setUser(null);
      }
    }
    fetchUser();
  }, []);

  return <AuthContext.Provider value={{ user }}>{children}</AuthContext.Provider>;
};

