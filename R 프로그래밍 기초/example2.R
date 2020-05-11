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
factor(grade,order = TRUE ,level = c('3rd','2nd','1st'))

# 4-1
var1 <- c(12,17,19)
var2 <- c(21,22,25)
var3 <- c(32,34,35)

cb <- cbind(var1,var2,var3)
rownames(cb) <- c('Case #1','Case #2','Case #3')
cb
# 4-2
cb[,2]

# 4번 교수님 풀이
x <- c(12,17,19,21,22,25,32,34,35)
cname <- paste0("var",1:3)
rname <- paste0("Case #", 1:3)
m1 <- matrix(x, nrow = 3, dimnames = list(rname,cname))
m1

# 5
d1 <- data.frame(var1 = c(12,17,19),
                 var2 = c(21,22,25), 
                 var3 = c(32,34,35))
d1

# 5-1 
d1[2]

# 6-1
names(iris)
dim(iris)
# 6-2
head(iris,n = 3)
# 6-3
tail(iris ,n = 3)

# 7
library(tidyverse)
df1 <- tibble(x = 1 , y = 1:9, z = rep(1:3, each =3 ),w = sample(letters,9))

# 7-1
df1[["y"]]
df1$y
df1[[2]]
# 7-2
df1[1:5,2]
as.data.frame(df1)[1:5,2]

# 8
#8-1
seq(from = -5.0, to = 5.0, by = 0.2)
seq(-5,5,by = .2)
# 8-2
c(seq(1,9,by = 2), seq(2,10,by = 2))
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

a1 <- paste0(letters, 1:length(letters))
a1
# 9-2
a2 <- paste(a1,collapse ="-")
a2
#9-3
a3 <- gsub("-","",a2)
a3

# 10
x <- c(10.4,5.6,3.1,6.4,21.7)

# 10 - 1
sum(x)/5
mean(x)

# 10 - 2
sqrt((sum(((x-mean(x))^2))/4))
sd(x)

# 10 - 3
x[-1]-x[-length(x)];diff(x)

# 11-1
y <- c(17,16,20,24,22,15,21,18)
y[which.max(y)] <- 23
y

y[y == max(y)] <- 23
y

# 11-2
sum(y>=20);length(y[y>=20])

# 11-3
mean(y<=18);length(y[y<=18])/length(y)

# 12
score <- c(85,91,75,69,52,95,88,100)
# 12 - 1
grade <- 1*(score <= 90) + 2*(80 <= score & score < 90) + 3*(70 <= score & score < 80) + 
  4*(60 <= score  & score< 70) + 5*(score < 60)
grade <- factor(grade, labels = c("A","B","C","D","F"))
grade

# 12 - 2
grade <- cut(score , breaks = c(50,60,70,80,90,100),
             right = FALSE, # a <= x < b
             include.lowest = TRUE, 
             labels = c("F","D","C","B","A"))
grade

# 12 - 3
data.frame(score , grade)

# 13
x <- c(1,3,2,7,12,6,1,3,6,6,7)
y <- c(6.1,9.7,10.3,18.8,28.3,16.1,5.7,12.6,16.1,15.8,18.8)


# 14
x <- c(1.2,1.5,2.1,2.5,2.7,2.1,3.1,3.2,2.8)
A <- list(mat = matrix(x,nrow = 3,byrow = TRUE), 
                       df = data.frame(x1 = c("Park","Lee","Kim"), x2 = c(14,16,21)))
A

# 14 - 1
rownames(A$mat) <- c("sub1","sub2","sub3") 
colnames(A$mat) <- c("Trt1","Trt2","Trt3")
names(A[[2]]) <- c("name","sales")

# 14 - 2
apply(A[[1]],1,mean)
# apply(matrix,margin,fun)
# apply(A,1,mean) : 행렬 A의 각 행에 함수 mean() 적용, 행렬 A 각 행의 평균 계산
# apply(A,2,mean) : 행렬 A의 각 열에 함수 mean() 적용, 행렬 A 각 열의 평균 계산

# 14-3
mean(A[[2]][[2]])
mean(A[[2]]$sales)
mean(A$df$sales)
