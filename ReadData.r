#Pakiet ulatwiajacy czytanie z plikow .xls
#install.packages("readxl")
library("readxl")

world_data <- read_excel("time_series.xlsx", sheet = "Data")

#Pobranie danych gdp danego panstwa
GetCountryGdp <- function(country){
  na.exclude(simplify2array(world_data[world_data$country==country,6]))
}

GetFirstYear <- function(country){
  data <- simplify2array(world_data[world_data$country==country,6])
  start <- which.min(is.na(data))
  1949 + start
}

country <- "Poland"
gdp_data<-GetCountryGdp(country)
first_year <- GetFirstYear(country)
first_year

vector <- gdp_data
vector_length <- length(gdp_data)
# Comment line below to get gdp accumulated, not gdp every year
vector <- vector[2:vector_length] - vector[1:vector_length - 1]

gdp_function<-approxfun(vector, rule = 2)

##Podzial dziedziny na wezly 
##bedace srodkami Fuzzy Sets
domain <- seq(1, length(vector), length.out = 20)
##Dlugosc wezla
h<-domain[2]-domain[1]
