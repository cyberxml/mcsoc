#! /bin/bash

cd /vagrant/test/dmzweb

for i in $(ls test*); do
        ./${i}
done

