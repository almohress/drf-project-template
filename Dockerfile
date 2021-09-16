FROM python:3.9 

# install any package you want with root privileges here

RUN useradd -ms /bin/bash app
USER app
WORKDIR /home/app
ADD . .

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8080
CMD ["./docker-entrypoint.sh"]
