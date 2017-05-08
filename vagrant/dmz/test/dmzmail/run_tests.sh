#! /bin/bash

cd /vagrant/test/dmzmail

for i in $(ls test*); do
        ./${i}
done

