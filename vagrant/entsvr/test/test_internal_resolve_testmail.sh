#! /bin/bash

test="Resolve External Mail Host from ENTSVR"
host="testmail.pub.test"
addr="10.10.1.113"
cmd="host -t A ${host}"
RET=$(${cmd})
if [[ $RET =~ ${addr}$ ]]; then
        echo -e "[P]	ENTSVR	${test}	${0}"
else
        echo -e "[F]	ENTSVR	${test}	${0}"
fi

