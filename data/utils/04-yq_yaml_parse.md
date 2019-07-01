# Easily access reference genome data from YAML config file using yq

Genomics data processing involves various form of reference data. Even for a single species, reference data can be FASTA file, index prefix for aligners like BWA, Bowtie2, STAR, Hisat2 etc, BED files, GFF/GTF files and so on. Writing complete path of these files can be annoying at times and can get challenging if one works with multiple organisms.

To avoid such inconvenience, a reference data can be stored in a YAML configuration file which can be easily accessed using command line utilities. [yq](https://github.com/mikefarah/yq) is one such command line YAML processor utility. 

Below is an example YAML file for human and yeast reference data.
```yaml
## Human GRCh38p12 from Gencode.v30
H_sapiens:
  fasta: ~/references/GRCh38p12.gencode30/fasta/GRCh38.primary_assembly.genome.chr.fa
  gff: ~/references/GRCh38p12.gencode30/annotation/GRCh38p12.gencode.v30.annotation.sorted.gff3
  bowtie2: ~/references/GRCh38p12.gencode30/bowtie2_index/GRCh38.primary_assembly.genome.chr.fa
  hisat2: ~/references/GRCh38p12.gencode30/hisat2_index/GRCh38.primary_assembly.genome.chr.fa
## Yeast from SGD
S_cerevisiae:
  fasta: ~/references/S_cerevisiae/fasta/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa
  gff: ~/references/S_cerevisiae/annotation/Saccharomyces_cerevisiae.R64-1-1.43.gff3
  bwa: ~/references/S_cerevisiae/bwa_index/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa
  bowtie2: ~/references/S_cerevisiae/bowtie2_index/Saccharomyces_cerevisiae.R64-1-1.dna_sm.toplevel.fa
  
```

This file can be parsed using `yq` as following examples.

```bash
## get reference genome fastq file for human
yq r reference_genomes.yml H_sapiens.fasta

## get GFF file for yeast
yq r reference_genomes.yml S_cerevisiae.gff

## get bowtie2 index for yeast and store in a variable
bt2_idx=$(yq r reference_genomes.yml S_cerevisiae.bowtie2)
```

Please refer to the `yq` [documentation](http://mikefarah.github.io/yq/) for more advanced usage.

<br><br>
___
*[back to Utils page](../../00_utils.md)* &nbsp; &nbsp; &nbsp; &nbsp; or &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; *[back to main page](../../README.md)*
