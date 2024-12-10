#!/bin/bash

echo ">100000"
bioawk -c fastx 'length($seq) > 100000 {print ">" $name "\n" $seq } ' /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz \
 | faSize -tab /dev/stdin \
 | grep -e "baseCount" -e "nBaseCount" -e "seqCount"

echo "<=100000"
bioawk -c fastx 'length($seq) <= 100000 {print ">" $name "\n" $seq } ' /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz \
 | faSize -tab /dev/stdin \
 | grep -e "baseCount" -e "nBaseCount" -e "seqCount"
