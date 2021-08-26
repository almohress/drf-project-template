#!/bin/sh

echo "apply db migrations"
python manage.py makemigrations && python manage.py migrate

echo "creating default superuser"
cat bootstrap.py | python manage.py shell

echo "run server"
if [ "$DEBUG" = true ] ; then
    python manage.py runserver 0.0.0.0:8080
else
    gunicorn --bind :8080 --workers 3 {{ project_name }}.wsgi:application
fi