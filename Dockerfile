
FROM ubuntu:latest


LABEL version="0.0.1"

RUN  apt-get update && apt-get upgrade -y

RUN apt-get install nginx -y

EXPOSE 81

CMD [ "nginx", "-g", "daemon off;"]