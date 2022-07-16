#!/bin/bash

## Unzip the fastq file




for file in fastq/*.fastq; 
do 
 STAR --runMode alignReads --genomeDir ref/ --outSAMtype BAM SortedByCoordinate --readFilesIn ${file} --runThreadN 16 --outFileNamePrefix mapped/${file};
done

