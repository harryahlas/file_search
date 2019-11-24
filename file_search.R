#Search for terms in specific filetypes

library(tidyverse)

# Identify search terms
search_terms <- c("hrsample", "HRSAMPLE")
search_terms_re <- paste0(search_terms, collapse = "|")

# Identify filetypes to search
extension_types <- c(".html", ".R")
extension_types_re <- paste0(extension_types, "$", collapse = "|")


directory_to_search <- "C:\\Development\\github\\blog"#server-python"

file_list <- list.files(directory_to_search, recursive = TRUE)


files_to_search <- tibble(
  filenames = list.files(directory_to_search, recursive = TRUE)) %>% 
  filter(grepl(extension_types_re, filenames, ignore.case = TRUE)) # filter for extensions
  

search_terms <- c(".wav", ".mp3")
file_list[grepl("^m.*\\.log", file_list)]
#file_list[grepl("*\\.wav$", file_list)]%>% length()

file_list[grepl(".mp3$|.wav$", file_list)] 
