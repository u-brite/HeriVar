#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=PLINK_CONVERSION_1000g_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=apampana@uabmc.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/out_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/err_%J_%j.log


module load PLINK/2.00-alpha3-x86_64

plink2 --vcf /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/VCFS_subset/chr$SLURM_ARRAY_TASK_ID.pass_only.vcf.gz --make-bed --geno 0.05 --maf 0.01 --out /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/PLINK_files/chr$SLURM_ARRAY_TASK_ID.pass_only_filtered
