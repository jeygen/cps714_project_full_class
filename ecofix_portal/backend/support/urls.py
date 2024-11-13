from django.urls import path
from . import views

urlpatterns = [
    #  Authentication URLs
    path('login/', views.login_view, name='login'), # FIXME
    path('logout/', views.logout_view, name='logout'), # FIXME 
    path('home/', views.home, name='home'), # FIXME

    # support Tickets
    path('', views.SupportTicketListCreateView.as_view(), name='ticket-list-create'), 
    path('<int:ticket_id>/', views.SupportTicketDetailView.as_view(), name='ticket-detail'),
    path('<int:ticket_id>/comments/', views.TicketCommentListCreateView.as_view(), name='ticket-comment-list-create'),
    
    # Chat Sessions
    path('chat-sessions/', views.ChatSessionListCreateView.as_view(), name='chat-session-list-create'),
    path('chat-sessions/<int:session_id>/messages/', views.ChatMessageListCreateView.as_view(), name='chat-message-list-create'),
]

