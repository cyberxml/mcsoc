#! /bin/bash

test="Resolve ENTSVR MAIL Host from ENTSVR"
host="entmail.example.net"
addr="10.10.8.13"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	DNS	ENTSVR	${test}	${0}"
else
        echo -e "[F]	DNS	ENTSVR	${test}	${0}"
fi

