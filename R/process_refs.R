# Filter a list of references in YAML format to those cited in an RMD file
library(tidyverse)
source(here::here("R/functions.R"))

# There are two yaml files with references to be filtered
# - _data_raw-raw/main_library.yaml has been exported from Zotero
# like this: file -> "export library" -> "Better CSL YAML"
# - _data-raw/other_refs.yaml includes other references maintained by hand

# First combine reference lists
main_library <- yaml::read_yaml(here::here("_data-raw/main_library.yaml"))
other_refs <- yaml::read_yaml(here::here("_data-raw/other_refs.yaml"))
combined_refs <- main_library
combined_refs$references <- c(combined_refs$references, other_refs$references)

# Filter to references across all Rmd files
filter_refs_yaml(
  rmd_file = list.files(here::here(), ".Rmd", full.names = TRUE),
  yaml_in = combined_refs,
  yaml_out = here::here("references.yaml"))
