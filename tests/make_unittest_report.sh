#! /bin/bash

./run_scripts.sh > "../docs/McSOC Unittests Report.txt"

fail=$(grep "\[F\]" ../docs/McSOC\ Unittests\ Report.txt | wc -l)
pass=$(grep "\[P\]" ../docs/McSOC\ Unittests\ Report.txt | wc -l)
all=$(cat ../docs/McSOC\ Unittests\ Report.txt | wc -l)

dt=$(date +"%Y%m%d")
echo TEST PASSED: $pass > ../docs/buildlog/buildlog-${dt}
echo TEST FAILED: $fail >> ../docs/buildlog/buildlog-${dt}
echo ================== >> ../docs/buildlog/buildlog-${dt}
echo Total Tests: $all >> ../docs/buildlog/buildlog-${dt}
echo >> ../docs/buildlog/buildlog-${dt}
echo $pass $all | awk '{printf "%.2f",100.0*$1/$2; print "% success rate"}' >> ../docs/buildlog/buildlog-${dt}
echo >> ../docs/buildlog/buildlog-${dt}
grep "\[F\]" ../docs/McSOC\ Unittests\ Report.txt  >> ../docs/buildlog/buildlog-${dt}

cat ../docs/buildlog/buildlog-${dt}

