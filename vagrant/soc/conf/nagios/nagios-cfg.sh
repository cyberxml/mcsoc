# ----------------------------------------------------------------
# enable the switch config in nagios.cfg
# ----------------------------------------------------------------
# find the container ID
cid=$(docker ps | tail -1 | cut -d' ' -f1)
cd /tmp
docker cp ${cid}:/opt/nagios/etc/nagios.cfg .

# uncomment the following line
# cfg_file=/opt/nagios/etc/objects/switch.cfg

docker cp nagios.cfg ${cid}:/opt/nagios/etc/nagios.cfg 

# ----------------------------------------------------------------
# define the McSOC switches in switch.cfg
# ----------------------------------------------------------------
