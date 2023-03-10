Chris Lab ChIPseq data processing pipeline
================
Lakhansing Pardeshi, Chris Lab

<!--
library(rmarkdown)
setwd("E:/Chris_UM/Analysis/19_ChIPMix_process/documentation")
rmarkdown::render(input = "CL_ChIPseq_pipeline.rmd", output_format = "pdf_document")
rmarkdown::render(input = "CL_ChIPseq_pipeline.rmd", output_format = "word_document")
-->

This document describes the ChIPseq processing for fungal ChIPseq
experiment data generated in our lab.

### Required tools or scripts

  - **bowtie2:** Aligning raw reads against reference genome
  - **samtools:** Processing of alignment file
  - **macs2:** Peak calling
  - **bedSort:** Processing BedGraph files (Kent Utils)
  - **bedGraphToBigWig:** Processing BedGraph files (Kent Utils)
  - **zqWinSGR-v2.pl:** Script to calculate normalized gene wise signal
    from ChIPseq data

## Below are the data processing code blocks with description for each step.

### Required reference genome files

These files are required at different data processing steps below.

``` bash
## bowtie2 index for the reference genome
bowtie2_index="/path/to/bowtie2/index/prefix/"

## a tabular file with chromosome name and its length
file_chrSize="/path/to/chromosome_size/file/genome.size"

## a BED file with gene coordinates
file_gene_bed="/path/to/gene/position/bed/file/genes.bed"
```

### Alignment of reads against reference genome

Align the raw data against reference genome using `bowtie2`. As an
example, **ChIPseq\_sample1** is used in all the commands below.

``` bash
bowtie2 -p 2  --trim5 8 --local  -x <BOWTIE2_INDEX_PREFIX> -U ChIPseq_sample1_R1.fastq.gz | samtools view -bS - | samtools sort  -O bam -o ChIPseq_sample1_bt2.bam
```

Index the BAM file using `samtools`.

``` bash
samtools index ChIPseq_sample1_bt2.bam
```

### Extend reads to 200bp length using `macs2 pileup`

When DNA is fragmented using sonicator, the fragment size is set between
300-500bp. After library preparation, the ends of the TF bound DNA are
sequenced. However, the real TF binding site is at the center of the DNA
fragment. Therefore, we extend the sequenced reads to 200bp in 5’-\>3’
direction. This is useful for the genome browser visualization using
tools like IGV or IGB. By extending reads, the peak summit gives more
accurate TF binding position.

Usually `MACS2` can estimate the `extsize` on its own by selecting
highly enriched regions from the ChIPseq BAM file. However, fungal TF
ChIPseq has total detected peaks in range of 1000-3000 as opposed to
human TF ChIPseq where number of peaks can be more than 100,000. This
small initial number of peaks in fungal ChIPseq data can cause (most of
the times) `MACS2` to fail in estimating the fragment size and `extsize`
parameter. Therefore, we use `extsize = 200` for our data. This is based
on our experience with sonicator and we use same sonicator for all our
ChIPseq sample fragmentation with exact same settings. This helps to
have uniform processed data across batches. We use same approach while
calling peaks using `MACS2` by using `--nomodel --extsize` arguments.

``` bash
macs2 pileup --extsize 200 -i ChIPseq_sample1_bt2.bam -o ChIPseq_sample1_pileup.bdg
```

### Normalize the read coverage to 1 million mapped reads

Extract mapping statistics using `samtools`

``` bash
samtools flagstat ChIPseq_sample1_bt2.bam > alignment.stats
mappedReads=`grep -P ' 0 mapped \(' alignment.stats | grep -P -o '^\d+'`
```

We scale the reads to 1 million reads for each sample. This allows to
compare ChIPseq samples from different batches as well as different TF
ChIPseq. Command below calculate the scaling factor

``` bash
scale=`perl -e "printf('%.3f', 1000000/$mappedReads)"`
```

Normalize the read coverage with scaling factor using `macs2 bdgopt`

``` bash
printf "Normalizing ChIPseq_sample1_pileup.bdg with factor %s\n" $scale
macs2 bdgopt -i ChIPseq_sample1_pileup.bdg -m multiply -p $scale -o temp_normalized.bdg
```

### Convert BedGraph file to BigWig format

Remove the first line of the new normalized bedgraph (\*.bdg) file

``` bash
sed -n '2,$p' temp_normalized.bdg > ChIPseq_sample1_normalized.bdg

rm temp_normalized.bdg
```

BigWig is an indexed binary file which is smaller in size. The smaller
indexed BigWig file allows simultaneous loading of multiple ChIPseq
tracks in genome visualization tool like `IGB` or `IGV`. tools used:
`bedSort` and `bedGraphToBigWig` from UCSC Kent Utils.

``` bash
bedSort ChIPseq_sample1_normalized.bdg ChIPseq_sample1_normalized.bdg
bedGraphToBigWig ChIPseq_sample1_normalized.bdg ${file_chrSize} ChIPseq_sample1_normalized.bw
```

### Gene wise FPKM calculation (*only for RNA polII ChIPseq data*)

Optionally binding signal intensity scores like FPKM can be calculated
over gene body. Usually this is performed for RNA Pol-II ChIPseq data.
This step uses `zqWinSGR-v2.pl` script written by Miao to calculate the
gene wise normalized scores from a BedGraph file.

``` bash
perl /path/to/script/zqWinSGR-v2.pl -feature_file ${file_gene_bed} -socre_file ChIPseq_sample1_normalized.bdg -chrom_column 1 -start_column 2 -end_column 3  -direction_column 6 -bin_count 1 -output_folder $PWD -outout_name ChIPseq_sample1_polii_expr.tab

## compress all BedGraph files as uncompressed files take a lot space
gzip *.bdg
```

### Genome browser screening

After following above steps for data processing, we load the BigWig
(\*.bw) files on the genome browser (`IGB` or `IGV`) for visual
exploration purpose. This visualization gives idea about overall binding
pattern of the TF, chromatin immunoprecipitation quality.

-----

   

*[back to ChIPseq page](../../01_chipseq.md)*         or          
*[back to main page](../../README.md)*
