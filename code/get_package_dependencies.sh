# #!/bin/bash

# # Change directory to GitHub
# cd /home/Cao/Storage/github

# # Get all R package DESCRIPTION files
# pkg_dir=$(find . -name "DESCRIPTION")

# pkg_dir=${pkg_dir///DESCRIPTION/}

# pkg_dependencies=$(
#     for dir in $pkg_dir; do
#         grep -iE "^Package|Title|Depends" ${dir}/DESCRIPTION
#     done
# )

# # Keep only package name, title, and dependencies (remove variable names)
# pkg_dependencies=${pkg_dependencies//Package: /}
# pkg_dependencies=${pkg_dependencies//Title: /}
# pkg_dependencies=${pkg_dependencies//Depends: /}

# # Change directory to auto.cv
# cd /home/Cao/Storage/github/auto.cv

# # Collapse pkg_dependencies to .csv format
# echo "$pkg_dependencies" | paste -d "," - - - >pkg_dependencies.csv

# # Add R programming language to every line
# sed -i -e "s/$/,R/" pkg_dependencies.csv

# # Add variable names to beginning of .csv file
# sed -i "1s/^/package_name,package_subtitle,dependencies,programming_language \n/" pkg_dependencies.csv

