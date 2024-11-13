// src/components/TicketForm.js

import React, { useState } from 'react';
import { createTicket } from '../api/tickets';
import { useNavigate } from 'react-router-dom';

function TicketForm() {
  const [formData, setFormData] = useState({
    subject: '',
    category: 'Technical',
    description: '',
    priority: 'Low',
  });
  const navigate = useNavigate();

  const handleChange = (e) => {
    setFormData({
      ...formData,
      [e.target.name]: e.target.value,
    });
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      await createTicket(formData);
      navigate('/tickets');
    } catch (error) {
      console.error('Error creating ticket:', error);
    }
  };

  return (
    <div>
      <h2>Submit a Support Ticket</h2>
      <form onSubmit={handleSubmit}>
        <div>
          <label>Subject:</label>
          <input
            type="text"
            name="subject"
            value={formData.subject}
            onChange={handleChange}
            required
          />
        </div>
        <div>
          <label>Category:</label>
          <select name="category" value={formData.category} onChange={handleChange}>
            <option value="Technical">Technical</option>
            <option value="Billing">Billing</option>
            <option value="General Inquiry">General Inquiry</option>
          </select>
        </div>
        <div>
          <label>Description:</label>
          <textarea
            name="description"
            value={formData.description}
            onChange={handleChange}
            required
          ></textarea>
        </div>
        <div>
          <label>Priority:</label>
          <select name="priority" value={formData.priority} onChange={handleChange}>
            <option value="Low">Low</option>
            <option value="Medium">Medium</option>
            <option value="High">High</option>
          </select>
        </div>
        <button type="submit">Submit Ticket</button>
      </form>
    </div>
  );
}

export default TicketForm;

