# get day price of stock
install.packages("quantmod")
library(quantmod)
?getSymbols
getSymbols("GOOG")
head(GOOG)
dim(GOOG)


getSymbols("^TWII")
head(TWII)
tail(TWII)
