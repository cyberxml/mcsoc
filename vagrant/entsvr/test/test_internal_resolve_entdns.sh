#! /bin/bash

test="Resolve ENTSVR DNS Host from ENTSVR"
host="dc1.example.net"
addr="10.10.8.11"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	ENTSVR	${test}	${0}"
else
        echo -e "[F]	ENTSVR	${test}	${0}"
fi

