#! /bin/bash

test="Resolve ENTSVR Web Host from ENTSVR"
host="entweb.example.net"
addr="10.10.8.14"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	DNS	ENTSVR	${test}	${0}"
else
        echo -e "[F]	DNS	ENTSVR	${test}	${0}"
fi

