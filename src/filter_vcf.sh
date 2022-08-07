#!/bin/bash
#SBATCH --ntasks=1
#SBATCH --mem-per-cpu=14096
#SBATCH --partition=medium
#SBATCH --job-name=FILT_SAMP_1000g_HH_2022
#SBATCH --time=48:00:00
#SBATCH --mail-type=FAIL
#SBATCH --mail-user=apampana@uabmc.edu
#SBATCH --output=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/out_%J_%j.log
#SBATCH --error=/data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/err_%J_%j.log


module load BCFtools/1.3.1-goolf-1.7.20
module load tabix/0.2.6-goolf-1.7.20



bcftools view -i 'FILTER="PASS"' -S /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Phenotypes/Samples_to_input.tsv --force-sample /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Dataset/CCDG_14151_B01_GRM_WGS_2020-08-05_chr$SLURM_ARRAY_TASK_ID.filtered.shapeit2-duohmm-phased.vcf.gz  -Ov | bgzip -c > /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/chr$SLURM_ARRAY_TASK_ID.pass_only.vcf.gz

tabix -pvcf /data/project/ubrite/hackathon2022/staging_area_teams/HeriVar/Results/chr$SLURM_ARRAY_TASK_ID.pass_only.vcf.gz
