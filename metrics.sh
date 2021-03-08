#!/bin/bash
#
# Script for extraction of DTI and DKI metrics. Tested with SCT v4.1.0
#
# NB: add the flag "-x" after "!/bin/bash" for full verbose of commands.
# 
# Create results folder
if [ ! -d ${PATH_RESULTS} ]; then
  mkdir ${PATH_RESULTS}
fi

# dmri
# ==============================================================================
cd dki
# Concatenate left and right CSTs from PAM50 atlas
fslmaths label/atlas/PAM50_atlas_05.nii.gz -add label/atlas/PAM50_atlas_04.nii.gz label/atlas/cst.nii.gz
# Multiply segmentation dilated mask by specific atlas ROI -WM,GM & CSTs
sct_maths -i ${file_seg} -mul label/template/PAM50_gm.nii.gz  -o segm_gm.nii.gz
sct_maths -i ${file_seg} -mul label/template/PAM50_wm.nii.gz  -o segm_wm.nii.gz
sct_maths -i ${file_seg} -mul label/atlas/cst.nii.gz  -o segm_cst.nii.gz
# Extract mean DTI and DKI metrics along WM ang GM and CSTs in each level prescribed by METRICS_VERT_LEVEL
# tips: we specify vertebral levels C1-C4 because outside of these levels the registration is inaccurrate and/or MRI signal is corrupted
for metric in dki_FA dki_MD dki_AD dki_RD KFA MK AK RK ; do
  sct_extract_metric -i ${metric}.nii.gz -f segm_gm.nii.gz -vert ${METRICS_VERT_LEVEL} -vertfile label/template/PAM50_levels.nii.gz -o ${PATH_RESULTS}/${metric}_gm.csv 
  sct_extract_metric -i ${metric}.nii.gz -f segm_wm.nii.gz -vert ${METRICS_VERT_LEVEL} -vertfile label/template/PAM50_levels.nii.gz -o ${PATH_RESULTS}/${metric}_wm.csv 
  sct_extract_metric -i ${metric}.nii.gz  -f segm_cst.nii.gz -vert ${METRICS_VERT_LEVEL} -vertfile label/template/PAM50_levels.nii.gz -o ${PATH_RESULTS}/${metric}_cst.csv 
done
cd ..



 
