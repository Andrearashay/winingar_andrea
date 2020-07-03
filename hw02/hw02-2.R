# Andrea Winingar
# Homework 2 Part 2: Vectors
# 2.2 Vectortypes
alphabet <- c("A", "B", "C", "D", "E", "F")
integers <- c(1, 2, 3, 4, 5, 6) 
# Logical vector
logical_vector <- c(FALSE, FALSE, TRUE)
#
# 2.3 Biological Vectors
# Cultures without pplo contaminant
cultures_without_pplo <- c(4.6, 4.8, 5.1, 5.5, 5.8)
# Cultures with pplo contaminant
cultures_with_pplo <- c(4.6, 4.7, 4.8, 4.9, 4.8)
#
# 2.4 Name your Vectors
# Create a `days_sampled` vector.
days_sampled <- c("Day 0", "Day 2", "Day 4", "Day 6", "Day 8" )
# Name your two data vectors with the `days_sampled` vector.
names(cultures_with_pplo) <- days_sampled
names(cultures_without_pplo) <- days_sampled
# Check that your two data vectors were properly named.
cultures_with_pplo
cultures_without_pplo
#
#2.5 Calculations with Vectors
# Find the maximum values in cultures_without_pplo and cultures_without_pplo
max(cultures_with_pplo)
max(cultures_without_pplo)
# Store in max_without_pplo and max_with_pplo, respectively.
max_with_pplo <- max(cultures_with_pplo)
max_without_pplo <- max(cultures_without_pplo)
# Find the minimum values in cultures_without_pplo and cultures_without_pplo
min(cultures_with_pplo)
min(cultures_without_pplo)
# Store in min_without_pplo and min_with_pplo, respectively.
min_with_pplo <- min(cultures_with_pplo)
min_without_pplo <- min(cultures_without_pplo)
# Use 10^ to calculate the actual number of cells for each culture.
10^(cultures_with_pplo)
10^(cultures_without_pplo)
# Store in cell_counts_without_pplo and cell_counts_with_pplo
cell_counts_with_pplo <- 10^(cultures_with_pplo)
cell_counts_without_pplo <- 10^(cultures_without_pplo)
# Calculate the average number of cell counts for each vector.
# You do not have to save these values to variables
mean(cell_counts_with_pplo)
mean(cell_counts_without_pplo)
#
# 2.6 Extract individual elements from a vector
# Select the third element from cultures_without_pplo by position number
cultures_without_pplo[3]
# Select the odd numbered elements of cell_counts_with_pplo using a vector of position numbers.
position_vector <- c(1,3,5)
cell_counts_with_pplo[position_vector]
# Select the elements for `Day 2` and `Day 4` by name from cultures_with_pplo
cultures_with_pplo[c("Day 2", "Day 4")]
#
# 2.7 Extraction by logical comparison
# Use `cell_counts_without_pplo` to create a logical vector for cell counts greater than 100,000.
high_cell_counts <- cell_counts_without_pplo > 100000
# Use that vector to show the days and log values from `cultures_without_pplo`.
cultures_without_pplo[high_cell_counts]
# Use `cell_counts_with_pplo` and `&` to create a logical vector for cells counts greater than 50,000 and less than 75,000.
medium_cell_counts <- cell_counts_with_pplo >= 50000 & cell_counts_with_pplo <= 75000
# Use that logical vector to show the days and log values from `cultures_with_pplo`.
cultures_with_pplo[medium_cell_counts]
#