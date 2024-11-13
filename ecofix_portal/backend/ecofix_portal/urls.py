


# ecofix_portal/urls.py

from django.contrib import admin
from django.urls import path, include
from django.views.generic import RedirectView

urlpatterns = [
    path('admin/', admin.site.urls),
    
    # API Endpoints
    path('api/tickets/', include('support.urls')), 
    path('api-auth/', include('rest_framework.urls', namespace='rest_framework')),
    
    # redirect  to admin
    path('', RedirectView.as_view(url='admin/', permanent=False)),
]
