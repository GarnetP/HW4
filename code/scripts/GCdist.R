## Path to fasta
fasta_file <-"/pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz"

## Use awk to extract GC%  and filter for sequences > 100000
GCcontent <- system(paste(
    "bioawk -c fastx '{ if (length($seq) > 100000) { print  gc($seq) } }'",
    fasta_file
  ),
  intern = TRUE
)
# Convert to numeric  
GCcontent <- as.numeric(GCcontent)
# Make data frame 
df <- data.frame(GCcontent = GCcontent)
## Create histrogram and save it
library(ggplot2)
ggplot(df, aes(x = GCcontent)) +
geom_histogram(bins = 10, fill = "lightblue", color = "black") +
  labs(title = ">100kb Sequence GC% Distribution",
	x = "GC%",
	y = "Frequency") +
	theme_minimal()
ggsave("more100kGCdistribution.png")   






## Use awk to extract GC%  and filter for sequences <= 100000
GCcontent <- system(paste(
    "bioawk -c fastx '{ if (length($seq) <= 100000) { print  gc($seq) } }'",
    fasta_file
  ),
  intern = TRUE
)
# Convert to numeric  
GCcontent <- as.numeric(GCcontent)
# Make data frame 
df <- data.frame(GCcontent = GCcontent)
## Create histrogram and save it
library(ggplot2)
ggplot(df, aes(x = GCcontent)) +
geom_histogram(bins = 10, fill = "lightblue", color = "black") +
  labs(title = "<=100kb Sequence GC% Distribution",
        x = "GC%",
        y = "Frequency") +
        theme_minimal()
ggsave("less100kGCdistribution.png")








