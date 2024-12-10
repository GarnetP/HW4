#!/bin/bash
r6url="https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/215/GCA_000001215.4_Release_6_plus_ISO1_MT/GCA_000001215.4_Release_6_plus_ISO1_MT_genomic.fna.gz"
myassembly="/pub/gphinney/myrepos/ee282/data/processed/myassembly.fa"
tmp="/pub/gphinney/myrepos/ee282/tmp"

mkfifo $tmp/{r6scaff,r6ctg,myassembly}_fifo

wget -O - -q $r6url \
| tee >( \
  bioawk -c fastx ' { print length($seq) } ' \
  | sort -rn \
  | awk ' BEGIN { print "Assembly\tLength\nFB_Scaff\t0" } { print "FB_Scaff\t" $1 } ' \
  > $tmp/r6scaff_fifo & ) \
| faSplitByN /dev/stdin /dev/stdout 10 \
| bioawk -c fastx ' { print length($seq) } ' \
| sort -rn \
| awk ' BEGIN { print "Assembly\tLength\nFB_Ctg\t0" } { print "FB_Ctg\t" $1 } ' \
> $tmp/r6ctg_fifo &

bioawk -c fastx ' { print length($seq) } ' $myassembly \
| sort -rn \
| awk ' BEGIN { print "Assembly\tLength\nmyassembly\t0" } { print "myassembly\t" $1 } ' \
> $tmp/myassembly_fifo &

plotCDF2 $tmp/{r6scaff,r6ctg,myassembly}_fifo assemblycomparison.png

# Clean up the FIFOs.
rm $tmp/{r6scaff,r6ctg,myassembly}_fifo

