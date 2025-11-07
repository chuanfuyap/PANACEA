#!/bin/bash

set -e
# Activate your hail/python environment if needed
# source /path/to/your/env/bin/activate

# EDIT THIS TO THE CORRESPONDING PATHS
CHR=20 # chromosome number being processed, this is needed for Leave one chromosome out (LOCO)
NUM_CORES=8 # number of core/threads to parallelise with, check how much compute you have to adjust accordingly. 
CHUNKSIZE=225 # refers to data size to be loaded into parallel processing, default value recommended 
SUBCHUNKSIZE=4 # same as above 
PHENO="" # the phenotype data being tested 
COVAR="" # the covaraites to include, e.g. sex, age NOTE: please still include the 20 reference AGVs in this file. 
RAWFILE="" # the .raw file generate from PLINK ( `--export include-alt A` option, )
VARIANT_FILE="" # the list of variants that are being tested, one row per variant (please take this from the .raw file, it should look like this rs2036465_C(/A) )
LOCO="" # the LOCO output from regenie's step 1
OUTPUT=""
model_type="logistic" # logistic for binary phenotype, linear for quantitative phenotype

python ./regintest.py \
  --pheno-path $PHENO \
  --covar-path $COVAR \
  --rawfile-path $RAWFILE \
  --variant-list-path $VARIANT_FILE \
  --loco-path $LOCO \
  --output-path $OUTPUT \
  --model-type $model_type \
  --chr $CHR \
  --num-cores $NUM_CORES \
  --chunksize $CHUNKSIZE \
  --subchunksize $SUBCHUNKSIZE
