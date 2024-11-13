# Import necessary Django modules
from django.db import models
from django.contrib.auth.models import User

# SupportTicket Model
class SupportTicket(models.Model):
    STATUS_CHOICES = [
        ('Open', 'Open'),
        ('In Progress', 'In Progress'),
        ('Closed', 'Closed'),
    ]
    PRIORITY_CHOICES = [
        ('Low', 'Low'),
        ('Medium', 'Medium'),
        ('High', 'High'),
    ]
    CATEGORY_CHOICES = [
        ('Technical', 'Technical'),
        ('Billing', 'Billing'),
        ('General Inquiry', 'General Inquiry'),
    ]
    
    ticket_id = models.AutoField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='tickets')
    subject = models.CharField(max_length=50)
    description = models.TextField()
    category = models.CharField(max_length=100, choices=CATEGORY_CHOICES)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Open')
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)
    
    def __str__(self):
        return f"Ticket {self.ticket_id} - {self.subject}"

# ChatSession Model
class ChatSession(models.Model):
    session_id = models.AutoField(primary_key=True)
    client = models.ForeignKey(User, on_delete=models.CASCADE, related_name='chat_sessions_as_client')
    agent = models.ForeignKey(User, on_delete=models.SET_NULL, null=True, related_name='chat_sessions_as_agent')
    start_time = models.DateTimeField(auto_now_add=True)
    end_time = models.DateTimeField(null=True, blank=True)
    
    def __str__(self):
        return f"ChatSession {self.session_id} between {self.client.username} and {self.agent.username if self.agent else 'Unassigned'}"

# ChatMessage Model
class ChatMessage(models.Model):
    message_id = models.AutoField(primary_key=True)
    session = models.ForeignKey(ChatSession, on_delete=models.CASCADE, related_name='messages')
    sender = models.ForeignKey(User, on_delete=models.CASCADE)
    message_text = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Message {self.message_id} in Session {self.session.session_id}"

# Additional Model for Ticket Comments
class TicketComment(models.Model):
    comment_id = models.AutoField(primary_key=True)
    ticket = models.ForeignKey(SupportTicket, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    comment_text = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)
    
    def __str__(self):
        return f"Comment {self.comment_id} on Ticket {self.ticket.ticket_id}"

