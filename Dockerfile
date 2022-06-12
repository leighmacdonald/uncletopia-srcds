FROM leighmacdonald/base-srcds:master
LABEL org.opencontainers.image.source="https://github.com/leighmacdonald/uncletopia-srcds"

COPY data/* /home/steam/tf-dedicated/tf

VOLUME ${STEAMAPPDIR}/tf/addons/sourcemod/data/dumps