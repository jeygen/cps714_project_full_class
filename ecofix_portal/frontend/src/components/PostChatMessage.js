// src/components/PostChatMessage.js

import React, { useState } from 'react';
import api from '../services/api';

const PostChatMessage = ({ sessionId }) => {
    const [messageText, setMessageText] = useState('');

    const handlePostMessage = async () => {
        try {
            const response = await api.post(`/api/tickets/chat-sessions/${sessionId}/messages/`, {
                sender: currentUserId,
                message_text: messageText,
            });
            console.log('Message Posted:', response.data);
        } catch (error) {
            console.error('Error Posting Message:', error.response.data);
        }
    };

    return (
        <div>
            <h3>Post a Message</h3>
            <textarea
                value={messageText}
                onChange={(e) => setMessageText(e.target.value)}
                placeholder="Type your message here..."
            ></textarea>
            <button onClick={handlePostMessage}>Send</button>
        </div>
    );
};

export default PostChatMessage;

