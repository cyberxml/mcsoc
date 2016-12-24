#! /bin/bash

cd /vagrant/test/entmail

for i in $(ls test*); do
	./${i}
done
