#!/bin/bash
# set environment variables for your study.

# Path to input data (do not add "/" at the end). This path should be absolute
# (i.e. should start with "/"). Example: PATH_DATA="/Users/bob/data"
export PATH_DATA=""

# List of subjects to analyse. If you want to analyze all subjects in the
# PATH_DATA folder, then comment this variable.
export SUBJECTS=(
	"001"
	"002"
	)

# Path where to save results (do not add "/" at the end).
export PATH_RESULTS="${PATH_DATA}/results"
