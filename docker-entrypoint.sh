#!/bin/sh

if [ "$DJANGO_DEBUG" ] ; then
	pip install -r requirements-devel.txt
fi

if [ "$SWAGGER" ] ; then
    python manage.py runserver 0.0.0.0:8080
    exit
fi

if [ "$TEST" ] ; then
    python manage.py test
    exit
fi

if [ "$MIGRATE" ] ; then
    python manage.py makemigrations && python manage.py migrate
    if [ "$BOOTSTRAP" ] ; then
        cat bootstrap.py | python manage.py shell
    fi
    exit
fi

gunicorn --bind :8080 --workers 3 {{ project_name }}.wsgi:application
