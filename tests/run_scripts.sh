#! /bin/bash

PROJDIR=/data/projects/mcsoc

cd $PROJDIR/vagrant/entsvr
vagrant ssh dc1 -c /vagrant/test/run_tests.sh 2>/dev/null

cd $PROJDIR/vagrant/dmz
vagrant ssh dmzdns -c /vagrant/test/run_tests.sh 2>/dev/null

cd $PROJDIR/vagrant/test
vagrant ssh testmail -c /vagrant/test/run_tests.sh 2>/dev/null

