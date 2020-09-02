# Neer Backend API

The backend service REST API and algorithm implementation for Neer.

# Project Layout
Neer-Algorithm

- `Neer_backend`: core service
- `api_auth`: app for authentication
- `users`: app for user profile operation
- `orders`: app for orders operation flow
- ... other apps in the future


### Summary of Set up
1. Install pipenv
`pip3 install pipenv`
2. Clone the repository.
3. `cd` into `Neer-Algorithm` directory and run `pipenv install -r requirements.txt` to install necessary dependencies.
4. Create a virtualenv in the root of project with `pipenv shell` and activate the virtualenv.
5. Create a `.env` file in the same directory as `settings` to store environment variables.
    At this time, I only created `SECRET_KEY` for JWT Authentication and still under development.
    - `SECRET_KEY`: A random, 60-character, alphanumeric string, with special characters.

### Database Migration
Make sure you are in the same directory as `manage.py`, then run the following to develop:
1. Run `python manage.py makemigrations` to stage migrations
2. Then run `python manage.py migrate` to write the migrations to the database schema.
3. To boot the development server and use the API, run `python manage.py runserver`. 

## Creating an Admin User

Follow these steps to create a Django admin (superuser) user account, for the Django admin interface:
1. Activate your virtualenv.
2. `cd` into the `Neer-Algorithm` directory, where `manage.py` is located.
3. Run `python manage.py createsuperuser`, and enter appropriate values into the prompts.
4. To access the admin web interface, run `python manage.py runserver` to boot the dev server, and then navigate to `localhost:8000/admin` in your web browser.

### API Endpoints

You can use [postman](https://www.postman.com) to test the api during development.

As so far I only designed two APIs for Authentication.

- Create new user: `/api/auth/register`. Verbs: `POST`

You can try `http://127.0.0.1:8000/api/auth/registerr` and send json data as example following to test:

```
{
    "username": "testuser",
    "first_name": "Test",
    "last_name": "User",
    "email": "testuser@gmail.com",
    "password1": "password",
    "password2": "password"
}
```

After validations the service will created user in Firebase Authentication and push data info into Firebase database. The correct response should be like:
```
{
    "username": "testuser",
    "email": "testuser@gmail.com",
    "first_name": "Test",
    "last_name": "User"
}
```

- Login existing user: `/api/auth/login`. Verbs: `POST`

You can try `http://127.0.0.1:8000/api/auth/login` and send json data as example following to test:

```
{
    "email": "testuser@gmail.com",
    "password": "password"
}
```

If authenticated, the response should be like:

```
{
    "first_name": "Test",
    "localId": <localId>,
    "idToken": <idToken>,
    "refreshToken": <refreshToken>
}
```

The localId will be the primary key for further business operation in MangoDB.

### Reference
1. [Django Restframework](https://www.django-rest-framework.org)
2. [Django Documentation](https://docs.djangoproject.com/en/3.0/)
3. [GeoDjango Documentation](https://docs.djangoproject.com/en/3.0/ref/contrib/gis/)
4. [Uber Tech Stack Foundation](https://eng.uber.com/tech-stack-part-one-foundation/)
5. [Django Maps](https://djangopackages.org/grids/g/maps/)
6. [Back End Server for Ridesharing App](https://github.com/eric19960304/Ridesharing-App-For-HK-Back-End) -> For API design hints
7. ....
