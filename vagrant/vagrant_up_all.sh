for i in entwks entsvr dmz soc test routers; do
	echo Starting ${i}
	cd ${i}
	vagrant up
	cd ..
done


cd routers
for i in rtr_pub rtr_ext rtr_dmz rtr_int rtr_ent rtr_dev; do
	vagrant ssh ${i} -c "php -r \"require 'gwlb.inc'; setup_gateways_monitor();\""
done


