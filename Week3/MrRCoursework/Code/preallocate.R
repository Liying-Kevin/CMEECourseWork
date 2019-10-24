a <- NA
for (i in 1:10) {
    a <- c(a, i)
    print(a)
    print(object.size(a))
}

a <- rep(NA, 10)

for (i in 1:10) {
    a[i] <- i
    print(a)
    print(object.size(a))
}

M <- matrix(runif(1000000),1000,1000)

SumAllElements <- function(M){
  Dimensions <- dim(M)
  Tot <- 0
  for (i in 1:Dimensions[1]){
    for (j in 1:Dimensions[2]){
      Tot <- Tot + M[i,j]
    }
  }
  return (Tot)
}
 
print("Using loops, the time taken is:")
print(system.time(SumAllElements(M)))

print("Using the in-built vectorized function, the time taken is:")
print(system.time(sum(M)))
