from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
from django.conf import settings


class CustomUserManager(BaseUserManager):
    def create_user(self, email, username, firstName, lastName, phoneNumber, password=None, **extra_fields):
        if not email:
            raise ValueError('Email is required')
        if not username:
            raise ValueError('Username is required')
        if not firstName:
            raise ValueError('First name is required')
        if not lastName:
            raise ValueError('Last name is required')
        if not phoneNumber:
            raise ValueError('Phone number is required')

        email = self.normalize_email(email)
        user = self.model(
            email=email,
            username=username,
            firstName=firstName,
            lastName=lastName,
            phoneNumber=phoneNumber,
            **extra_fields
        )
        user.set_password(password)
        user.save(using=self._db)
        return user

    def create_superuser(self, email, username, firstName, lastName, phoneNumber, password=None, **extra_fields):
        extra_fields.setdefault('is_staff', True)
        extra_fields.setdefault('is_superuser', True)
        return self.create_user(email, username, firstName, lastName, phoneNumber, password, **extra_fields)


class User(AbstractBaseUser, PermissionsMixin):
    userID = models.AutoField(primary_key=True)
    username = models.CharField(max_length=255, unique=True)
    email = models.EmailField(unique=True)
    firstName = models.CharField(max_length=100)
    lastName = models.CharField(max_length=100)
    phoneNumber = models.CharField(max_length=10, unique=True)
    address = models.CharField(max_length=255, blank=True, null=True)
    city = models.CharField(max_length=100, blank=True, null=True)
    country = models.CharField(max_length=50, blank=True, null=True)
    postalCode = models.CharField(max_length=10, blank=True, null=True)
    pointsBalance = models.IntegerField(default=0)
    createdAt = models.DateTimeField(auto_now_add=True)
    updatedAt = models.DateTimeField(auto_now=True)

    is_active = models.BooleanField(default=True)
    is_staff = models.BooleanField(default=False)  

    objects = CustomUserManager()

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = ['username', 'firstName', 'lastName', 'phoneNumber']

    def __str__(self):
        return self.email


class Admin(models.Model):
    adminID = models.AutoField(primary_key=True)
    lastName = models.CharField(max_length=25)
    firstName = models.CharField(max_length=25)
    dateOfBirth = models.DateField(null=True, blank=True)
    username = models.CharField(max_length=45)
    password = models.CharField(max_length=45)

    def __str__(self):
        return self.username


class Product(models.Model):
    productID = models.AutoField(primary_key=True)
    productName = models.CharField(max_length=255, unique=True)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    exclusive = models.BooleanField()
    createdAt = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.productName


class Purchase(models.Model):
    purchaseID = models.AutoField(primary_key=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.SET_NULL, null=True, db_column='userID')
    purchaseDate = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Purchase {self.purchaseID}"


class PurchaseDetail(models.Model):
    purchaseDetailID = models.AutoField(primary_key=True)
    purchase = models.ForeignKey(Purchase, on_delete=models.CASCADE, db_column='purchaseID')
    product = models.ForeignKey(Product, on_delete=models.SET_NULL, null=True, db_column='productID')
    pointsEarned = models.IntegerField(default=0)

    def __str__(self):
        return f"PurchaseDetail {self.purchaseDetailID} for Purchase {self.purchase.purchaseID}"


class LoyaltyTransaction(models.Model):
    TRANSACTION_TYPE_CHOICES = [
        ('earn', 'Earn'),
        ('redeem', 'Redeem'),
    ]

    transactionID = models.AutoField(primary_key=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, db_column='userID')
    points = models.IntegerField()
    transactionType = models.CharField(max_length=10, choices=TRANSACTION_TYPE_CHOICES)
    date = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Transaction {self.transactionID} ({self.transactionType}) for User {self.user.userID}"


class SupportTicket(models.Model):
    STATUS_CHOICES = [
        ('Open', 'Open'),
        ('In_progress', 'In Progress'),
        ('Resolved', 'Resolved'),
        ('Pending', 'Pending'),
    ]
    PRIORITY_CHOICES = [
        ('Low', 'Low'),
        ('Medium', 'Medium'),
        ('High', 'High'),
    ]

    ticketID = models.AutoField(primary_key=True)
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, db_column='userID')
    subject = models.CharField(max_length=100)
    description = models.TextField()
    category = models.CharField(max_length=100)
    status = models.CharField(max_length=20, choices=STATUS_CHOICES, default='Open')
    priority = models.CharField(max_length=10, choices=PRIORITY_CHOICES)
    createdAt = models.DateTimeField(auto_now_add=True)
    updatedAt = models.DateTimeField(auto_now=True)

    def __str__(self):
        return f"Ticket {self.ticketID} - {self.subject}"


class ChatSession(models.Model):
    sessionID = models.AutoField(primary_key=True)
    client = models.ForeignKey(User, on_delete=models.CASCADE, db_column='clientID', related_name='chat_sessions_as_client')
    agent = models.ForeignKey(Admin, on_delete=models.SET_NULL, null=True, db_column='agentID', related_name='chat_sessions_as_agent')
    startTime = models.DateTimeField(auto_now_add=True)
    endTime = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        agent_name = self.agent.username if self.agent else 'Unassigned'
        return f"ChatSession {self.sessionID} between {self.client.username} and {agent_name}"


class ChatMessage(models.Model):
    messageID = models.AutoField(primary_key=True)
    session = models.ForeignKey(ChatSession, on_delete=models.CASCADE, db_column='sessionID', related_name='messages')
    sender = models.ForeignKey(User, on_delete=models.CASCADE, db_column='senderID')
    messageText = models.TextField(db_column='messageText')
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Message {self.messageID} in Session {self.session.sessionID}"


class AdminUserAssignment(models.Model):
    admin = models.ForeignKey(Admin, on_delete=models.CASCADE, db_column='adminID')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE, db_column='userID')

    class Meta:
        unique_together = ('admin', 'user')
        db_table = 'AdminUserAssignment'

    def __str__(self):
        return f"Admin {self.admin.adminID} assigned to User {self.user.userID}"


class TicketComment(models.Model):
    commentID = models.AutoField(primary_key=True)
    ticket = models.ForeignKey(SupportTicket, on_delete=models.CASCADE, related_name='comments')
    user = models.ForeignKey(settings.AUTH_USER_MODEL, on_delete=models.CASCADE)
    commentText = models.TextField()
    timestamp = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Comment {self.commentID} on Ticket {self.ticket.ticketID}"

