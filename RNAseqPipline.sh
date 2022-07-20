#!/bin/bash


#SBATCH -p short 		# partition name
#SBATCH -t 0-2:00 		# hours:minutes runlimit after which job will be killed
#SBATCH -c 6 		# number of cores requested -- this needs to be greater than or equal to the number of cores you plan to use to run your job
#SBATCH --mem 16G
#SBATCH --job-name STAR_index 		# Job name
#SBATCH -o %j.out			# File to which standard out will be written
#SBATCH -e %j.err 		# File to which standard err will be written



mkdir fastq

# STEP 1: Get fastq files from SRA

file=$1

cat $file | parallel "fastq-dump --outdir fastq/ --split-3 --gzip {}"

echo "Done Downloading fastq files"

# STEP 2: Perform Quality check

# STEP 3 Perform  trimming

for infile in fastq/*_1.fastq.gz
do
   base=$(basename ${infile} _1.fastq.gz)
   trimmomatic PE -threads 16 -phred33 -basein ${infile} ${base}_2.fastq.gz \
                -baseout ${base}_1.trim.fastq.gz ${base}_1un.trim.fastq.gz \
                ${base}_2.trim.fastq.gz ${base}_2un.trim.fastq.gz \
                SLIDINGWINDOW:4:30 MINLEN:25 ILLUMINACLIP:TruSeq3-PE.fa:2:40:15
done

mkdir trimmed



# STEP 4: Perform alignment 

mkdir chr1_hg38_index



STAR --runThreadN 16 \
--runMode genomeGenerate\
--genomeDir GRChg38_index \
--genomeFastaFiles Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa \
--sjdbGTFfile Homo_sapiens.GRCh38.107.gtf \





STAR --genomeDir / \
--runThreadN 16 \
--readFilesIn Mov10_oe_1.subset.fq \
--outFileNamePrefix ../results/STAR/Mov10_oe_1_ \
--outSAMtype BAM SortedByCoordinate \
--outSAMunmapped Within \
--outSAMattributes Standard
