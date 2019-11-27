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

# tryCatch wrapper
read_file_try <- function(file_name) {
  errortest <- try(read_file(file_name), T)
  output <- if_else(class(errortest) == "try-error", "error", as.character(errortest))
}

# Read files and search
files_identified <- files_to_search %>% 
  add_row(filenames = "x") %>% 
  mutate(file_text = map(filenames, read_file_try)) %>% 
  filter(grepl(search_terms_re, file_text, ignore.case = TRUE)) %>% 
  unnest(file_text)

files_identified$filenames %>% head()

