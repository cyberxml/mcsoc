#! /bin/bash

cd /vagrant/test/dmzdns

for i in $(ls test*); do
        ./${i}
done

