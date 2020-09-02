from datetime import datetime
# from django.db import models
from djongo import models
class authentiacated_user(models.Model):
    first_name = models.CharField(max_length=10)
    localId = models.CharField(max_length=250)
    idToken = models.CharField(max_length=1000)
    refreshToken = models.CharField(max_length=250)