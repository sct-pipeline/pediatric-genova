from dipy.io.image import load_nifti, save_nifti
import numpy as np

from dipy.denoise.patch2self import patch2self
data, affine = load_nifti('kurtosis.nii.gz')
bvals = np.loadtxt('bvals')
print('Data Loaded!')

denoised_arr = patch2self(data, bvals, model='ols', shift_intensity=True, clip_negative_vals=False)
save_nifti('kurtosis_patch2self.nii.gz', denoised_arr, affine)
