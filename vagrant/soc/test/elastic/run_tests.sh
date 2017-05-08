#! /bin/bash

cd /vagrant/test/elastic

for i in $(ls test*); do
	./${i}
done
