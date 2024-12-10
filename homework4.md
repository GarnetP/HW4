# Homework 4
# Summarize Partitions of a Genome Assembly

## Download Genome from flybase
wget http://ftp.flybase.net/releases/current/dmel_r6.60/fasta/dmel-all-chromosome-r6.60.fasta.gz /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz

## Calculate for all sequences <= 100kb and >100kb (Script in code/scripts/partitionsum.sh)

```
echo ">100000"
bioawk -c fastx 'length($seq) > 100000 {print ">" $name "\n" $seq } ' /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz \
 | faSize -tab /dev/stdin \
 | grep -e "baseCount" -e "nBaseCount" -e "seqCount"

echo "<=100000"
bioawk -c fastx 'length($seq) <= 100000 {print ">" $name "\n" $seq } ' /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz \
 | faSize -tab /dev/stdin \
 | grep -e "baseCount" -e "nBaseCount" -e "seqCount"
```

### > 100kb
1. Total number of  nucleotides: 137547960
2. Total number of Ns: 490385
3. Total number of sequences: 7

### <= 100kb
1. Total number of  nucleotides: 6178042
2. Total number	of Ns: 662593
3. Total number	of sequences: 1863



## Plots for the two genome partitions (Scripts in code/scripts/seqlengthdist.R GCdist.R cumulativeseqsize.sh) 

### <= 100kb
1. Sequence length distribution:
2. Sequence GC% distribution:
3. Cumulative sequence size from largest to smallest

### > 100kb
1. Sequence length distribution:
2. Sequence GC% distribution:
3. Cumulative sequence size from largest to smallest




# Genome Assembly

## Assemble a genome using Pacbio HiFi reads
cp /data/class/ee282/public/ISO1_Hifi_AdaptorRem.40X.fasta.gz pub/gphinney/myrepos/ee282/ISO1_Hifi_AdaptorRem.40X.fasta.gz
hifiasm -o pub/gphinney/myrepos/ee282/data/processed/myassembly.fa -t 32 ISO1_Hifi_AdaptorRem.40X.fasta.gz 


## Assembly Assessment

### Calculate the N50 (Script in code/scripts/findn50.sh)
```

```
N50: 21715751

### Compare assembly to contig assembly and scaffold assembly (Script in code/scripts/compassembly.sh)
Comparison Plot

### Calculate BUSCO scores of both assemblies

```
compleasm run -a /pub/gphinney/myrepos/ee282/data/processed/myassembly.fa -o /pub/gphinney/myrepos/ee282/data/processed/compleasm -l diptera -t 16
compleasm run -a /pub/gphinney/myrepos/ee282/data/raw/dmel-all-chromosome-r6.60.fasta.gz -o /pub/gphinney/myrepos/ee282/data/processed/flybasecompleasm -l diptera -t 16
```

###My Assembly Results
S:99.63%, 3273
D:0.24%, 8
F:0.00%, 0
I:0.00%, 0
M:0.12%, 4
N:3285


### Flybase Assembly Results
S:99.70%, 3275
D:0.30%, 10
I:0.00%, 0
M:0.00%, 0
N:3285


