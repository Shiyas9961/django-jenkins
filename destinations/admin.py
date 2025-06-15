from django.contrib import admin
from .models import Destination

@admin.register(Destination)
class DestinationAdmin(admin.ModelAdmin):
    list_display = ('name', 'description', 'image_url')  # Adjust fields based on your model
    search_fields = ('name',)
    list_filter = ('name',)