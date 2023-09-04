#!/bin/bash
#SBATCH -n 30           # 1 core
#SBATCH -t 0-10:00:00   # 10 hours
#SBATCH -J sirius # sensible name for the job
#SBATCH --output=logs/sirius_%j.log   # Standard output and error log
#SBATCH -p sched_mit_ccoley
#SBATCH --mem-per-cpu=20G # 10 gb
#SBATCH -w node1237

##SBATCH -w node1238
##SBATCH --gres=gpu:1 #1 gpu
##SBATCH --mem=20000  # 20 gb 
##SBATCH -p {Partition Name} # Partition with GPUs

# Import module
#source /etc/profile 
#source /home/samlg/.bashrc

SIRIUS=sirius5/sirius/bin/sirius
SIRIUS4=sirius/bin/sirius
CORES=32

# Assumes we know the correct chemical formula
echo "Processing mills" 

#sirius_processing/sirius/bin/sirius --cores 30 --output data/paired_spectra/broad/sirius_outputs/ --naming-convention %filename --input data/paired_spectra/broad/spec_files/ formula --ppm-max-ms2 30

#sirius --cores 4 --output data/paired_spectra/broad/sirius_outputs/ --naming-convention %filename --input data/paired_spectra/broad/spec_files/ formula --ppm-max-ms2 30
outfolder=results/2023_05_08_sirius_check

mkdir $outfolder
outfolder_4=results/2023_05_08_sirius_check/sirius4_30_ppm_out
outfolder_5=results/2023_05_08_sirius_check/sirius5_out
outfolder_5s=results/2023_05_08_sirius_check/sirius5s_out

outfolder_4_summary=results/2023_05_08_sirius_check/sirius4_out_summary
outfolder_5_summary=results/2023_05_08_sirius_check/sirius5_out_summary
outfolder_5s_summary=results/2023_05_08_sirius_check/sirius5s_out_summary

mkdir $outfolder_4
mkdir $outfolder_5
mkdir $outfolder_5s

mkdir $outfolder_4_summary
mkdir $outfolder_5_summary
mkdir $outfolder_5s_summary

password=$SIRIUS_PW

#INPUT_FILE=data/raw/mills/Mills_mzxml/mgf_export_sirius.mgf
INPUT_FILE=data/raw/mills/Mills_mzxml/mgf_export_sirius_filtered_500.mgf
SIRIUS=sirius5/sirius/bin/sirius

# Ignore formula
#--naming-convention %filename \

$SIRIUS login -u samlg@mit.edu -p
echo $outfolder_5s
$SIRIUS  \
    --cores $CORES \
    --output  $outfolder_5s  \
    --input $INPUT_FILE \
    formula  \
    --ppm-max-ms2 10  \
    fingerprint \
    structure \
    write-summaries \
    --output $outfolder_5s_summary \


#$SIRIUS login -u samlg@mit.edu -p
#$SIRIUS  \
#    --cores $CORES \
#    --output  $outfolder_5  \
#    --input $INPUT_FILE \
#    formula  \
#    --ppm-max-ms2 10  \
#    write-summaries \
#    --output $outfolder_5_summary \

#$SIRIUS login -u samlg@mit.edu -p
#$SIRIUS4  \
#    --cores $CORES \
#    --output  $outfolder_4  \
#    --input $INPUT_FILE \
#    formula  \
#    --ppm-max-ms2 30  \
    #write-summaries \
    #--output $outfolder_5_summary \