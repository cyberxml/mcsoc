#! /bin/bash

test="Resolve DMZ PROXY from DMZ"
host="proxy.example.net"
addr="10.10.3.6"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[P]	DNS	DMZ	${test}	${0}"
else
	echo -e "[F]	DNS	DMZ	${test}	${0}"
fi