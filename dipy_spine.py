import os, sys
import numpy as np
import matplotlib.pyplot as plt
import dipy.reconst.dki as dki
import dipy.reconst.dti as dti
from dipy.core.gradients import gradient_table
from dipy.data import get_fnames
from dipy.io.gradients import read_bvals_bvecs
from dipy.io.image import load_nifti
from dipy.segment.mask import median_otsu
from scipy.ndimage.filters import gaussian_filter
from dipy.io.image import save_nifti 

data, affine= load_nifti('kurtosis_crop_moco.nii.gz')
bvals, bvecs=read_bvals_bvecs('bvals', 'bvecs')
gtab=gradient_table(bvals, bvecs)
mask, affine= load_nifti('kurtosis_crop_moco_dwi_mean_seg_dil.nii.gz')
fwhm=1.25
gauss_std=fwhm/np.sqrt(8*np.log(2))
data_smooth=np.zeros(data.shape)
for v in range (data.shape[-1]):
	data_smooth[...,v]=gaussian_filter(data[...,v], sigma=gauss_std)
dkimodel=dki.DiffusionKurtosisModel(gtab)
dkifit=dkimodel.fit(data_smooth, mask=mask)
MD=dkifit.md
AD=dkifit.ad
RD=dkifit.rd
FA=dkifit.fa
MK=dkifit.mk(0,3)
AK=dkifit.ak(0,3)
RK=dkifit.rk(0,3)
KFA=dkifit.kfa
save_nifti('dki_MD.nii.gz',MD,affine)
save_nifti('dki_AD.nii.gz',AD,affine)
save_nifti('dki_RD.nii.gz',RD,affine)
save_nifti('dki_FA.nii.gz',FA,affine)
save_nifti('MK.nii.gz',MK,affine)
save_nifti('AK.nii.gz',AK,affine)
save_nifti('RK.nii.gz',RK,affine)
save_nifti('KFA.nii.gz',KFA,affine)
