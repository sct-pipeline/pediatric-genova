#!/bin/bash
# Script for setting configuration file for your study.
# Copy this file and rename it as `parameters.sh`, then modify the variables
# according to your needs.

# Path to working directory, which contains data results, qc, etc. (do not add "/" at the end). 
# This path should be absolute (i.e. should start with "/"). Example: PATH_DATA="/Users/bob/experiments"
export PATH_MAIN="/Users/rosella/neonatal_sc"

# Path to the folder which contains all data
export PATH_DATA="${PATH_MAIN}/data"

# List of subjects to analyse. If you want to analyze all subjects in the
# PATH_DATA folder, then comment this variable.
export SUBJECTS=(
	"001"
	"002"
	"003"
	"004"
	)
	
# Cropping boundaries along the three axes
export X_min="60"
export X_max="100"
export Y_min="60"
export Y_max="100"
export Z_min="5"
export Z_max="20"

# Vertebral levels to compute MRI metrics from
export METRICS_VERT_LEVEL="1,2,3,4"

# Path where to save results (do not add "/" at the end).
export PATH_RESULTS="${PATH_MAIN}/results"

# Path where to save QC results (do not add "/" at the end).
export PATH_QC="${PATH_MAIN}/qc"
