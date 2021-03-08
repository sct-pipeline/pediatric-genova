# Pediatric-Genova
Image analysis pipeline for processing neonatal Spinal Cord diffusion MRI data from University of Genoa in collaboration with Gaslini Children's Hospital.
An overview of our image processing pipeline highlighting key features is shown in Figure 1. Since SCT algorithms are validated in adult imaging, we specifically customized each processing step to our neonatal scans in order to apply and advanced dMRI model such as DKI. Main steps of our pipeline concern motion correction, segmentation, vertebral labeling, registration with PAM50 atlas and computation of diffusion measures in specific ROIs. An overview of our image processing pipeline highlighting key features is shown in the image below. 
![pipeline](https://user-images.githubusercontent.com/58302565/110313294-84bbee80-8006-11eb-9207-c8891fce524c.png)

This pipeline will loop across all subjects (or only the subjects that you have specified) located under the ```data``` folder and results will be concatenated into single csv files where each row will correspond to a subject. The files will be output in the ```data``` folder.

The following metric is output:

- **dmri**: All DTI (FA, MD, AD, RD) and DKI (KFA, MK, AK, RK) in whole WM, GM and CSTs tracts, averaged across slices
# Dependencies 
This pipeline was tested on SCT v4.1.0. This pipeline also relies on dipy v.1.1.0 for computation of DTI and DKI measures (https://dipy.org/documentation/1.1.0./examples_built/reconst_dki/.
# Data structure
# How to run         
# Contributors
Rosella Trò, Julien Cohen-Adad
