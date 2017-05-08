#! /bin/bash

test="Do not resolve ENTSVR Mail Host from DMZ"
host="entmail.example.net"
addr="10.10.8.13"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[F]	DNS	DMZ	${test}	${0}"
else
	echo -e "[P]	DNS	DMZ	${test}	${0}"
fi
