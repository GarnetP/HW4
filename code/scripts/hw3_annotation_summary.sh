# Script for annotation summary
# Verify file integrity
echo "File integrity check:"
cd ~/myrepos/ee282/data/
wget http://ftp.flybase.net/releases/FB2022_05/dmel_r6.48/gtf/md5sum.txt -O md5sumanno.txt
md5sum -c --ignore-missing md5sumanno.txt


# Total number of features of each type, sorted from most common to least common
echo "Number of features of each type:"
bioawk -c gff '{print $3}' dmel-all-r6.48.gtf.gz | sort | uniq -c | sort -rn
# Total number of genes per chromosome arm (X,Y, 2L, 2R, 3L, 3R, 4)
echo "Number of genes per chromosome arm:"
bioawk -c gff '$3 == "gene" {print $1}' dmel-all-r6.48.gtf.gz | grep -e "X" -e "Y" -e "2L" -e "2R" -e "3L" -e "3R" -e "\<4\>" | sort | uniq -c | sort -rn

