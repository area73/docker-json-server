FROM node:alpine

MAINTAINER Rodrigo Erades <rerades@siete3.com>

ADD data /data/extras

RUN npm install -g json-server faker

ENV NODE_PATH /usr/local/lib/node_modules/

WORKDIR /data
VOLUME /data

EXPOSE 80
ADD run.sh /run.sh
ENTRYPOINT ["sh", "/run.sh"]
CMD []

