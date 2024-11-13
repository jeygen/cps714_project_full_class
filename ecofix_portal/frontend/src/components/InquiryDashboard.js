// src/components/InquiryDashboard.js

import React, { useEffect, useState } from 'react';
import { getTickets } from '../api/tickets';
import { Link } from 'react-router-dom';

function InquiryDashboard() {
  const [openTickets, setOpenTickets] = useState([]);

  useEffect(() => {
    async function fetchOpenTickets() {
      try {
        const response = await getTickets();
        const open = response.data.filter((ticket) => ticket.status !== 'Closed');
        setOpenTickets(open);
      } catch (error) {
        console.error('Error fetching tickets:', error);
      }
    }
    fetchOpenTickets();
  }, []);

  return (
    <div>
      <h2>Inquiry Tracking Dashboard</h2>
      <Link to="/tickets/new">Submit New Ticket</Link> | <Link to="/chat">Live Chat</Link>
      <h3>Open Tickets</h3>
      <ul>
        {openTickets.map((ticket) => (
          <li key={ticket.ticket_id}>
            <Link to={`/tickets/${ticket.ticket_id}`}>{ticket.subject}</Link> - Status: {ticket.status}
          </li>
        ))}
      </ul>
    </div>
  );
}

export default InquiryDashboard;

