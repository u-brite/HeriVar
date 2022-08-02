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
     - [Activate conda environment](#activate-conda-environment) 
     - [Steps to run ](#steps-to-run)
- [Results](#results) 
- [Team Members](#team-members)

## Background

Heritability of a trait is often identified and reported in an ancestry group stratified manner. This limits the ability to estimate and report the combined heritability in a multi-ethnic population. Although there are several methods demonstrated recently with robust ways of calculating heritability with or without individual-level datasets, these methods are limited to ancestry-specific groups. In this project, we are proposing a way to calculate combined heritability using a multi-ethnic reference linkage-disequilibrium (LD) panel with equal proportions of data. We will use current existing tools to simulate and calculate heritability and report it as a framework that can be implemented and explored further. This will lead to the development of a novel approach to estimating the heritability of particular traits in multi-ethnic populations. As a part of Team HeriVar, you will be contributing to the demonstration of methodology, calculation of heritability, and work as a team to promote the method.

With the increasing availability of multi-ethnic whole genome sequence datasets, there is a gaping absence of an approach to estimate the heritability of particular phenotypic trait that accounts for the multi-ethnic genetic architecture. This approach of calculating the combined multi-ethnic heritability has not been pursued previously. This project helps us understand the problems facing this issue in the field of genomics and helps in generating a framework using existing tools to calculate and assess the heritability of a trait in multi-ethnic populations.


## Data

- High Coverage 1000g dataset downloaded from http://ftp.1000genomes.ebi.ac.uk/vol1/ftp/data_collections/1000G_2504_high_coverage/working/20201028_3202_phased/ 
- Gwas summary statisitcs for NTproBNP (In house) & BP downloaded from GWAS-Catalog


## Tools

- R. ( module load R )
- Python. ( module load Anaconda3 )
- PLINK(https://www.cog-genomics.org/plink/2.0/ or module load PLINK in Cheaha).
- SUMHER(https://dougspeed.com/sumher/).
- LDSC(https://github.com/bulik/ldsc).

## Process

### Dependencies
  - LDSC requires Anaconda3 or Python-2.7 and subpackages like bitarray, nose, pybedtools, scipy, numpy, pandas, bioconda.
  - Sumher uses Intel MKL Libraries as dependencies.
  

### Installation  
- LDSC
  - Clone the github of ldsc (git clone https://github.com/bulik/ldsc.git)
  - Module load Anaconda 
  - Install dependencies using conda as suggested by github( conda env create --file environment.yml )
  - Activate ldsc (  source activate ldsc )
  - Test installation by running python scripts shared  as path of repo ( ./ldsc.py -h )

  
- Sumher
  - Download the LDAK Linux executable file by requesting using name and email ( you will get an email from the developer with downloadables if you are a first time   user )
  - Unzip the executable file and use it.
  - It also have executable for MAC users.
  

### Steps to run

<p align="center">
  <img src="https://github.com/u-brite/HeriVar/blob/29f1bade13514fe8d08ad4302198a6b55fa33aba/Workflow.png" alt="animated" width="1024" height="1024"/>
</p>

  - We will take multi-ethnic summary statistics generated for NTproBNP (inhouse gwas) and BP (from GWAS-Catalog).
  - The reference panel we want to generate is based on high coverage 1000g dataset of 2504 unrelated individuals (recently sequenced and can be downloadable from LDlinks). 
  - We will filter the samples from 1000g so that we get an equal number of individuals covering all ancestry groups (EUR, AFR, EAS, SAS, AMR).
  - After removing monomorphic variants ( variants with AF == 0 or AF == 1 ), we will generate multiple combinations of  variants based on clumping and tresholding parameters to get high quality variants ( LD r2 = 0.2, 0.4, 0.6, 0.8,  window length = 250kb, 500kb, 1mb, 10mb ).
  - Using these variants, We will generate LD scores ( based on LDSC ) and thinning files ( based on SumHer ).
  - Using the LD scores or thinning files, we will calculate H2 values and see if we could able to estimate combined heritability. 


## Results

Heritability of a trait in multi-ethnic population is reported along with some other plots.  
- TBA

## Team Members

Akhil Pampana | pampana.akhil@gmail.com | apampana@uabmc.edu | Team Leader  

