FROM cm2network/tf2:sourcemod

ENV METAMOD_VERSION 1.10
ENV SOURCEMOD_VERSION 1.10

LABEL maintainer="leigh.macdonald@gmail.com"

COPY plugins/* /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/
COPY extensions/* /home/steam/tf-dedicated/tf/addons/sourcemod/extensions/

