#!/bin/bash

# Change directory to GitHub
cd /c/Users/CAO/Documents/GitHub/

# Get all R package DESCRIPTION files
# package_versions=$(for folder in find *atlas.*/ -name "DESCRIPTION"; do
package_versions=$(for folder in find . -name "DESCRIPTION"; do
    grep -iE "^Package|Title|Version" ${folder}/DESCRIPTION
done)

# Keep only package name, title, and version (remove variable names)
package_versions=${package_versions//Package: /}
package_versions=${package_versions//Title: /}
package_versions=${package_versions//Version: /}

# Initialize package_versions.csv
echo "package_name,package_subtitle,version" >package_versions.csv

# Write to package_versions.csv
echo "$package_versions" | paste -d "," - - - >>package_versions.csv