#!/bin/bash

set -xe

python3 create_mergelist.py

plink2 --pmerge-list mergelist.txt bfile --pmerge-list-dir ../Results/PLINK_files --out ../Results/PCA/PLINK_merged_all

plink2 --pfile ../Results/PCA/PLINK_merged_all \
       --freq counts \
       --pca allele-wts \
       --out ../Results/PCA/pcs/pc_results

