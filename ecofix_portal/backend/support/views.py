from django.contrib.auth import authenticate, login, logout
from django.shortcuts import render, redirect
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from rest_framework import generics
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import get_user_model
from .models import (
    SupportTicket,
    ChatSession,
    ChatMessage,
    TicketComment,
    Product,
    Purchase,
    PurchaseDetail,
    LoyaltyTransaction,
    Admin
)
from .serializers import (
    SupportTicketSerializer,
    TicketCommentSerializer,
    ChatSessionSerializer,
    ChatMessageSerializer,
    UserSerializer,
    AdminSerializer,
    ProductSerializer,
    PurchaseSerializer,
    PurchaseDetailSerializer,
    LoyaltyTransactionSerializer
)
from .forms import CustomAuthenticationForm

User = get_user_model()



def login_view(request):
    if request.method == "POST":
        form = CustomAuthenticationForm(request, data=request.POST)
        if form.is_valid():
            email = form.cleaned_data.get("username")
            password = form.cleaned_data.get("password")
            user = authenticate(request, email=email, password=password)
            if user is not None:
                login(request, user)
                messages.info(request, f"You are now logged in as {email}.")
                return redirect("home")  
            else:
                messages.error(request, "Invalid email or password.")
        else:
            messages.error(request, "Invalid email or password.")
    else:
        form = CustomAuthenticationForm()
    return render(request, "support/login.html", {"form": form})

def logout_view(request):
    logout(request)
    messages.info(request, "You have successfully logged out.")
    return redirect("login")  

@login_required
def home(request):
    return render(request, "support/home.html")





class SupportTicketListCreateView(generics.ListCreateAPIView):
    serializer_class = SupportTicketSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if user.is_staff or isinstance(user, Admin):
            return SupportTicket.objects.all()
        else:
            return SupportTicket.objects.filter(user=user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class SupportTicketDetailView(generics.RetrieveUpdateAPIView):
    serializer_class = SupportTicketSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'ticketID'

    def get_queryset(self):
        user = self.request.user
        if user.is_staff or isinstance(user, Admin):
            return SupportTicket.objects.all()
        else:
            return SupportTicket.objects.filter(user=user)

    def perform_update(self, serializer):
        serializer.save()



class TicketCommentListCreateView(generics.ListCreateAPIView):
    serializer_class = TicketCommentSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        ticket_id = self.kwargs['ticketID']
        return TicketComment.objects.filter(ticket__ticketID=ticket_id)

    def perform_create(self, serializer):
        ticket_id = self.kwargs['ticketID']
        ticket = SupportTicket.objects.get(ticketID=ticket_id)
        serializer.save(user=self.request.user, ticket=ticket)



class ChatSessionListCreateView(generics.ListCreateAPIView):
    serializer_class = ChatSessionSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        if isinstance(user, Admin):
            
            return ChatSession.objects.filter(agent=user.admin)
        else:
            
            return ChatSession.objects.filter(client=user)

    def perform_create(self, serializer):
        serializer.save(client=self.request.user)

class ChatSessionDetailView(generics.RetrieveUpdateAPIView):
    serializer_class = ChatSessionSerializer
    permission_classes = [IsAuthenticated]
    lookup_field = 'sessionID'

    def get_queryset(self):
        user = self.request.user
        if isinstance(user, Admin):
            return ChatSession.objects.filter(agent=user.admin)
        else:
            return ChatSession.objects.filter(client=user)



class ChatMessageListCreateView(generics.ListCreateAPIView):
    serializer_class = ChatMessageSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        session_id = self.kwargs['sessionID']
        return ChatMessage.objects.filter(session__sessionID=session_id)

    def perform_create(self, serializer):
        session_id = self.kwargs['sessionID']
        session = ChatSession.objects.get(sessionID=session_id)
        serializer.save(sender=self.request.user, session=session)



class ProductListCreateView(generics.ListCreateAPIView):
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Product.objects.all()



class PurchaseListCreateView(generics.ListCreateAPIView):
    serializer_class = PurchaseSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return Purchase.objects.filter(user=user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)



class LoyaltyTransactionListCreateView(generics.ListCreateAPIView):
    serializer_class = LoyaltyTransactionSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user = self.request.user
        return LoyaltyTransaction.objects.filter(user=user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

