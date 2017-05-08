#! /bin/bash

test="Verify Elasticsearch Service is Storing"
RETVAL=$(curl -XGET 'http://localhost:9200/filebeat-*/_search?pretty' 2>/dev/null | python -c "import sys, json; print(json.load(sys.stdin)['hits']['total'])")
#RETVAL=${cmd} 2>&1
if [ $RETVAL -gt 0 ]; then
	echo -e "[P]	SERVICE	ELASTIC	${test}	${0}"
else
	echo -e "[F]	SERVICE	ELASTIC	${test}	${0}"
fi
