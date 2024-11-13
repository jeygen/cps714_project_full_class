// src/components/CreateChatSession.js

import React, { useState } from 'react';
import api from '../services/api';

const CreateChatSession = () => {
    const [agentId, setAgentId] = useState('');

    const handleCreateSession = async () => {
        try {
            const response = await api.post('/api/tickets/chat-sessions/', {
                client: currentUserId, 
                agent: agentId,
            });
            console.log('Chat Session Created:', response.data);
        } catch (error) {
            console.error('Error Creating Chat Session:', error.response.data);
        }
    };

    return (
        <div>
            <h2>Create Chat Session</h2>
            <input
                type="text"
                value={agentId}
                onChange={(e) => setAgentId(e.target.value)}
                placeholder="Agent ID"
            />
            <button onClick={handleCreateSession}>Start Chat</button>
        </div>
    );
};

export default CreateChatSession;

