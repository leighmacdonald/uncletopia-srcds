FROM cm2network/steamcmd:root

ENV STEAMAPPID 232250
ENV STEAMAPP tf
ENV STEAMAPPDIR "${HOMEDIR}/${STEAMAPP}-dedicated"
ENV DLURL https://raw.githubusercontent.com/CM2Walki/TF2

ENV METAMOD_VERSION 1.10
ENV SOURCEMOD_VERSION 1.10

COPY entry.sh ${HOMEDIR}/entry.sh

RUN mkdir -p "${STEAMAPPDIR}/${STEAMAPP}"

RUN set -x \
	&& apt-get update \
	&& apt-get install -y --no-install-recommends --no-install-suggests \
		wget \
		ca-certificates \
		lib32z1 \
		libncurses5:i386 \
		libbz2-1.0:i386 \
		lib32gcc1 \
		lib32stdc++6 \
		libtinfo5:i386 \
		libcurl3-gnutls:i386 \
	&& mkdir -p "${STEAMAPPDIR}" \
	&& { \
		echo '@ShutdownOnFailedCommand 1'; \
		echo '@NoPromptForPassword 1'; \
		echo 'login anonymous'; \
		echo 'force_install_dir '"${STEAMAPPDIR}"''; \
		echo 'app_update '"${STEAMAPPID}"''; \
		echo 'quit'; \
	   } > "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& chmod +x "${HOMEDIR}/entry.sh" \
	&& chown -R "${USER}:${USER}" "${HOMEDIR}/entry.sh" "${STEAMAPPDIR}" "${HOMEDIR}/${STEAMAPP}_update.txt" \
	&& rm -rf /var/lib/apt/lists/*

RUN wget -qO- https://mms.alliedmods.net/mmsdrop/1.10/mmsource-1.10.7-git974-linux.tar.gz | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"	
RUN wget -qO- https://sm.alliedmods.net/smdrop/1.10/sourcemod-1.10.0-git6510-linux.tar.gz | tar xvzf - -C "${STEAMAPPDIR}/${STEAMAPP}"

COPY plugins/*.smx /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/
COPY extensions/*.so /home/steam/tf-dedicated/tf/addons/sourcemod/extensions/

RUN ls -la /home/steam/tf-dedicated/tf/addons/sourcemod/plugins

ENV SRCDS_FPSMAX=300 \
	SRCDS_TICKRATE=66 \
	SRCDS_PORT=27015 \
	SRCDS_TV_PORT=27020 \
        SRCDS_NET_PUBLIC_ADDRESS="0" \
        SRCDS_IP="0" \
	SRCDS_MAXPLAYERS=16 \
	SRCDS_TOKEN=0 \
	SRCDS_RCONPW="changeme" \
	SRCDS_PW="changeme" \
	SRCDS_STARTMAP="ctf_2fort" \
	SRCDS_REGION=3 \
        SRCDS_HOSTNAME="New \"${STEAMAPP}\" Server" \
        SRCDS_WORKSHOP_START_MAP=0 \
        SRCDS_HOST_WORKSHOP_COLLECTION=0 \
        SRCDS_WORKSHOP_AUTHKEY=""

USER ${USER}

VOLUME ${STEAMAPPDIR}

WORKDIR ${HOMEDIR}

CMD ["bash", "entry.sh"]

EXPOSE 27015/tcp 27015/udp 27020/udp

