#! /bin/bash

test="Do not resolve ENTSVR DNS Host from DMZ"
host="dc1.example.net"
addr="10.10.8.11"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[F]	DMZ	${test}	${0}"
else
	echo -e "[P]	DMZ	${test}	${0}"
fi
