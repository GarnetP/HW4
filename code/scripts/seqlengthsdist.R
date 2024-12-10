#!/bin/bash

## Path to fasta
fasta_file <-"/pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz"

## Use awk to extract sequence lengths and filter for sequences > 100000
lengths <- system(paste(
"bioawk -c fastx '{ if (length($seq) > 100000) { print length($seq) } }'", fasta_file
),
intern = TRUE
)

## Change lengths from character to numeric
lengths <- as.numeric(lengths)

df <- data.frame(lengths = lengths)

## Create histrogram and save it
library(ggplot2)
ggplot(df, aes(x = lengths)) +
geom_histogram(bins = 10, fill = "lightblue", color = "black") +
	scale_x_log10() +
  	labs(title = ">100kb Sequence Length Distribution",
        x = "Log Sequence Length",
        y = "Frequency") +
        theme_minimal()
ggsave("morefiltered_sequence_length_distribution.png")





## Use awk to extract sequence lengths and filter for sequences <= 100000
lengths <- system(paste(
"bioawk -c fastx '{ if (length($seq) <= 100000) { print length($seq) } }'", fasta_file
),
intern = TRUE
)

## Change lengths from character to numeric
lengths <- as.numeric(lengths)

df <- data.frame(lengths = lengths)

## Create histrogram and save it
library(ggplot2)
ggplot(df, aes(x = lengths)) +
geom_histogram(bins = 10, fill = "lightblue", color = "black") +
        scale_x_log10() +
        labs(title = "<=100kb Sequence Length Distribution",
        x = "Log Sequence Length",
        y = "Frequency") +
        theme_minimal()
ggsave("lessfiltered_sequence_length_distribution.png")

