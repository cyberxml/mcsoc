#! /bin/bash

test="Resolve EXAMPLE.NET from TEST"
host="dmzweb.example.net"
addr="10.10.3.5"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[P]	DNS	TEST	${test}	${0}"
else
	echo -e "[F]	DNS	TEST	${test}	${0}"
fi
