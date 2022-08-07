<p align="center">
  <img src="https://github.com/u-brite/HeriVar/blob/e02bebbc88faed83f5558470dbe74d0073c493a6/Final_Logo.gif" alt="animated" width="500" height="500"
</p>

## HeriVar

Quantifying the combined heritability of a trait based on a multi-ethnic LD panel with equal distribution of samples among each ancestry group.


## Table of Contents
- [Background](#Background)
- [Data](#data)
- [Tools](#tools)
- [Process](#process)
     - [Dependencies](#dependencies)
     - [Installation](#installation)
     - [Steps to run ](#steps-to-run)
- [Results](#results) 
- [Team Members](#team-members)

## Background

Heritability of a trait is often identified and reported in an ancestry group stratified manner. This limits the ability to estimate and report the combined heritability in a multi-ethnic population. Although there are several methods demonstrated recently with robust ways of calculating heritability with or without individual-level datasets, these methods are limited to ancestry-specific groups. In this project, we are proposing a way to calculate combined heritability using a multi-ethnic reference linkage-disequilibrium (LD) panel with equal proportions of data. We will use current existing tools to simulate and calculate heritability and report it as a framework that can be implemented and explored further. This will lead to the development of a novel approach to estimating the heritability of particular traits in multi-ethnic populations. As a part of Team HeriVar, you will be contributing to the demonstration of methodology, calculation of heritability, and work as a team to promote the method.

With the increasing availability of multi-ethnic whole genome sequence datasets, there is a gaping absence of an approach to estimate the heritability of particular phenotypic trait that accounts for the multi-ethnic genetic architecture. This approach of calculating the combined multi-ethnic heritability has not been pursued previously. This project helps us understand the problems facing this issue in the field of genomics and helps in generating a framework using existing tools to calculate and assess the heritability of a trait in multi-ethnic populations.


## Data

- High Coverage 1000g dataset downloaded from http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/ 
- GWAS summary statisitcs for NTproBNP (In house) & BP downloaded from Pan-Ukbiobank analysis. (https://pan.ukbb.broadinstitute.org/phenotypes)


## Tools

- R. ( module load R )
- Python. ( module load Anaconda3 )
- PLINK (https://www.cog-genomics.org/plink/2.0/ or module load PLINK in Cheaha).
- LDAK/SUMHER (https://dougspeed.com/sumher/).
- LDSC (https://github.com/bulik/ldsc).
- LiftOver ( https://genome.ucsc.edu/cgi-bin/hgLiftOver )

## Process 

### Dependencies
  - LDSC requires Anaconda3 or Python-2.7 and subpackages like bitarray, nose, pybedtools, scipy, numpy, pandas, bioconda. (will be installed when generating environment).
  - SumHer uses Intel MKL Libraries as dependencies. ( module load imkl/2020.1.217-iimpi-2020a )
  
  

### Installation  
- LDSC ( Required to be installed by everyone in their home directory to use it )
  - Clone the github of ldsc (git clone https://github.com/bulik/ldsc.git) and cd into the folder
  - Module load Anaconda3 ( module load Anaconda3 ) 
  - Install dependencies using conda as suggested by github ( conda env create --file environment.yml )
  - Activate ldsc ( source activate ldsc )
  - Test installation by running python scripts shared  as path of repo ( ./ldsc.py -h )

  
- Sumher
  - Download the LDAK Linux executable file by requesting using name and email ( you will get an email from the developer with downloadables if you are a first time user )
  - Unzip the executable file and use it. ( /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Tools/ldak5.2.linux - It can be accessible by everyone)
  - It also have executable for MAC users. 
    Note: Please check Dependencies before installing the tools.

- LiftOver
  - Download the file from  https://genome.ucsc.edu/cgi-bin/hgLiftOver 
  - Download the chain file needed for conversion - we can download it from above link.
  - Run liftOver -h
  
  

<p align="center">
  <img src="https://github.com/u-brite/HeriVar/blob/c0f7bf138a00b7c887fd7504f24f0c40f445ded4/Work_Flow.png" alt="animated" width="1024" height="1024"/>
</p>

  - We will take multi-ethnic summary statistics generated for NTproBNP (inhouse gwas) and BP (from GWAS-Catalog).
  - The reference panel we want to generate is based on high coverage 1000g dataset of 2504 unrelated individuals (recently sequenced and can be downloadable from LDlinks). 
  - We will filter the samples from 1000g so that we get an equal number of individuals covering all ancestry groups (EUR, AFR, EAS, SAS, AMR).
  - After removing monomorphic variants ( variants with AF == 0 or AF == 1 ), we will generate multiple combinations of  variants based on clumping and tresholding parameters to get high quality variants ( LD r2 = 0.2, 0.4, 0.6, 0.8,  window size = 250kb, 500kb, 1mb, 10mb ).
  - Using these variants, We will generate LD scores ( based on LDSC ) and thinning files ( based on SumHer ).
  - Using the LD scores or thinning files, we will calculate H2 values and see if we could able to estimate combined heritability. 


## Results

- Datasets
  - We downloaded 1000g high coverage reference dataset from http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/. (cite this)
  - We then extracted individuals files and randomly chose 489 unrelated individuals among each ancestry group.
  - Rationale behind including sample individuals from multiple ancestry groups is by taking equal number of individuals, we can have equal ld pattern distribution among the individuals.
  - Admixed population were excluded from the analysis along with related individuals which to 1956 individuals.
  - We removed variants with less than 1% minor allele frequency and variants with more than 5% missing data.
    - Allele Frequency Distribution among each ancestry and overall.
    - [ Insert Plot Here ]
  
 - PCA Analysis
  - We used Plink to calculate principal compnents analysis to test whether we have equal distributions of samples per ancestry group.

      - insert pca plot here

- Prunning & Thresholding
   - After subsetting to sample of interest, we did prunning and thresholding based on different cutoffs.
   - Plink is used to generate the files needed.
   - We used R2 and window size parameters for analysis.
     - R-squared cutoff of 0.2, 0.4, 0.6, 0.8.
     - Window size of 250kb, 500kb, 1Mb, 10Mb.
    -  Insert differences plot for variants counts
    -  We had ran near 1000 jobs for generating this datasets in Cheaha.
    -  We decided to exclude High LD regions as recommended by the tools.
    -  We subsetted the datasets to two categories.
       - Pre HighLD regions removal.
       - Post Hight LD regions removal.

- Refernces panel generation
  - We used the two categories as mentioend above and used two tools to calculated reference LD panels.
  - We used ldsc to generate LD scores for all the categories we have.
  - For LDAK annotations, We used liftover to convert  blk annotations from grch37 to grch38 and working on generting tagging files
    - We had an issue generating LDAK annotations files and decided to pursue analysis after hackathon. 
  
 - Phenotypes Processing
   - We have also worked on processing phenotypes based as suggested by the tools.
  
- Heritability 
  - We tried to generate h2 values using LDAK & LDSC but couldnt able to complete because of last minute issues. 




## Team Members

- Akhil Pampana | pampana.akhil@gmail.com | apampana@uabmc.edu | Team Leader 
- Nick Sumpter | nicks95@uab.edu | Team Member 
- Yongyu (Frank) Qiang | frankqiang5040@gmail.com | Team Member 

