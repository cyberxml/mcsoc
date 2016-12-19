#! /bin/bash

test="Resolve ENTSVR Web Host from ENTWKS"
host="entweb.example.net"
addr="10.10.8.14"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	DNS	ENTWKS	${test}	${0}"
else
        echo -e "[F]	DNS	ENTWKS	${test}	${0}"
fi

