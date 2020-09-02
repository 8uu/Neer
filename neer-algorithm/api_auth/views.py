from random import choice
import pyrebase

from rest_framework import status
from rest_framework.generics import GenericAPIView
from rest_framework.response import Response

from api_auth.serializers import RegistrationSerializer, LoginSerializer

from django.contrib import auth as d_auth


config = {
    'apiKey': "AIzaSyAqo_82nzqVtE3Vu62aYF2P0dw6gHS0twA",
    'authDomain': "neer-test.firebaseapp.com",
    'databaseURL': "https://neer-test.firebaseio.com",
    'projectId': "neer-test",
    'storageBucket': "neer-test.appspot.com",
    'messagingSenderId': "933718335729",
    'appId': "1:933718335729:web:6e4bc597b3c4005ce10950"
}

firebase = pyrebase.initialize_app(config)
f_auth = firebase.auth()
f_database = firebase.database()

class RegisterView(GenericAPIView):
    serializer_class = RegistrationSerializer

    def post(self, request):
        data = request.data
        print(data)
        username = data.get('username')
        email = data.get('email')
        if data['password1'] != data['password2']:
            return Response(status=status.HTTP_400_BAD_REQUEST,
                            data = {"message" : "Password must match."})
        
        # build new data frame for auth and database push
        data['password'] = data['password1']
        del data['password1']
        del data['password2']

        try:
            # create authentication info in firebase authetication
            user = f_auth.create_user_with_email_and_password(email, data['password'])
            uid = user['localId'] # primary key of user 
            # push to database -> user/uid/details/data
            f_database.child("users").child(uid).child("details").set(data)
        except:
            message = "User infomation has already existed. Please try again."
            return Response({'message': message}, status=status.HTTP_400_BAD_REQUEST)
        
        serializer = RegistrationSerializer(data)
        return Response(serializer.data, status=status.HTTP_201_CREATED)


class LoginView(GenericAPIView):
    serializer_class = LoginSerializer

    def post(self, request):
        data = request.data
        email = data.get('email')
        password = data.get('password')
        if not email or not password:
            return Response(status=status.HTTP_400_BAD_REQUEST,
                            data={'msg': 'Email and password can not be empty.'})
        
        try:
            # authentication and retrieve response message
            user = f_auth.sign_in_with_email_and_password(email, password)
            # search database to find corresponding attribute "first_name"
            uid = user["localId"]
            name = f_database.child("users").child(uid).child("details").child("first_name").get()
            user['first_name'] = name.val()
        except:
            message = "Invalid credentials. Please try again."
            return Response({'detail': 'Invalid credentials'}, status=status.HTTP_401_UNAUTHORIZED)
        
        serializer = LoginSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)