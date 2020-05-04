# 연습문제 2-1-1
x <- c(17,16,20,24,22,15,21,18)
length(x)

# 1-2
x[length(x)]

# 2-1
y <- c(10.4,5.6,3.1,6.4,9.6,7.8,12.1)
length(y)

# 2-2
y[length(y)-1]

# 3-1
grade <- c('1st','1st','2nd','3rd','2nd','3rd','1st')
factor(grade)
# 3-2
factor(grade,order = TRUE ,levels = c('3rd','2nd','1st'))

# 4-1
var1 <- c(12,17,19)
var2 <- c(21,22,25)
var3 <- c(32,34,35)

cb <- cbind(var1,var2,var3)
rownames(cb) <- c('Case #1','Case #2','Case #3')
cb
# 4-2
cb[,2]

# 5
d1 <- data.frame(var1 = c(12,17,19),
                 var2 = c(21,22,25), 
                 var3 = c(32,34,35))
d1
# 5-1 
d1[2]

# 6-1
str(iris)
# 6-2
head(iris,n = 3)
# 6-3
tail(iris ,n = 3)

# 7
library(tidyverse)
df1 <- data.frame(x = 1 , y = 1:9, z = rep(1:3, each =3 ),w = sample(letters,9))
df1 <- as_tibble(df1)
df1
# 7-1
df1[[2]]
df1$y
df1[[2,]]
# 7-2
tb <- as_tibble(df1)
df1[2]
tb[2]

# 8
#8-1
seq(from = -5.0, to = 5.0, by = 0.2)
# 8-2
d1 <- seq(from = 1, to = 9, by = 2)
d2 <- seq(from = 2, to = 10, by = 2)
c(d1,d2)
# 8-3
rep(1:4,times = c(1:4))
# 8-4
rep(1:3, times = 3)
# 8-5
rep(c("a","b"), times = c(2:3))
# 8-6
paste0("a", 1:5)
# 8-7
paste0(rep(c("a","b","c"),times = 3),rep(c("a","b","c"), each = 3))

# 9-1 
a1 <- paste(letters,1:26, sep = "")
a1
# 9-2
a2 <- paste(a1,collapse ="-")
a2
#9-3
a3 <- paste0(a2,sep = "" ,collapse="")
a3





# 11-1
y <- c(17,16,20,24,22,15,21,18)
y[which.max(y)] <- 23
y
