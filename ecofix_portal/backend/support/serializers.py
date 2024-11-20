from rest_framework import serializers
from .models import (
    SupportTicket,
    ChatSession,
    ChatMessage,
    TicketComment,
    User,
    Admin,
    Product,
    Purchase,
    PurchaseDetail,
    LoyaltyTransaction
)

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = [
            'userID', 'email', 'username', 'firstName', 'lastName', 'phoneNumber',
            'address', 'city', 'country', 'postalCode', 'pointsBalance',
            'createdAt', 'updatedAt'
        ]

class AdminSerializer(serializers.ModelSerializer):
    class Meta:
        model = Admin
        fields = [
            'adminID', 'username', 'password', 'firstName', 'lastName', 'dateOfBirth'
        ]

class SupportTicketSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = SupportTicket
        fields = '__all__'

class TicketCommentSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = TicketComment
        fields = '__all__'

class ChatSessionSerializer(serializers.ModelSerializer):
    client = UserSerializer(read_only=True)
    agent = AdminSerializer(read_only=True)

    class Meta:
        model = ChatSession
        fields = '__all__'

class ChatMessageSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)

    class Meta:
        model = ChatMessage
        fields = '__all__'

class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = '__all__'

class PurchaseDetailSerializer(serializers.ModelSerializer):
    product = ProductSerializer(read_only=True)

    class Meta:
        model = PurchaseDetail
        fields = '__all__'

class PurchaseSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    purchase_details = PurchaseDetailSerializer(many=True, read_only=True)

    class Meta:
        model = Purchase
        fields = '__all__'

class LoyaltyTransactionSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)

    class Meta:
        model = LoyaltyTransaction
        fields = '__all__'

