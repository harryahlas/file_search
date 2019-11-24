#Search for terms in specific filetypes

library(tidyverse)

# Identify directory to search
directory_to_search <- "sql-data-warehouse-samples-master"

# Identify filetypes/suffixes to search
extension_types <- c(".sql", ".md")

# Identify search terms
search_terms <- c("security", "exec")

# Format search terms and extensions for grepl filter
extension_types_re <- paste0(extension_types, "$", collapse = "|") 
search_terms_re <- paste0(search_terms, collapse = "|")

# View
extension_types_re
search_terms_re

# Identify files to search
files_to_search <- list.files(directory_to_search, recursive = TRUE, full.names = TRUE) %>% 
  tibble(filenames = .) %>% 
  filter(grepl(extension_types_re, filenames, ignore.case = TRUE)) 

files_to_search %>% head()

# Read files and search
files_identified <- files_to_search %>% 
  mutate(file_text = map(filenames, read_file)) %>% 
  filter(grepl(search_terms_re, file_text, ignore.case = TRUE)) %>% 
  unnest(file_text)

files_identified$filenames %>% head()

