# Pediatric-Genova
Image analysis pipeline for processing neonatal Spinal Cord diffusion MRI data from University of Genoa in collaboration with Gaslini Children's Hospital.

This pipeline will loop across all subjects (or only the subjects that you have specified) located under the data folder and results will be concatenated into single csv files where each row will correspond to a subject. The files will be output in the data folder.

The following metric is output:

#dmri: All DTI (FA, MD, AD, RD) and DKI (KFA, MK, AK, RK) in whole WM, GM and CSTs tracts, averaged across slices
# Dependencies 
This pipeline was tested on SCT v4.1.0. This pipeline also relies on dipy v.1.1.0 for computation of DTI and DKI measures (https://dipy.org/documentation/1.1.0./examples_built/reconst_dki/.
# Data structure
# How to run         
# Contributors
Rosella Trò, Julien Cohen-Adad
