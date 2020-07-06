# Andrea Winingar
# Homework 02 Part 5: Data Frames
# 5.1 Data Frames
# 5.2 Viewing Data Frames
# Use `data()` to load the `iris` data frame.
data("iris")
# Enter `iris` on a line by itself to display the full data frame.
iris
# Display the first 10 rows of the data frame.
head(iris, n=10)
# Display the last rows of the data frame, 
tail(iris)
# Display the dimensions using the least amount of code (9 characters).
dim(iris)
# Display the structure of the data frame.
str(iris)
#
# 5.3 Extracting elements from a data frame
# Display the 101st row of the `Petal.Length` column, using column numbers.
iris[101, 3]
# Display the first six rows of all columns (mimic head ())
iris[1:6,]
# Display rows 48-52 of the fourth column, using the column header name in square brackets.
iris[48:52,"Species"]
# Display the contents of the `Sepal.Width` column using the `$`
iris$Sepal.Width
# Optional challenge
iris$Species[50:51]
#
# 5.4 Extracting Elements with Boolean Vectors
# Extract rows where sepal length less than or equal to 5.5. Save the result.
short_sepal <- iris$Sepal.Length <= 5.5
# Apply the `min()` and `max()` functions to your result from above.
min(short_sepal)
max(short_sepal)
# Display rows where sepal width is less than 3.2 AND species is setosa.
iris$Species == "setosa" & iris$Sepal.Width < 3.2 
# Display rows where sepal width is less than 2.5 OR petal width is greater than 2.0.
iris$Sepal.Width < 2.5 | iris$Sepal.Width > 2.0
#
# 5.5 Use subset to extract data from a data frame
# Display rows for petal length between and including 4.0 and 5.0.
subset(iris, Petal.Length >= 4.0 & Petal.Length <= 5.0)
# Display rows for sepal length < 5.2 and species is versicolor.
subset(iris, Sepal.Length < 5.2 & Species == "versicolor")
#
# 5.6 Sort
# Order the data frame from shortest to longest sepal length.
sort_order <- order(iris$Sepal.Length)
iris$Sepal.Length[sort_order]
# Display the species and petal width columns in decreasing order of petal width.
sort_order <- order(iris$Petal.Width, decreasing = TRUE)
iris[sort_order, c("Species", "Petal.Width")]
#