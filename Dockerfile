FROM leighmacdonald/base-srcds:master

RUN mv -v /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/disabled/mapchooser.smx /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/ 
RUN mv -v /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/disabled/nominations.smx /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/ 
RUN mv -v /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/disabled/randomcycle.smx /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/ 
RUN mv -v /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/disabled/rockthevote.smx /home/steam/tf-dedicated/tf/addons/sourcemod/plugins/ 
    
COPY data/* /home/steam/tf-dedicated/tf

