#!/bin/python

import subprocess

# samples 
sra_numbers = [
    "SRR20074385", "SRR20074380", "SRR20074386", "SRR20074384", "SRR20074389", "SRR20074381", "SRR20074387", "SRR20074378",
    "SRR20074383", "SRR20074379", "SRR20074382", "SRR20074388"
    ]

# this will download the .sra files to ~/ncbi/public/sra/ 
for sra_id in sra_numbers:
    print ("Currently downloading: " + sra_id)
    prefetch = "prefetch " + sra_id
    print ("The command used was: " + prefetch)
    subprocess.call(prefetch, shell=True)

# this will extract the .sra files from above into a folder named 'fastq'
for sra_id in sra_numbers:
    print ("Generating fastq for: " + sra_id)
    fastq_dump = "fastq-dump --outdir fastq --gzip --skip-technical  --readids --read-filter pass --dumpbase --split-3 --clip ~/ncbi/public/sra/" + sra_id + ".sra"
    print ("The command used was: " + fastq_dump)
    subprocess.call(fastq_dump, shell=True)
