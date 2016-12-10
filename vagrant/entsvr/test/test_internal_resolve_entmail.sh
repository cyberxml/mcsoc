#! /bin/bash

test="Resolve ENTSVR Mail Host from ENTSVR"
host="mail.example.net"
addr="10.10.8.13"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	ENTSVR	${test}	${0}"
else
        echo -e "[F]	ENTSVR	${test}	${0}"
fi
