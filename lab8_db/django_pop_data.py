# populate_data.py

from django.contrib.auth.models import User
from support.models import SupportTicket, TicketComment, ChatSession, ChatMessage

# create Users
if not User.objects.filter(username='admin').exists():
    admin_user = User.objects.create_superuser(username='admin', email='admin@example.com', password='adminpassword')
    print("Superuser 'admin' created.")
else:
    admin_user = User.objects.get(username='admin')
    print("Superuser 'admin' already exists.")

# create Regular Users
if not User.objects.filter(username='john_doe').exists():
    user1 = User.objects.create_user(username='john_doe', email='john@example.com', password='johnpassword')
    print("User 'john_doe' created.")
else:
    user1 = User.objects.get(username='john_doe')
    print("User 'john_doe' already exists.")

if not User.objects.filter(username='jane_smith').exists():
    user2 = User.objects.create_user(username='jane_smith', email='jane@example.com', password='janepassword')
    print("User 'jane_smith' created.")
else:
    user2 = User.objects.get(username='jane_smith')
    print("User 'jane_smith' already exists.")

# create Agent User
if not User.objects.filter(username='agent_bob').exists():
    agent = User.objects.create_user(username='agent_bob', email='bob@example.com', password='bobpassword', is_staff=True)
    print("Agent user 'agent_bob' created.")
else:
    agent = User.objects.get(username='agent_bob')
    print("Agent user 'agent_bob' already exists.")

# create support tickets
ticket1, created = SupportTicket.objects.get_or_create(
    subject="Issue with EcoFix App",
    description="The app crashes whenever I try to open it.",
    category="Technical",
    priority="High",
    status="Open",
    user=user1
)
if created:
    print(f"SupportTicket '{ticket1.subject}' created for user '{user1.username}'.")
else:
    print(f"SupportTicket '{ticket1.subject}' already exists.")

ticket2, created = SupportTicket.objects.get_or_create(
    subject="Billing Inquiry",
    description="I was charged twice for my subscription.",
    category="Billing",
    priority="Medium",
    status="Open",
    user=user2
)
if created:
    print(f"SupportTicket '{ticket2.subject}' created for user '{user2.username}'.")
else:
    print(f"SupportTicket '{ticket2.subject}' already exists.")

# ticket Comments
comment1, created = TicketComment.objects.get_or_create(
    ticket=ticket1,
    user=user1,
    comment_text="I'm experiencing the same issue consistently."
)
if created:
    print(f"TicketComment by '{user1.username}' added to '{ticket1.subject}'.")
else:
    print(f"TicketComment by '{user1.username}' on '{ticket1.subject}' already exists.")

comment2, created = TicketComment.objects.get_or_create(
    ticket=ticket1,
    user=agent,
    comment_text="We're looking into this issue and will update you shortly."
)
if created:
    print(f"TicketComment by '{agent.username}' added to '{ticket1.subject}'.")
else:
    print(f"TicketComment by '{agent.username}' on '{ticket1.subject}' already exists.")

comment3, created = TicketComment.objects.get_or_create(
    ticket=ticket2,
    user=user2,
    comment_text="I need a refund for the extra charge."
)
if created:
    print(f"TicketComment by '{user2.username}' added to '{ticket2.subject}'.")
else:
    print(f"TicketComment by '{user2.username}' on '{ticket2.subject}' already exists.")

# Create Chat Sessions
chat_session1, created = ChatSession.objects.get_or_create(
    client=user1,
    agent=agent
)
if created:
    print(f"ChatSession between '{user1.username}' and '{agent.username}' created.")
else:
    print(f"ChatSession between '{user1.username}' and '{agent.username}' already exists.")

chat_session2, created = ChatSession.objects.get_or_create(
    client=user2,
    agent=agent
)
if created:
    print(f"ChatSession between '{user2.username}' and '{agent.username}' created.")
else:
    print(f"ChatSession between '{user2.username}' and '{agent.username}' already exists.")

# create chat messages
message1, created = ChatMessage.objects.get_or_create(
    session=chat_session1,
    sender=user1,
    message_text="Hello, I'm having trouble logging in."
)
if created:
    print(f"ChatMessage by '{user1.username}' added to ChatSession {chat_session1.session_id}.")
else:
    print(f"ChatMessage by '{user1.username}' on ChatSession {chat_session1.session_id} already exists.")

message2, created = ChatMessage.objects.get_or_create(
    session=chat_session1,
    sender=agent,
    message_text="Hi John, I'm sorry to hear that. Let's resolve this issue together."
)
if created:
    print(f"ChatMessage by '{agent.username}' added to ChatSession {chat_session1.session_id}.")
else:
    print(f"ChatMessage by '{agent.username}' on ChatSession {chat_session1.session_id} already exists.")

message3, created = ChatMessage.objects.get_or_create(
    session=chat_session2,
    sender=user2,
    message_text="I noticed an extra charge on my account."
)
if created:
    print(f"ChatMessage by '{user2.username}' added to ChatSession {chat_session2.session_id}.")
else:
    print(f"ChatMessage by '{user2.username}' on ChatSession {chat_session2.session_id} already exists.")

message4, created = ChatMessage.objects.get_or_create(
    session=chat_session2,
    sender=agent,
    message_text="I'm reviewing your billing details. I'll get back to you shortly."
)
if created:
    print(f"ChatMessage by '{agent.username}' added to ChatSession {chat_session2.session_id}.")
else:
    print(f"ChatMessage by '{agent.username}' on ChatSession {chat_session2.session_id} already exists.")

