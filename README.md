# uncletopia-srcds

This is the source for the docker image used for running uncletopia game servers.

- It uses [DepotDownloader](https://github.com/SteamRE/DepotDownloader) instead of the standard steamcmd tool used in other images/servers.
- Game assets are downloaded into the base image in a reproducible manner vs steamcmd updating itself automatically on launch. This means its larger, but its easier to manage the shared game data when you are using multiple containers on a single host.
- Extensions/plugins/configs that we use are *included* in the base image.


## TODO

- Add build container for compiling plugins during build to copy from instead of the precompiled versions.
- Cleaner more "reusable" base image for larger audience

## Ansible

This image was designed for use with the [uncletopia ansible](https://github.com/leighmacdonald/uncletopia) roles. I will work without that but you
will have to generate all the config files yourself.

  docker run -d \
    --network host \
    -e "SRCDS_TOKEN=${SRCDS_TOKEN}" \
    -e "SRCDS_HOSTNAME=${SRCDS_HOSTNAME}" \
    -e "SRCDS_PW=${SRCDS_PW}" \
    -e "SRCDS_RCONPW=${SRCDS_RCONPW}" \
    -e "SRCDS_IP=${SRCDS_IP}" \
    -e "SRCDS_PORT=27055" \
    -e "SRCDS_TV_PORT=27056" \
    -e "SRCDS_REGION=0" \
    -e "SRCDS_STARTMAP=pl_badwater" \
    -e "SRCDS_NET_PUBLIC_ADDRESS=" \
    -e "SRCDS_TICKRATE=66" \
    -e "SRCDS_FPSMAX=300" \
    -e "STEAMAPPDIR=/home/steam/tf-dedicated" \
    -e "STEAMAPP=tf" \
    -e "STEAMAPPID=232250" \
    -e "STEAM_GAMESERVER_PACKET_HANDLER_NO_IPC=1" \
    -e "STEAM_GAMESERVER_RATE_LIMIT_200MS=25" \
    -e "STEAM_GAMESERVER_A2S_INFO_STRICT_LEGACY_PROTOCOL=0" \
    -e "SRCDS_MAXPLAYERS=32" \
    -v /build/core.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/core.cfg \
    -v /build/test-2/autoexec.cfg:/home/steam/tf-dedicated/tf/cfg/autoexec.cfg \
    -v /build/test-2/server.cfg:/home/steam/tf-dedicated/tf/cfg/server.cfg \
    -v /build/admins_simple.ini:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/admins_simple.ini \
    -v /build/motd.txt:/home/steam/tf-dedicated/tf/cfg/motd.txt \
    -v /build/admin_overrides.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/admin_overrides.cfg \
    -v /build/gbans.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/gbans.cfg \
    -v /build/test-2/mapcycle.txt:/home/steam/tf-dedicated/tf/cfg/mapcycle.txt \
    -v /build/randomcycle.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/randomcycle.cfg \
    -v /build/rtv.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/rtv.cfg \
    -v /build/sourcemod.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/sourcemod.cfg \
    -v /build/mapchooser.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/mapchooser.cfg \
    -v /build/discord.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/discord.cfg \
    -v /build/test-2/maplists.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/maplists.cfg \
    -v /build/autorecorder.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/autorecorder.cfg \
    -v /build/nativevotes.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/nativevotes.cfg \
    -p 27115:27115/udp \
    -p 27115:27115/tcp \
    --restart=always \
    --name uncletopia-srcds-test-2 \
    ghcr.io/leighmacdonald/uncletopia-srcds:${BRANCH}

## Building & Upload to docker hub

    make image && make publish
    
 
