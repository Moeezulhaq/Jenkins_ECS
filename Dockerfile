# FROM ubuntu
# ENV DEBIAN_FRONTEND=noninteractive
# RUN apt-get update
# RUN apt-get install apache2 -y
# RUN apt-get install apache2-utils -y
# RUN apt-get clean
# EXPOSE 80
# CMD ["apache2ctl","-D","FOREGROUND"]

FROM nginx
RUN cd /var/www
RUN mkdir tutorial
RUN cd tutorial
COPY index.html /index.html
EXPOSE 80
