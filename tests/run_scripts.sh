#! /bin/bash

PROJDIR=/data/projects/mcsoc

cd $PROJDIR/vagrant/entsvr
vagrant ssh dc1 -c /vagrant/test/entdns/run_tests.sh 2>/dev/null
vagrant ssh mail -c /vagrant/test/entmail/run_tests.sh 2>/dev/null

cd $PROJDIR/vagrant/dmz
vagrant ssh dmzdns -c /vagrant/test/dmzdns/run_tests.sh 2>/dev/null
vagrant ssh dmzmail -c /vagrant/test/dmzmail/run_tests.sh 2>/dev/null
vagrant ssh dmzweb -c /vagrant/test/dmzweb/run_tests.sh 2>/dev/null

cd $PROJDIR/vagrant/test
vagrant ssh testmail -c /vagrant/test/testmail/run_tests.sh 2>/dev/null


# ------------------------------------------------------------------------------------
# These are 'staged' tests that require specific steps in order in more than one zone
# ------------------------------------------------------------------------------------

# ------------------------------------------------------------------------------------
# email from TEST to ENTSVR (with and without EICAR text)
# ------------------------------------------------------------------------------------
cd $PROJDIR/vagrant/test
vagrant ssh testmail -c /vagrant/test/testmail/staged/test_external_send_mail_to_entmail.sh 2>/dev/null
vagrant ssh testmail -c /vagrant/test/testmail/staged/test_external_send_mail_to_entmail_eicar.sh 2>/dev/null

cd $PROJDIR/vagrant/entsvr
vagrant ssh mail -c /vagrant/test/staged/entmail/test_internal_read_mail_from_testmail.sh 2>/dev/null
vagrant ssh mail -c /vagrant/test/staged/entmail/test_internal_read_mail_from_testmail_eicar.sh 2>/dev/null

# ------------------------------------------------------------------------------------
# email from ENTSVR to TEST
# ------------------------------------------------------------------------------------
cd $PROJDIR/vagrant/entsvr
vagrant ssh mail -c /vagrant/test/entmail/staged/test_internal_send_mail_to_testmail.sh 2>/dev/null

# the delivery outbound can be delayed by as much as several minutes
sleep 120
cd $PROJDIR/vagrant/test
vagrant ssh testmail -c /vagrant/test/testmail/staged/test_external_read_mail_from_entmail.sh 2>/dev/null

