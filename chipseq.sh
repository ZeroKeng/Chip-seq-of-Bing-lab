#!/bin/bash

fq1=$1
fq2=$2
name=$3

bowtie2 -p 16 -x /home/zilong/Ref/bowtie2_index/hg38 -1 $fq1 -2 $fq2 -S ${name}.sam

samtools sort -o ${name}_sort.bam ${name}.sam

samtools index ${name}_sort.bam

samtools rmdup -S ${name}_sort.bam ${name}_rmdup.bam 

samtools sort -o ${name}_rmdup_sort.bam ${name}_rmdup.bam

samtools index ${name}_rmdup_sort.bam

igvtools count -z 5 -w 25 -e 150 ${name}_rmdup_sort.bam ${name}.tdf hg38

exit 0