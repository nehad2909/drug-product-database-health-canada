setwd("C:\\Users\\lucho\\OneDrive - St. Clair College\\402 Capstone Project\\Final project\\Shortage data")


library(tidyverse)
library(readxl)
library(janitor)
library(readr)



# Create a function to read , clean, and select variables from data -------

read_shortage_data <- function(file_name){
  read_excel(file_name) %>% 
    clean_names() %>% 
    select(c("report_id", "drug_identification_number","brand_name", 
             "company_name", "common_or_proper_name", "ingredients", "strength_s", 
             "packaging_size","actual_start_date", "actual_end_date"))
  
}




# Combine all the files ---------------------------------------------------

list_of_files <- list.files(pattern='.xlsx')

list_of_files <- set_names(list_of_files, 
                           nm = list_of_files)

list_of_rez <- purrr::map_dfr(.x = list_of_files[1:7], 
                              .f =read_shortage_data,
                              .id = 'file_name')




# save --------------------------------------------------------------------

readr::write_csv(list_of_rez, file="combined_data.csv")
