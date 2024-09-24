#### Preamble ####
# Purpose: Downloads and saves the data from the Toronto Shelter System dataset on Open Data Toronto
# Author: Mariko Lee
# Date: 23 September 2024
# Contact: mariko.lee@mail.utoronto.ca 
# License: MIT
# Pre-requisites: None
# Any other information needed? None


#### Workspace setup ####
library(opendatatoronto)
library(dplyr)
library(readr)


#### Download data ####

# get package info for the Toronto Shelter System Flow dataset
package <- show_package("ac77f532-f18b-427c-905c-4ae87ce69c93")
package

# get all resources for this package
resources <- list_package_resources("ac77f532-f18b-427c-905c-4ae87ce69c93")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data


#### Save data ####

write_csv(data, "data/raw_data/toronto-shelter-system-flow.csv") 

         
