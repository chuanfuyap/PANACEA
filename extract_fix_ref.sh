#!/bin/bash

## extract intersect between query genotype with reference pruned genotype and update reference allele

# EDIT THIS TO THE CORRESPONDING PATHS
PLINK="${LOCATION TO PLINK}" # this refers PLINK software path
DATA="${PLINK FILE LOCATION}" # your imputed PLINK binary file path
VARIANTS="./extract_gnomad_overlap.txt" # if you moved the file to a different location please update this, this is included in the github repo
OUTPUT="${OUTPUT DIRECTORY LOCATION AND NAME}" 
REFERENCE="./gnomad_ref_allele.txt" # if you moved the file to a different location please update this, this is included in the github repo

$PLINK \
  --bfile $DATA \
  --extract $VARIANTS \
  --alt1-allele $REFERENCE 1 2 \
  --make-bed \
  --threads ${OPTIONAL THREADS} \
  --out $OUTPUT