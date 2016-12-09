for i in entwks entsvr dmz soc test routers; do
	echo Halting ${i}
	cd ${i}
	vagrant halt
	cd ..
done
