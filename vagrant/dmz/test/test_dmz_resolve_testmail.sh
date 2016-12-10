#! /bin/bash

test="Resolve External Mail Host from DMZ"
host="testmail.pub.test"
addr="10.10.1.113"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
	echo -e "[P]	DMZ	${test}	${0}"
else
	echo -e "[F]	DMZ	${test}	${0}"
fi
