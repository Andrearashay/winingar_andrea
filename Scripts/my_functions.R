
# Standard Error ----------------------------------------------------------

# assign function name and give arguments.
std_err <- function(values, na.rm = FALSE) {
  #Use ifelse() for NA values.
  ifelse(na.rm,
         # if true
         values <- na.omit(values),
         #if false
         values)
  # use sd() to calculate standard deviation of sample and save to st_dev.
  st_dev <- sd(values)
  # calculate sample size with length() and save to sam_size.
  sam_size <- length(values)
  # calculate square root of sam_size with sqrt() and save to sam_num.
  sam_num <- sqrt(sam_size)
  # divide st_dev by sam_num and save to std_err
  standard_error <- st_dev/sam_num
  # Return the result.
  return(standard_error)
}


# Scaled Mass Index Function ----------------------------------------------

# Assign function name and give arguments.
scaled_mass <- function(mass = 0, tarsus = 0, slope = 0) {
  # scaled mass calculation.
  mass*(((mean(tarsus))/tarsus)^slope)
}
