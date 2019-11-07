library(tidyverse)
cars
as_tibble(cars)
tibble(x=1:3,y=2:4)
tribble(~x,~y,1,"a",2,"b",3,"c")
library(MASS)
Cars93
cars <- as_tibble(Cars93)
print(cars,n=20,width=Inf)
head(cars)
mtcars_t <- as_tibble(mtcars)
print(mtcars_t,n=6)
mtcars_d <- rownames_to_column(mtcars,var="rowname")
mtcars_t <- as_tibble(mtcars_d)
mtcars_t

mtcars_t <- as_tibble(mtcars)
filter(mtcars_t,mpg>=30)
id=rep(1:3,each=2)
id


  #p.72 문제7
df1 <- tibble(x=1,y=1:9,z=rep(1:3,each=3),w=sample(letters,9))
df1[tbl,df1,y]
#7-1 df1의 두번째 열을 선택하여 벡터로 출력해보자. 기호[[]]와 $을 사용하는 것으로 세 가지 방법이 있다.
df1[,2]
df1[2]
df1[[2]]
df1$y

