#!/bin/bash
cd /pub/gphinney/myrepos/ee282/data/processed
fasta_file="myassembly.fa"

# Extract sequence lengths from the FASTA file
awk '/^>/ {if (seqlen){print seqlen}; seqlen=0; next} {seqlen += length($0)} END {print seqlen}' "$fasta_file" > lengths.txt

# Sort lengths in descending order
sort -nr lengths.txt > sorted_lengths.txt

# Calculate total length
total_length=$(awk '{sum += $1} END {print sum}' sorted_lengths.txt)

# Calculate N50
awk -v total_length="$total_length" '
{
    cumulative_length += $1;
    if (cumulative_length >= total_length / 2) {
        print "N50:", $1;
        exit;
    }
}
' sorted_lengths.txt
