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
  function(pkg) {
    if (!require(pkg, character.only = T)) {
      install.packages(pkg)
    }
    
    require(pkg, character.only = T)
  }
)

# - Working directory -----------------------------------------------------
setwd('C:/Users/CAO/Documents/GitHub')

# - Data ------------------------------------------------------------------
# Read 'packages_versions.csv' file
df_packages <- read_csv('package_versions.csv')

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

# Arrange by package version
df_packages %>% 
  mutate(
    version = 
      as.numeric_version(
        version
      )
  ) %>% 
  arrange(desc(
    version
  )) -> df_packages

# [OUTPUT] ----------------------------------------------------------------
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
      )
  ) %>%
  pull(latex_input) ->
  chr_latex_input

# - Write .tex file -------------------------------------------------------
readr::write_file(
  x = chr_latex_input
  , file = './committees.tex'
)
