#! /bin/bash

test="Do not resolve ENTSVR Web Host from DMZ"
host="web.example.net"
addr="10.10.8.14"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[F]	DNS	DMZ	${test}	${0}"
else
	echo -e "[P]	DNS	DMZ	${test}	${0}"
fi
