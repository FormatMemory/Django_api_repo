# Django_api_repo
Dive into _Django_


Build backend restful service on Django & Django restframework.

*Docker* contains Django backend and MySQL

## How to run
**Have a environment config file**: You can simply do it by Changing ***.env.example*** file name to ***.env*** ```mv .env.example to .env```

**Build image**: ```docker-compose build```

**Run docker image**: ```docker-compose up```

**Run test**: ```docker-compose run --rm app sh -c "python manage.py test"```
If you want to use flake8 to check code format simply run ```docker-compose run --rm app sh -c "python manage.py test && flake8"```

You may change the environment settings in file ***.env*** .

By default, you can access ```127.0.0.1:8000``` to check if this project runs correctly and ```127.0.0.1:8000/api``` to see available backend API.
