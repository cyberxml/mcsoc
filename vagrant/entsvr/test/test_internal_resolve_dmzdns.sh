#! /bin/bash

test="Resolve DMZ DNS Host from ENTSVR"
host="dmzdns.example.net"
addr="10.10.3.3"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	ENTSVR	${test}	${0}"
else
        echo -e "[F]	ENTSVR	${test}	${0}"
fi

