#! /bin/bash

cd /vagrant/test/entdns

for i in $(ls test*); do
	./${i}
done
