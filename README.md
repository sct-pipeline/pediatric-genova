# pediatric-genova
Image analysis pipeline for processing of neonatal Spinal Cord diffusion MRI data from University of Genoa in collaboration with Gaslini Children's Hospital.  
  Since SCT algorithms are validated in adult imaging, we specifically customized each processing step to our neonatal scans in order to apply an advanced dMRI model such as DKI.
  Main steps of our pipeline concern motion correction, segmentation, vertebral labeling, registration with PAM50 atlas and computation of diffusion measures in specific ROIs.
  
  An overview of our image processing pipeline highlighting key features is shown in the image below. 
![Figure_1](https://user-images.githubusercontent.com/58302565/137514414-17ef1cee-594f-4459-a2d8-e6ca76a03f2b.jpg){:height="80%" width="80%"}
  
This pipeline will loop across all subjects (or only the subjects that you have specified) located under the ```data``` folder and results will be concatenated into single csv files where each row will correspond to a subject. The files will be output in the ```data``` folder.

The following metric is output:
- **dmri**: All DTI (FA, MD, AD, RD) and DKI (KFA, MK, AK, RK) in whole WM, GM and CSTs tracts, averaged across slices
# Dependencies 
This pipeline was tested on SCT v4.1.0. This pipeline also relies on dipy v.1.1.0 for computation of DTI and DKI measures (https://dipy.org/documentation/1.1.0./examples_built/reconst_dki/) and on FSL v5.0 for mathematical manipulation of images and FSLeyes for active quality control (QC) (https://fsl.fmrib.ox.ac.uk/fsl/fslwiki).
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
    - ```PATH_DATA```: Absolute path to the DATA folder. E.g.: ```/Users/rosella/data```
    - ```SUBJECTS```: List of subjects to analyze. If you want to analyze all subjects in the ```PATH_DATA``` folder, then comment this variable.
    - ```X_min, X_max```: Cropping boundaries along x-axis. For example, if you want to set boundaries between 60 and 100 ,set these variables as    ```X_min="60"``` and ```X_max="100"```. The same for y- and z- axes.
    - ```METRICS_VERT_LEVEL```: Vertebral levels to compute diffusion metrics from. For example, if you want to extract metrics from levels 2, 3, 4 and 5, set this variable as    ```METRICS_VERT_LEVEL="2,3,4,5"```.
    - ```PATH_RESULTS```: Path where results will be stored. Default is: ```$PATH_DATA/results```
    
 Once the file ```parameters.sh``` is configured, you can run the pipeline as follows:  
   - Process the data
    
    ./run_process.sh process.sh
 
 
 This script will do all the processing. A QC folder will be generated to check segmentation and template registration.  
   - Quantify metrics

   ```
   ./run_process.sh metrics.sh 
   ```

which performs extraction of DTI and DKI metrics within specified labels and levels. 
# Results 
Main outcomes of our neonatal pipeline are listed as follows.
This includes registration with PAM50 atlas and automatic delineation of ROIs thanks to atlas-based approach:
![Immagine 2021-10-15 174119](https://user-images.githubusercontent.com/58302565/137515245-871c2cae-53d4-4246-a8fc-57fc050dcd47.jpg){:height="80%" width="80%"}


And also computation of DTI and DKI maps for further extraction of their averages over specific ROIs: 
![Figure_1S](https://user-images.githubusercontent.com/58302565/137515377-604a3e67-4d63-4cf9-aa53-cecbed9fc24a.png)

# Contributors
Rosella Trò, Julien Cohen-Adad
