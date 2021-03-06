# Example usage of RCpp.

library('Rcpp')
library('RcppArmadillo')
library('microbenchmark')

working.directory <- "~/Dropbox/School/ST215/Lab/lab3/lab_session/"
working.directory <- "~/Dropbox/School/ST215/Lab/lab3/"
# Flags for openMP.  If you're not using openMP, you don't need these.
# Sys.setenv("PKG_CXXFLAGS"="-fopenmp")
Sys.setenv("PKG_LIBS"="-fopenmp")
Sys.setenv("PKG_CXXFLAGS"="-I/path/ -fopenmp -I/Users/hd/Downloads/eigen-eigen-1306d75b4a21/")
# 
sourceCpp("/Users/hd/Documents/test2.cpp")
sourceCpp(file.path(working.directory, 'Rcpp_demo.cpp'))
sourceCpp(file.path(working.directory, 'FastDist.cpp'))

x = rnorm(1e7)
y = rnorm(1e7)
z <- cbind(x, y)

# Define our own R distance function
DistanceR <- function(x, y) {
  return(sqrt(sum((x - y) ^ 2)))
}

# Test our R version vs. our C++ version, with a strangely underperforming
# openMP function to boot.
microbenchmark(DistanceR(x, y),
               DistanceCPP(x, y),
               DistanceMatrixCPP(z), times = 5)
# DistanceCPPParallel(x, y),

# All the answers are the same:
DistanceCPP(x, y)
DistanceCPPParallel(x, y)
DistanceR(x, y)
DistanceMatrixCPP(z)
