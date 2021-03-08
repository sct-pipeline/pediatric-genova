# Pediatric-Genova
Image analysis pipeline for processing neonatal Spinal Cord diffusion MRI data from University of Genoa in collaboration with Gaslini Children's Hospital.  
  Since SCT algorithms are validated in adult imaging, we specifically customized each processing step to our neonatal scans in order to apply an advanced dMRI model such as DKI.
  Main steps of our pipeline concern motion correction, segmentation, vertebral labeling, registration with PAM50 atlas and computation of diffusion measures in specific ROIs.
  
  An overview of our image processing pipeline highlighting key features is shown in the image below. 
  
  ![image](https://user-images.githubusercontent.com/58302565/110315001-e4b39480-8008-11eb-96de-614e694974b4.png)

This pipeline will loop across all subjects (or only the subjects that you have specified) located under the ```data``` folder and results will be concatenated into single csv files where each row will correspond to a subject. The files will be output in the ```data``` folder.

The following metric is output:
- **dmri**: All DTI (FA, MD, AD, RD) and DKI (KFA, MK, AK, RK) in whole WM, GM and CSTs tracts, averaged across slices
# Dependencies 
This pipeline was tested on SCT v4.1.0. This pipeline also relies on dipy v.1.1.0 for computation of DTI and DKI measures (https://dipy.org/documentation/1.1.0./examples_built/reconst_dki/).
# Data structure
```
data
  |- 001
  |- 002
  |- 003
      |- dki
        |- kurtosis.nii.gz
        |- bvecs
        |- bvals
        |- 3dT1.nii.gz
```   
# How to run      
- Organize your data as indicated above
- Download (or ```git clone```) this repository.
- Go to the repository folder: ```cd pediatric-genova```
- Copy the file ```parameters_template.sh``` and rename it as ```parameters.sh```.
- Edit the file parameters.sh and modify the variables according to your needs:
    - ```PATH_DATA```: Absolute path to the DATA folder. E.g.: ```/Users/bob/data```
    - ```SUBJECTS```: List of subjects to analyze. If you want to analyze all subjects in the ```PATH_DATA``` folder, then comment this variable.
    - ```METRICS_VERT_LEVEL```: Vertebral levels to compute diffusion metrics from. For example, if you want to extract metrics from levels 2, 3, 4 and 5, set this variable as    ```METRICS_VERT_LEVEL="2,3,4,5"```.
    - ```PATH_RESULTS```: Path where results will be stored. Default is: ```$PATH_DATA/results```
 Once the file ```parameters.sh``` is configured, you can run the pipeline as follows:
    ```./run_process.sh kurtosis_def.sh```
  This script will do all the processing as well as extraction of metrics within specified labels and levels. 
    A QC folder will be generated to check segmentation and template registration.
# Results 
Main outcomes of our neonatal pipeline are listed as follows.
This includes registration with PAM50 atlas and automatic delineation of ROIs thanks to atlas-based approach:

![image](https://user-images.githubusercontent.com/58302565/110314859-b59d2300-8008-11eb-90d1-fcd8ab4b0860.png)

And also computation of DTI and DKI maps for further extraction of their averages over specific ROIs: 

![image](https://user-images.githubusercontent.com/58302565/110314694-7bcc1c80-8008-11eb-8ffa-05c598563fa4.png)
# Contributors
Rosella Trò, Julien Cohen-Adad
