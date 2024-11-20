
from django.urls import path
from . import views

urlpatterns = [
    path('login/', views.login_view, name='login'),
    path('logout/', views.logout_view, name='logout'),
    path('', views.home, name='home'),

    path('api/tickets/', views.SupportTicketListCreateView.as_view(), name='ticket-list'),
    path('api/tickets/<int:ticketID>/', views.SupportTicketDetailView.as_view(), name='ticket-detail'),
    path('api/tickets/<int:ticketID>/comments/', views.TicketCommentListCreateView.as_view(), name='ticket-comment-list'),

    path('api/chatsessions/', views.ChatSessionListCreateView.as_view(), name='chatsession-list'),
    path('api/chatsessions/<int:sessionID>/', views.ChatSessionDetailView.as_view(), name='chatsession-detail'),
    path('api/chatsessions/<int:sessionID>/messages/', views.ChatMessageListCreateView.as_view(), name='chatmessage-list'),

    path('api/products/', views.ProductListCreateView.as_view(), name='product-list'),

    path('api/purchases/', views.PurchaseListCreateView.as_view(), name='purchase-list'),

    path('api/loyaltytransactions/', views.LoyaltyTransactionListCreateView.as_view(), name='loyaltytransaction-list'),
]

