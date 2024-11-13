// src/components/TicketList.js

import React, { useEffect, useState } from 'react';
import { getTickets } from '../api/tickets';
import { Link } from 'react-router-dom';

function TicketList() {
  const [tickets, setTickets] = useState([]);

  useEffect(() => {
    async function fetchTickets() {
      try {
        const response = await getTickets();
        setTickets(response.data);
      } catch (error) {
        console.error('Error fetching tickets:', error);
      }
    }
    fetchTickets();
  }, []);

  return (
    <div>
      <h2>My Support Tickets</h2>
      <Link to="/tickets/new">Submit New Ticket</Link> | <Link to="/chat">Live Chat</Link>
      <table>
        <thead>
          <tr>
            <th>Ticket ID</th>
            <th>Subject</th>
            <th>Status</th>
            <th>Created At</th>
            <th>Priority</th>
          </tr>
        </thead>
        <tbody>
          {tickets.map((ticket) => (
            <tr key={ticket.ticket_id}>
              <td>
                <Link to={`/tickets/${ticket.ticket_id}`}>{ticket.ticket_id}</Link>
              </td>
              <td>{ticket.subject}</td>
              <td>{ticket.status}</td>
              <td>{new Date(ticket.created_at).toLocaleString()}</td>
              <td>{ticket.priority}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export default TicketList;

