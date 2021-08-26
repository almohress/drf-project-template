ARG env

FROM python:3.9 AS build
RUN useradd -ms /bin/bash app
USER app
WORKDIR /home/app
ADD . .

FROM build as env-production
RUN pip install --no-cache-dir -r requirements.txt

FROM build AS env-test
RUN pip install --no-cache-dir -r requirements.txt -r requirements-devel.txt

FROM env-${env} AS final
EXPOSE 8080
CMD ["./docker-entrypoint.sh"]