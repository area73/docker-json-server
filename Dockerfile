FROM node:latest
MAINTAINER Rodrigo Erades <rerades@siete3.com>

RUN npm install -g json-server faker

WORKDIR /data
VOLUME /data

EXPOSE 80
ADD run.sh /run.sh
ENTRYPOINT ["bash", "/run.sh"]
CMD []
