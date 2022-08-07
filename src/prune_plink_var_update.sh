#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=PRUNE_SUBJECT_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=apampana@uabmc.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/prune_subset_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/prune_subset_%J_%j.log

module load PLINK

n=$SLURM_ARRAY_TASK_ID
readarray lines < /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/input_for_pruning_v1.tsv  #### Zero indexed so array job starts with 0
line=${lines[$n]}
chr=$(echo "${line}" | awk -F '\t' '{print $1}')
rsq=$(echo "${line}" | awk -F '\t' '{print $3}')
window=$(echo "${line}" | awk -F '\t' '{print $2}')


echo "${chr}"
echo "${rsq}"
echo "${window}"


#plink2 --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/PRE_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}  \
#    	--set-all-var-ids @:# \
#	    --make-bed \
#	    --out /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/PRE_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}




plink2 --bfile /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/POST_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}  \
    	--set-all-var-ids @:# \
	    --make-bed \
	    --out /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PRUNE_SUBSET/POST_HIGH_LD_REMOVAL/plink/chr${chr}_${rsq}_${window}






