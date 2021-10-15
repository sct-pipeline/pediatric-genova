#
# Script for denoising raw DKI scans with Patch2Self method. Tested on dipy v.1.4.1
#
# Author: Rosella Trò

# import all relevant modules
from dipy.io.image import load_nifti, save_nifti
import numpy as np
from dipy.denoise.patch2self import patch2self

# Load
data, affine = load_nifti('kurtosis.nii.gz')
bvals = np.loadtxt('bvals')
print('Data Loaded!')

# Denoise and save output for later use
denoised_arr = patch2self(data, bvals, model='ols', shift_intensity=True, clip_negative_vals=False)
save_nifti('kurtosis_patch2self.nii.gz', denoised_arr, affine)
