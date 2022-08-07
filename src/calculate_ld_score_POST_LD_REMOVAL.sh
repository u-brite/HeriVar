#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=LDSC_POST_HLD_REM_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=apampana@uabmc.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LD_SCORES/POST_HIGH_LD_REMOVAL/logs/ld_score_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LD_SCORES/POST_HIGH_LD_REMOVAL/logs/err_ld_score_%J_%j.log

#module load PLINK

source /home/apampana/.bashrc
conda activate ldsc

n=$SLURM_ARRAY_TASK_ID
readarray lines < /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/input_for_pruning_v1.tsv  #### Zero indexed so array job starts with 0
line=${lines[$n]}
chr=$(echo "${line}" | awk -F '\t' '{print $1}')
rsq=$(echo "${line}" | awk -F '\t' '{print $3}')
window=$(echo "${line}" | awk -F '\t' '{print $2}')


echo "${chr}"
echo "${rsq}"
echo "${window}"


python /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Tools/ldsc/ldsc.py --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/POST_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}  --l2 --ld-wind-kb ${window} --out /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LD_SCORES/POST_HIGH_LD_REMOVAL/scores/chr${chr}_${rsq}_${window}

