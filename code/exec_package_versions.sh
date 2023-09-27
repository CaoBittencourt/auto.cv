#!/bin/bash

# Change directory to code
cd /c/Users/CAO/Documents/GitHub/auto.cv/code

# # Setup contrab job to execute package version script
# contrab -e

# # 1: Minutes (0-59)
# # 2: Hours (0-23)
# # 3: Days (1-31)
# # 4: Month (1-12)
# # 5: Day of the week(1-7)

# * * * * 6 /get_package_versions.sh
# # 0.5 * * * * /get_package_versions.sh

# Change directory to code
cd /c/Users/CAO/Documents/GitHub/auto.cv/code

# Run bash script to update package_versions.csv
bash get_package_versions.sh

# Run R script to generate LaTeX input
Rscript sketch_packages.R