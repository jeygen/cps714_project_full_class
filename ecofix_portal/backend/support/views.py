# support/views.py

from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.contrib.auth.forms import AuthenticationForm
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from rest_framework import generics, viewsets
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth.models import User
from .models import SupportTicket, ChatSession, ChatMessage, TicketComment
from .serializers import (
    SupportTicketSerializer, 
    TicketCommentSerializer, 
    ChatSessionSerializer, 
    ChatMessageSerializer,
    UserSerializer
)

# Authentication Views

def login_view(request):
    if request.method == "POST":
        form = AuthenticationForm(request, data=request.POST)
        if form.is_valid():
            username = form.cleaned_data.get("username")
            password = form.cleaned_data.get("password")
            user = authenticate(request, username=username, password=password)
            if user is not None:
                login(request, user)
                messages.info(request, f"You are now logged in as {username}.")
                return redirect("home")  # Redirect to home page after login
            else:
                messages.error(request, "Invalid username or password.")
        else:
            messages.error(request, "Invalid username or password.")
    else:
        form = AuthenticationForm()
    return render(request, "support/login.html", {"form": form})

def logout_view(request):
    logout(request)
    messages.info(request, "You have successfully logged out.")
    return redirect("login")  # Redirect to login page after logout

@login_required
def home(request):
    return render(request, "support/home.html")

# API Views

class SupportTicketListCreateView(generics.ListCreateAPIView):
    serializer_class = SupportTicketSerializer
    permission_classes = [IsAuthenticated]  # Require authentication
    
    def get_queryset(self):
        # Clients see their own tickets; Admins see all tickets
        user = self.request.user
        if user.is_staff:
            return SupportTicket.objects.all()
        else:
            return SupportTicket.objects.filter(user=user)
    
    def perform_create(self, serializer):
        # Automatically set user to the logged-in user
        serializer.save(user=self.request.user)
        #serializer.save(user="josh")
        # 

class SupportTicketDetailView(generics.RetrieveUpdateAPIView):
    serializer_class = SupportTicketSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'ticket_id'
    
    def get_queryset(self):
        user = self.request.user
        if user.is_staff:
            return SupportTicket.objects.all()
        else:
            return SupportTicket.objects.filter(user=user)
    
    def perform_update(self, serializer):
        serializer.save()

class TicketCommentListCreateView(generics.ListCreateAPIView):
    serializer_class = TicketCommentSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        ticket_id = self.kwargs['ticket_id']
        return TicketComment.objects.filter(ticket__ticket_id=ticket_id)
    
    def perform_create(self, serializer):
        ticket_id = self.kwargs['ticket_id']
        ticket = SupportTicket.objects.get(ticket_id=ticket_id)
        serializer.save(user=self.request.user, ticket=ticket)

class ChatSessionListCreateView(generics.ListCreateAPIView):
    serializer_class = ChatSessionSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        user = self.request.user
        return ChatSession.objects.filter(client=user) | ChatSession.objects.filter(agent=user)
    
    def perform_create(self, serializer):
        # On creation, only client is set; agent assignment is handled separately
        serializer.save(client=self.request.user)

class ChatMessageListCreateView(generics.ListCreateAPIView):
    serializer_class = ChatMessageSerializer
    permission_classes = [IsAuthenticated]
    
    def get_queryset(self):
        session_id = self.kwargs['session_id']
        return ChatMessage.objects.filter(session__session_id=session_id)
    def perform_create(self, serializer):
        session_id = self.kwargs['session_id']
        session = ChatSession.objects.get(session_id=session_id)
        serializer.save(sender=self.request.user, session=session)

