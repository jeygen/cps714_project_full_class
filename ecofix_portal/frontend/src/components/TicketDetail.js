// src/components/TicketDetail.js

import React, { useEffect, useState } from 'react';
import { getTicketById, addTicketComment } from '../api/tickets';
import { useParams, Link } from 'react-router-dom';

function TicketDetail() {
  const { ticketId } = useParams();
  const [ticket, setTicket] = useState(null);
  const [comments, setComments] = useState([]);
  const [commentText, setCommentText] = useState('');

  useEffect(() => {
    async function fetchTicket() {
      try {
        const response = await getTicketById(ticketId);
        setTicket(response.data);
        // Assuming comments are included in the ticket data
        setComments(response.data.comments || []);
      } catch (error) {
        console.error('Error fetching ticket:', error);
      }
    }
    fetchTicket();
  }, [ticketId]);

  const handleCommentSubmit = async (e) => {
    e.preventDefault();
    try {
      await addTicketComment(ticketId, { comment_text: commentText });
      // Optionally, fetch comments again to ensure synchronization
      const updatedComments = await getTicketById(ticketId);
      setComments(updatedComments.data.comments || []);
      setCommentText('');
    } catch (error) {
      console.error('Error adding comment:', error);
    }
  };

  if (!ticket) return <div>Loading...</div>;

  return (
    <div>
      <h2>Ticket Details</h2>
      <Link to="/tickets">Back to Ticket List</Link> | <Link to="/chat">Live Chat</Link>
      <div>
        <h3>{ticket.subject}</h3>
        <p>
          <strong>Category:</strong> {ticket.category}
        </p>
        <p>
          <strong>Description:</strong> {ticket.description}
        </p>
        <p>
          <strong>Status:</strong> {ticket.status}
        </p>
        <p>
          <strong>Priority:</strong> {ticket.priority}
        </p>
      </div>
      <h3>Comments</h3>
      <div>
        {comments.map((comment, index) => (
          <div key={index}>
            <p>
              <strong>{comment.user.username}:</strong> {comment.comment_text}
            </p>
            <p>{new Date(comment.timestamp).toLocaleString()}</p>
          </div>
        ))}
      </div>
      <form onSubmit={handleCommentSubmit}>
        <div>
          <textarea
            name="commentText"
            value={commentText}
            onChange={(e) => setCommentText(e.target.value)}
            required
            placeholder="Add your comment here..."
          ></textarea>
        </div>
        <button type="submit">Add Comment</button>
      </form>
    </div>
  );
}

export default TicketDetail;

