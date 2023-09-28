#!/bin/bash

# Change directory to GitHub
cd /c/Users/CAO/Documents/GitHub/

# Get all R package DESCRIPTION files
package_folders=$(find . -name "DESCRIPTION")

package_folders=${package_folders///DESCRIPTION/}

package_versions=$(
    for folder in $package_folders; do
        grep -iE "^Package|Title|Version" ${folder}/DESCRIPTION
    done
)

# Keep only package name, title, and version (remove variable names)
package_versions=${package_versions//Package: /}
package_versions=${package_versions//Title: /}
package_versions=${package_versions//Version: /}

# Collapse package_versions to .csv format
echo "$package_versions" | paste -d "," - - - >package_versions.csv

# Add R programming language to every line
sed -i -e "s/$/,R/" package_versions.csv

# Add variable names to beginning of .csv file
sed -i "1s/^/package_name,package_subtitle,version,programming_language \n/" package_versions.csv
