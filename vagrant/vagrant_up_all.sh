for i in entwks entsvr dmz soc test routers; do
	echo Starting ${i}
	cd ${i}
	vagrant up
	cd ..
done
