#! /bin/bash

test="Do not resolve ENTSVR File Host from DMZ"
host="file.example.net"
addr="10.10.8.15"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[F]	DNS	DMZ	${test}	${0}"
else
	echo -e "[P]	DNS	DMZ	${test}	${0}"
fi
