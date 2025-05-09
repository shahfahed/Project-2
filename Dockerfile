FROM ubuntu
RUN apt update
RUN apt install apache2 -y
COPY img /var/www/html/
ADD index.html /var/www/html/
ENTRYPOINT apachectl -D FOREGROUND