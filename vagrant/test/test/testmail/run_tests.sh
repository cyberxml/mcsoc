#! /bin/bash

cd /vagrant/test/testmail

for i in $(ls test*); do
	./${i}
done
