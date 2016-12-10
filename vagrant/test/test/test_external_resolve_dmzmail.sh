#! /bin/bash

test="Resolve DMZ MAIL from TEST"
host="dmzmail.example.net"
addr="10.10.3.4"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi
