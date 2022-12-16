# HPC setup for genomics data analysis
I use conda for managing the tools on HPC platform. I have two main environments, with *Python 2.7* and *Python 3.7*

## Terminal prompt theme setup

[Oh My Posh](https://ohmyposh.dev/) has beautiful and informative themes for the bash, zsh, powershell terminal prompts. Additionally, to enable faster `git` prompt in interactive shell, use [gitstatus](https://github.com/romkatv/gitstatus). `gitstatus` is 10x faster than `git status` and `git describe`.

Install `gitstatus` as follows:

```
git clone --depth=1 https://github.com/romkatv/gitstatus.git $TOOLS_DIR/gitstatus
echo '## gitstatus for faster "git status"
source $TOOLS_DIR/gitstatus/gitstatus.prompt.sh' >> ~/.profile
```

Install oh-my-posh by direct downloading of based on the OS

```bash

if [ $(uname -s) == "Darwin" ]; then
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/download/v12.26.6/posh-darwin-arm64 -O $TOOLS_DIR/oh-my-posh/oh-my-posh
elif [ $(uname -s) == "Linux" ]; then
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O $TOOLS_DIR/oh-my-posh/oh-my-posh
fi

chmod +x $TOOLS_DIR/oh-my-posh/oh-my-posh

echo 'PATH=$PATH:$TOOLS_DIR/oh-my-posh'  >> ~/.profile

```

Optionally, download poshthemes as described on [Oh My Posh](https://ohmyposh.dev/) website.

```bash
mkdir ~/.poshthemes
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
chmod u+rw ~/.poshthemes/*.omp.*
rm ~/.poshthemes/themes.zip
```

Finally, configure the shell to use oh-my-posh theme as follows:

```bash
echo '## configuring bash prompt theme
eval "$(oh-my-posh init bash --config $CODE_DIR/bioinformatics_notes/data/bash_themes/my_gruvbox.omp.json)"' >> ~/.profile
```

Alternative themes can be used from `~/.poshthemes` folder. However, many themes require [Nerd fonts](https://github.com/ryanoasis/nerd-fonts) that non-root user may not able to install.

## conda setup with python 2.7
```bash
conda create --name omics_py27 python=2.7
conda install -c bioconda -y htslib=1.10.2  samtools=1.10 bcftools=1.10.1
conda install -c bioconda -y bedtools=2.29 deeptools=3.2
```

## conda setup with python 3.*
```bash
conda create -n omics_py37 python=3.7
conda deactivate
conda activate omics_py37
conda install -c bioconda -y htslib=1.10.2  samtools=1.10 bcftools=1.10.1
conda install -c bioconda -y bowtie2=2.3.5.1 bwa=0.7.17  hisat2=2.2.0 stringtie=2.1.2
conda install -c bioconda -y bedtools=2.29.2 deeptools=3.4.3
conda install -c bioconda -y ucsc-bedsort ucsc-bedtobigbed ucsc-bedtopsl ucsc-bedgraphtobigwig
conda install -c bioconda -y macs2=2.2.7.1
```

## MEME suite installation steps
I tried to install *meme-5.1.1* using conda. conda installation of MEME is not successful and gives error. Therefore install locally using `python 3.7` conda environment

###### Install *MEME* dependencies
```bash
conda deactivate
conda activate omics_py37
conda install -c conda-forge ghostscript zlib
conda install perl-cgi perl-file-which perl-html-parser perl-html-template perl-html-tree perl-json perl-log-log4perl perl-math-cdf perl-xml-parser perl-xml-simple perl-yaml
```

No need to install `openmpi`, `openmpi-mpicc`, `libxml2` and `libxslt`. Use MPI from available modules. `openmpi` and `libxml2` from conda is causing problems for *fimo*, *dreme* and other programs of *MEME* suite
```bash
./configure --prefix=$HOME/tools/meme-5.1.1_py37 --with-db=/home/lakhanp/tools/meme_database/motif_databases --enable-build-libxml2 --enable-build-libxslt
make
make test
make install
```

Finally, add the MEME paths to `PATH` variable in *~/.bashrc* file
```bash
printf "\nPATH=\$PATH:$HOME/tools/meme-5.1.1_py37/bin:$HOME/tools/meme-5.1.1_py37/libexec/meme-5.1.1\n\n" >> ~/.bashrc
```

<br><br>
___
*[back to main page](README.md)*