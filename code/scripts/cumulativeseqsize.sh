#!/bin/bash

## Path to fasta
fasta_file="/pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz"

## Use awk to filter for sequences > 100000 and sort
bioawk -c fastx '{ if (length($seq) > 100000) { print length($seq) } }' "$fasta_file" \
| sort -rn > morecumulativeseqsize.txt 

# Plotting
plotCDF morecumulativeseqsize.txt morecumulativeseqsize.png




## Use awk to filter for sequences <= 100000 and sort
bioawk -c fastx '{ if (length($seq) <= 100000) { print length($seq) } }' "$fasta_file" \
| sort -rn > lesscumulativeseqsize.txt 

# Plotting. 
plotCDF lesscumulativeseqsize.txt lesscumulativeseqsize.png




