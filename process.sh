#!/bin/bash
#
# Script for kurtosis processing on neonatal data. Tested with SCT v4.1.0
#
# Author: Julien Cohen-Adad, Rosella Trò

# Build color coding (cosmetic stuff)
Color_Off='\033[0m'
Green='\033[0;92m'
Red='\033[0;91m'
On_Black='\033[40m'

# dmri
# ==============================================================================
cd dki
# Crop image, assuming the cord is roughtly centered in the FOV, and knowing that slices below a certain slice are not usable due to poor image quality
sct_crop_image -i kurtosis_patch2self.nii.gz -xmin $X_min -xmax $X_max -ymin $Y_min -ymax $Y_max -zmin $Z_min -zmax $Z_max -o kurtosis_patch2self_crop.nii.gz
# sct_crop_image -i kurtosis_patch2self.nii.gz -g 1 # alternative algorithm if cropping boundaries change across subjects --> GUI
# Motion correction
sct_dmri_moco -i kurtosis_patch2self_crop.nii.gz -bvec bvecs -bval bvals -x spline
# Cord segmentation
# Check if manual segmentation already exists
if [ -e "kurtosis_patch2self_crop_moco_dwi_mean_seg-manual.nii.gz" ]; then
  file_seg="kurtosis_patch2self_crop_moco_dwi_mean_seg-manual.nii.gz"
else
  # Segment cord
  sct_deepseg_sc -i kurtosis_patch2self_crop_moco_dwi_mean.nii.gz -c dwi -qc qc
  file_seg="kurtosis_patch2self_crop_moco_dwi_mean_seg.nii.gz"
  # Check segmentation results and do manual corrections if necessary
  fsleyes kurtosis_patch2self_crop.nii.gz -cm greyscale kurtosis_patch2self_crop_moco_dwi_mean_seg.nii.gz -cm red -a 70.0 &
  printf "${Green}${On_Black}\nFSLeyes will now open. Check the segmentation. If necessary, manually adjust the segmentation and then save it as: kurtosis_patch2self_crop_moco_dwi_mean_seg-manual.nii.gz. Close FSLeyes when you're finished, go back to the Terminal and press any key to continue...${Color_Off}"
  read -p ""
  # check if segmentation was modified
  if [ -e "kurtosis_patch2self_crop_moco_dwi_mean_seg-manual.nii.gz" ]; then
  	file_seg="kurtosis_patch2self_crop_moco_dwi_mean_seg-manual.nii.gz"
  fi
fi
# Create labels at the top of C1 vertebrae (value:1) and at C3-C4 disc (value:4), centered in the cord
sct_label_utils -i 3dT1.nii.gz -create-viewer 1,4 -msg "Create label at the posterior tip of the top of C1 vertebra and at C3-C4 disc" -o labels_disc1-4.nii.gz
# Register the PAM50 template to the DWI data.
sct_register_to_template -i kurtosis_patch2self_crop_moco_dwi_mean.nii.gz -s ${file_seg} -ldisc labels_disc1-4.nii.gz -c t1 -ref subject -param step=1,type=seg,algo=centermass:step=2,type=seg,algo=columnwise:step=3,type=im,algo=bsplinesyn,metric=CC,slicewise=1,iter=3 -qc ${PATH_QC}
# Rename warping fields for clarity
mv warp_template2anat.nii.gz warp_template2dwi.nii.gz
mv warp_anat2template.nii.gz warp_dwi2template.nii.gz
# Warp PAM50 to DWI data
sct_warp_template -d kurtosis_patch2self_crop_moco_dwi_mean.nii.gz -w warp_template2dwi.nii.gz -qc qc
# Compute DTI and DKI measures using dipy v.1.1.1
# tips: you should not use "-m kurtosis_patch2self_crop_moco_dwi_mean_seg.nii.gz" because values outside the binary cord mask are important for proper account of partial volume effect. More info at [Levy et al. Neuroimage 2015]. Instead, we dilate the cord seg and use it as a mask.
sct_maths -i ${file_seg} -dilate 3 -o kurtosis_patch2self_crop_moco_dwi_mean_seg_dil.nii.gz
python dipy_spine.py
# Go back to parent folder
cd ..
