for i in entwks entsvr dmz soc test; do
	echo Starting ${i}
	cd ${i}
	vagrant up
	cd ..
done


# routers handled separately due to boot fails on VirtualBox Guest Additions
cd routers
for i in rtr_pub_vy rtr_ext_vy rtr_dmz_vy rtr_int_vy rtr_ent_vy rtr_dev_vy; do
	vagrant up ${i} 
dont


