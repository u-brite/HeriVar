#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=liftover2
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=nicks95@uab.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/liftover2_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/liftover2_%J_%j.log

FILE_PATH=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar

#unzip $FILE_PATH/Results/LDAK/bld.zip # run this once to refresh the bld files

cat $FILE_PATH/Results/LDAK/bld$SLURM_ARRAY_TASK_ID | cut -d ' ' -f 1 | awk '{print "chr"$1,$2-1,$2,"line"NR}' FS=':' OFS='\t' > $FILE_PATH/Results/LDAK/bld$SLURM_ARRAY_TASK_ID.bed

$FILE_PATH/Tools/liftOver $FILE_PATH/Results/LDAK/bld$SLURM_ARRAY_TASK_ID.bed $FILE_PATH/Tools/hg19ToHg38.over.chain $FILE_PATH/Results/LDAK/lifted_bld$SLURM_ARRAY_TASK_ID.bed $FILE_PATH/Results/LDAK/unlifted_bld$SLURM_ARRAY_TASK_ID.bed

cat $FILE_PATH/Results/LDAK/bld$SLURM_ARRAY_TASK_ID | awk '{print "line"NR,$0}' OFS='-' > $FILE_PATH/Results/LDAK/modified_bld$SLURM_ARRAY_TASK_ID

cat $FILE_PATH/Results/LDAK/lifted_bld$SLURM_ARRAY_TASK_ID.bed | sed 's/chr//g' | awk '{print $4,$1":"$3}' OFS='-' > $FILE_PATH/Results/LDAK/modified_lifted_bld$SLURM_ARRAY_TASK_ID 

join -1 1 -2 1 -t - -o 2.2,1.2 $FILE_PATH/Results/LDAK/modified_bld$SLURM_ARRAY_TASK_ID $FILE_PATH/Results/LDAK/modified_lifted_bld$SLURM_ARRAY_TASK_ID | sed -E 's/-\S+//g' | sort | uniq > $FILE_PATH/Results/LDAK/bld$SLURM_ARRAY_TASK_ID 
