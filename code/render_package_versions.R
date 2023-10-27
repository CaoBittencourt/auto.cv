# [SETUP] -----------------------------------------------------------------
# - Packages ----------------------------------------------------------------
# CRAN packages
chr_pkg <- c(
  'readr' # Read files
  , 'glue', 'tidyr', 'dplyr', 'purrr' # Data wrangling
)

# Activate / install CRAN packages
lapply(
  chr_pkg,
  function(pkg){
    if (!require(pkg, character.only = T)) {
      install.packages(pkg)
    }
    
    require(pkg, character.only = T)
  }
)

# - Working directory -----------------------------------------------------
setwd('/home/Cao/Storage/github/auto.cv')

# - Data ------------------------------------------------------------------
# Read 'packages_versions.csv' file
df_packages <- read_csv('pkg_info.csv')

# [DATA] ------------------------------------------------------------------
# - Data wrangling --------------------------------------------------------
# Add LaTeX quotes to package subtitle
df_packages %>%
  mutate(
    package_subtitle = 
      paste0(
        '``',
        package_subtitle,
        '".'
      )
  ) -> df_packages

# Escape characters

# Package version data type
df_packages %>% 
  mutate(
    version = 
      as.numeric_version(
        version
      )
  ) -> df_packages

# In case of duplicates, keep latest version
df_packages %>% 
  group_by(
    package_name
  ) %>% 
  slice_max(
    version
    , n = 1
  ) %>% 
  slice(1) %>% 
  ungroup() %>% 
  arrange(
    desc(version)
    , package_name
  ) -> df_packages

# [OUTPUT] ----------------------------------------------------------------
# - Update .csv file ------------------------------------------------------
write_csv(
  x = df_packages
  , file = './pkg_info.csv'
)

# - Collapse to input format ----------------------------------------------
# Paste LaTeX input
df_packages %>%
  reframe(
    latex_input =
      paste0(
        '\\cvsection{Authored Programming Packages}',
        '\n',
        '\\begin{cvhonors}',
        '\n',
        paste0(
          '\\cvhonor',
          '{', package_name, '}',
          '{', package_subtitle, '}',
          '{', programming_language, '}',
          '{', version, '}',
          collapse = '\n'
        ),
        '\n',
        '\\end{cvhonors}',
        collapse = 'LALALALAL'
        # collapse = 'LALALALAL'
      )
  ) %>%
  pull(latex_input) ->
  chr_latex_input

# - Write .tex file -------------------------------------------------------
write_file(
  x = chr_latex_input
  , file = './committees.tex'
)
