# Script for genome summary

# Verify file integrity 
echo "File integrity check:"
cd ~/myrepos/ee282/data/
wget http://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/md5sum.txt -O md5sumanno.txt
md5sum -c --ignore-missing md5sumanno.txt


# Process the fasta file 
echo "Genome summary:"
module load ucsc-tools/v429
faSize -tab dmel-all-chromosome-r6.48.fasta.gz | grep -e "baseCount" -e "nBaseCount" -e "seqCount"
