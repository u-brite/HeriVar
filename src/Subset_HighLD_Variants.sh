#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=HIGHLD_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=apampana@uabmc.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/highld_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/highld_%J_%j.log

module load PLINK


n=$SLURM_ARRAY_TASK_ID
readarray lines < /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/HighLD_v2.txt  #### Zero indexed so array job starts with 0
line=${lines[$n]}
chr=$(echo "${line}" | awk -F '\t' '{print $1}')
stop=$(echo "${line}" | awk -F '\t' '{print $3}')
start=$(echo "${line}" | awk -F '\t' '{print $2}')
region=$(echo "${line}" | awk -F '\t' '{print $4}')

echo "${chr}"
echo "${start}"
echo "${stop}"


plink2 --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/${chr}.pass_only_filtered  \
	--chr ${chr} --from-bp ${start} --to-bp ${stop} \
	--write-snplist \
	--out /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/${chr}_highld_${region}

