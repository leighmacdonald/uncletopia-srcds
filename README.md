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

    - name: srcds
      docker_container:
        name: srcds-{{ item.server_name_short }}
        image: leighmacdonald/uncletopia-srcds:latest
        state: started
        restart: yes
        network_mode: host
        pull: yes
        restart_policy: always
        cpuset_cpus: "{{ loop0 * 2 }},{{ (loop0 * 2)+1 }}"
        ports:
          - "{{ srcds_base_port + (loop0 * 10) }}:{{ srcds_base_port + (loop0 * 10) }}/tcp"
          - "{{ srcds_base_port + (loop0 * 10) }}:{{ srcds_base_port + (loop0 * 10) }}/udp"
          - "{{ srcds_base_port + (loop0 * 10) + 1 }}:{{ srcds_base_port + (loop0 * 10) + 1 }}/udp"
        env:
          SRCDS_TOKEN: "{{ item.gslt }}"
          SRCDS_PORT: "{{ srcds_base_port + (loop0 * 10) }}"
          SRCDS_TV_PORT: "{{ srcds_base_port + 100 }}"
          SRCDS_REGION: "{{ sv_region|quote }}"
          SRCDS_HOSTNAME: "{{ item.name }}"
          SRCDS_PW: "{{ server_password }}"
          SRCDS_STARTMAP: "{{ start_map }}"
          SRCDS_RCONPW: "{{ rcon_password }}"
          SRCDS_IP: "{{ ip }}"
          SRCDS_MAXPLAYERS: "32"
        volumes:
          - /build/{{ item.server_name_short }}/server.cfg:/home/steam/tf-dedicated/tf/cfg/server.cfg
          - /build/admins_simple.ini:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/admins_simple.ini
          - /build/umc_mapcycle.txt:/home/steam/tf-dedicated/tf/umc_mapcycle.txt
          - /build/umc_mapcycle_nominate.txt:/home/steam/tf-dedicated/tf/umc_mapcycle_nominate.txt
          - /build/motd.txt:/home/steam/tf-dedicated/tf/cfg/motd.txt
          - /build/mapcycle_halloween.txt:/home/steam/tf-dedicated/tf/cfg/mapcycle_halloween.txt
          - /build/pure_server_whitelist.txt:/home/steam/tf-dedicated/tf/cfg/pure_server_whitelist.txt
          - /build/sourcemod.cfg:/home/steam/tf-dedicated/tf/cfg/sourcemod/sourcemod.cfg
          - /build/admin_overrides.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/admin_overrides.cfg
          - /build/gbans.cfg:/home/steam/tf-dedicated/tf/addons/sourcemod/configs/gbans.cfg
      loop: "{{ services }}"
      loop_control:
        index_var: loop0
