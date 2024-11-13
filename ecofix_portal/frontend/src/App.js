import React from 'react';
import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import TicketList from './components/TicketList';
import TicketDetail from './components/TicketDetail';
import TicketForm from './components/TicketForm';
import ChatWindow from './components/ChatWindow';
import InquiryDashboard from './components/InquiryDashboard';


function App() {
  return (
    <Router>
      <Routes>
        <Route path="/tickets/new" element={<TicketForm />} />
        <Route path="/tickets/:ticketId" element={<TicketDetail />} />
        <Route path="/tickets" element={<TicketList />} />
        <Route path="/chat" element={<ChatWindow />} />
        <Route path="/" element={<InquiryDashboard />} />
      </Routes>
    </Router>
  );
}

export default App;

