#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=LDAK_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=nicks95@uab.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/out_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/err_%J_%j.log

#n=$SLURM_ARRAY_TASK_ID
#readarray lines < /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/input_for_pruning_v1.tsv  #### Zero indexed so array job starts with 0
#line=${lines[$n]}
#chr=$(echo "${line}" | awk -F '\t' '{print $1}')
#rsq=$(echo "${line}" | awk -F '\t' '{print $3}')
#window=$(echo "${line}" | awk -F '\t' '{print $2}')

chr=22
rsq=0.2
window=250

/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Tools/LDAK/ldak5.2.linux --cut-weights /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/sections${chr}_${rsq}_${window} --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/PRE_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}

/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Tools/LDAK/ldak5.2.linux --calc-weights-all /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/sections${chr}_${rsq}_${window} --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/PRE_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}

mv /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/sections${chr}_${rsq}_${window}/weights.short /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/bld65

/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Tools/LDAK/ldak5.2.linux --calc-tagging BLD-LDAK --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/PRE_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window} --ignore-weights YES --power -0.25 --window-kb ${window} --annotation-number 65 --annotation-prefix /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/LDAK/bld --allow-multi YES
