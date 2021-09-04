FROM cm2network/tf2:sourcemod

LABEL maintainer="leigh.macdonald@gmail.com"

RUN "${STEAMCMDDIR}/steamcmd.sh" +login anonymous +force_install_dir "${STEAMAPPDIR}" +app_update "${STEAMAPPID}" +quit