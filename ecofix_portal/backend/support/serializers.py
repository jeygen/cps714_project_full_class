# support/serializers.py

from rest_framework import serializers
from django.contrib.auth.models import User
from .models import SupportTicket, ChatSession, ChatMessage, TicketComment

# User Serializer (Assuming minimal fields)
class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email']

# SupportTicket Serializer
class SupportTicketSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)  # Make 'user' read-only
    comments = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    
    class Meta:
        model = SupportTicket
        fields = '__all__'
        read_only_fields = ['ticket_id', 'created_at', 'updated_at', 'status', 'user']

# TicketComment Serializer
class TicketCommentSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    
    class Meta:
        model = TicketComment
        fields = '__all__'
        read_only_fields = ['comment_id', 'timestamp', 'user']

# ChatSession Serializer
class ChatSessionSerializer(serializers.ModelSerializer):
    client = UserSerializer(read_only=True)
    agent = UserSerializer(read_only=True)
    messages = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    
    class Meta:
        model = ChatSession
        fields = '__all__'
        read_only_fields = ['session_id', 'start_time', 'end_time']

# ChatMessage Serializer
class ChatMessageSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)
    
    class Meta:
        model = ChatMessage
        fields = '__all__'
        read_only_fields = ['message_id', 'timestamp', 'sender']

