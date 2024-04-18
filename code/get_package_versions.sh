#!/bin/bash

# Change directory to GitHub
cd /home/Cao/Storage/github

# Get all R package DESCRIPTION files
pkg_dir=$(find . -name "DESCRIPTION")

pkg_dir=${pkg_dir///DESCRIPTION/}

pkg_info=$(
    for dir in $pkg_dir; do
        grep -iE "^Package|Title|Version" ${dir}/DESCRIPTION
    done
)

# Keep only package name, title, and version (remove variable names)
pkg_info=${pkg_info//Package: /}
pkg_info=${pkg_info//Title: /}
pkg_info=${pkg_info//Version: /}

# Change directory to auto.cv
cd /home/Cao/Storage/github/auto.cv

# Collapse pkg_info to .csv format
echo "$pkg_info" | paste -d "," - - - >pkg_info.csv

# Add R programming language to every line
sed -i -e "s/$/,R/" pkg_info.csv

# Add variable names to beginning of .csv file
sed -i "1s/^/package_name,package_subtitle,version,programming_language \n/" pkg_info.csv
