#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=liftover
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=nicks95@uab.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/liftover_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/liftover_%J_%j.log

FILE_PATH=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar

cat $FILE_PATH/Phenotypes/urate_chr1_22_LQ_IQ06_mac10_all_741_nstud37_summac400_rsid.txt | tail -n +2 | awk '{print "chr"$1,$2-1,$2,$3}' OFS='\t' > $FILE_PATH/Phenotypes/urate_pos.bed

$FILE_PATH/Tools/liftOver $FILE_PATH/Phenotypes/urate_pos.bed $FILE_PATH/Tools/hg19ToHg38.over.chain $FILE_PATH/Phenotypes/lifted_urate.bed $FILE_PATH/Phenotypes/unlifted.bed

cat <(head -1 $FILE_PATH/Phenotypes/urate_chr1_22_LQ_IQ06_mac10_all_741_nstud37_summac400_rsid.txt) <(join -1 3 -2 4 -o 1.1,2.3,1.3,1.4,1.5,1.6,1.7,1.8,1.9,1.10 $FILE_PATH/Phenotypes/urate_chr1_22_LQ_IQ06_mac10_all_741_nstud37_summac400_rsid.txt $FILE_PATH/Phenotypes/lifted_urate.bed) > $FILE_PATH/Phenotypes/lifted_urate_sumstat.txt
