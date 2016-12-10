#! /bin/bash

test="Resolve External Web Host from ENTSVR"
host="testweb.pub.test"
addr="10.10.1.114"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	ENTSVR	${test}	${0}"
else
        echo -e "[F]	ENTSVR	${test}	${0}"
fi
