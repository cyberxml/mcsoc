#! /bin/bash

cd /vagrant/test

for i in $(ls test*); do
	./${i}
done
