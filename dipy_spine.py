#
# Script for computing DTI and DKI measures. Tested on dipy v.1.4.1
#
# Author: Rosella Trò

# import all relevant modules
import os, sys
import numpy as np
import matplotlib.pyplot as plt
import dipy.reconst.dki as dki
import dipy.reconst.dti as dti
from dipy.core.gradients import gradient_table
from dipy.io.gradients import read_bvals_bvecs
from dipy.io.image import load_nifti
from scipy.ndimage.filters import gaussian_filter
from dipy.io.image import save_nifti 
# Load nifti image and GradientTable object with information about the b-values and b-vectors
data, affine = load_nifti('kurtosis_patch2self_crop_moco.nii.gz')
bvals, bvecs=read_bvals_bvecs('bvals', 'bvecs')
gtab=gradient_table(bvals, bvecs)
# Use dilated Spinal Cord mask obtained from segmentation to avoid unnecessary calculations on the background of the image
mask, affine= load_nifti('kurtosis_patch2self_crop_moco_dwi_mean_seg_dil.nii.gz')
# 3D Gaussian smoothing to suppress the effects of noise and artefacts before diffusion kurtosis fitting
fwhm=1.25
gauss_std=fwhm/np.sqrt(8*np.log(2))
data_smooth=np.zeros(data.shape)
for v in range (data.shape[-1]):
	data_smooth[...,v]=gaussian_filter(data[...,v], sigma=gauss_std)
# DKI fitting
dkimodel=dki.DiffusionKurtosisModel(gtab)
dkifit=dkimodel.fit(data_smooth, mask=mask)
# MSDKI fitting
msdki_model = msdki.MeanDiffusionKurtosisModel(gtab)
msdki_fit = msdki_model.fit(data_smooth, mask=mask)
# DTI measures based on DKI model
MD=dkifit.md
AD=dkifit.ad
RD=dkifit.rd
FA=dkifit.fa
# DKI measures
MK=dkifit.mk(0,3)
AK=dkifit.ak(0,3)
RK=dkifit.rk(0,3)
KFA=dkifit.kfa
# MSDKI measures
MSK = msdki_fit.msk
# Saving images
save_nifti('dki_MD.nii.gz',MD,affine)
save_nifti('dki_AD.nii.gz',AD,affine)
save_nifti('dki_RD.nii.gz',RD,affine)
save_nifti('dki_FA.nii.gz',FA,affine)
save_nifti('MK.nii.gz',MK,affine)
save_nifti('AK.nii.gz',AK,affine)
save_nifti('RK.nii.gz',RK,affine)
save_nifti('KFA.nii.gz',KFA,affine)
save_nifti('MSK.nii.gz',MSK,affine)
