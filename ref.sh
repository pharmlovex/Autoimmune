#!/bin/bash 


### Bash scripts for generating ref genome 

STAR --runMode genomeGenerate --genomeDir ref/ --genomeFastaFiles genome/Homo_sapiens.GRCh38.dna_sm.primary_assembly.fa --sjdbGTFfile genome/Homo_sapiens.GRCh38.107.gtf --runThreadN 6
