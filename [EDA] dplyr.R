#dplyr
#mtcars에서 mpg가 30이상인 자동차 선택
filter(mtcars_t,mpg>=30)
#mtcars에서 mpg가 30이상이며 wt가 1.8미만인 자동차 선택
filter(mtcars_t,mpg>=30 & wt<1.8)
#변수 mpg가 30이하, 변수 cyl이 6 또는 8, 변수 am이 1인 자동차 선택
filter(mtcars_t,mpg<=30, cyl%in% c(6,8),am==1)
#변수 mpg의 값이 mpg의 중앙값과 q3사이에 있는 자동차 선택
filter(mtcars_t,mpg>=median(mpg) & mpg<=quantile(mpg,probs=0.75))
#between사용하여 특정 수 숫자 사이에 있는지 확이
filter(mtcars_t,between(mpg,median(mpg) ,quantile(mpg,probs=0.75)))
#변수 Ozone 또는 Solar.R의 결측값만 추출
airquality
airs<- as_tibble(airquality)
filter(airs, is.na(Ozone)|is.na(Solar.R))
#특정 변수의 값이 중복된 케이스 제거
#1,2,3이 각각 처음으로 나와 중복이 아닐경우엔 false로 나온다
df1 <- data.frame(id=rep(1:3 , time=2:4),x1=1:9)
df1
duplicated(df1$id)
filter(df1,!duplicated(id))
#모든 변수의 값이 중복된 행 제거
df2 <- data.frame(id=(1:3,each=2), x1=c(2,2,3,1,4,4)))
df2
duplicated(df2)

iris
#sample_n <- 추출하고자 하는 행의 개수
#sample_frac <-  추출하고자 하는 행의 비율
#임의로 3개 행 추출
iris_t <- as_tibble(iris)

sample_n(iris_t,size=3)

my_index <- sample(1:nrow(iris),size=3)
iris[my_index,]
sample_frac(iris_t,size=0.05)
#base r 함수 sample()에 의한 방법
sample(1:5, size=3)
#복원추출을 할경우 replace 추가
sample(1:5, size=3 ,replace=TRUE)

#특정 변수의 값이 가장 큰(작은) 관찰값 선택
#top_n(df,n,wt) -n이 양수 wt 값이 가장 큰 관찰값 ,음수 일시 wt 값이 가장 작은값
#iris데이터에서 sepal.width의 가장 큰 두관찰값, 작은 두관찰값을 구하라!
top_n(iris_t,n=2,wt=Sepal.Width)
top_n(iris_t,n=-2,wt=Sepal.Width)

#관찰값 정렬 arrange()
#arrange(df,var_1,var_2,~) var1 <- 정렬기준변수 var2 <- var1의 값이 같은 관찰값의 정렬기준
#변수 mpg의 값이 가장 좋지 않은 자동차부터 재배열
mtcars_t <- as_tibble(mtcars)
arrange(mtcars_t,mpg)

#5월 1일부터 5월 10일까지의 자료만을 대상으로 변수 Ozone의 값이 가장 낮았던 날부터 재배열
airs <- as_tibble(airquality)
airs_1 <- filter(airs,Month==5,Day<=10)
arrange(airs_1,Ozone)
#데이터프레임 airs_1을 변수 Ozone이 결측값인 케이스를 가장 앞으로 배열

#데이터프레임 airs_1을 변수 Ozone이 가장 높은 날부터 배열하되 결측값이 있는 케이스를 가장 앞으로 배치
arrange(airs_1, !is.na(Ozone))
#Ozone의 값이 가장 높은 날부터 재배열하되 결측값이 있는 케이스를 가장 앞으로 배열
arrange(airs_1, !is.na(Ozone),desc(Ozone))

#변수의 선택 select()
#mtcars의 row names를 변수 rowname으로 전환하고 변수 rowname과 mpg선택
mtcars_d <- rownames_to_column(mtcars,var="rowname")
mtcars_t <- as_tibble(mtcars_d)
select(mtcars_t,rowname,mpg)
#데이터 프레임 mtcars_t의 두번째 변수 mpg부터 일곱번째 변수 wt까지 모두 선택
select(mtcars_t,mpg:wt)
#데이터 프레임 mtcars_t에서 변수 roname과 qsec에서 carb까지 제거
select(mtcars_t, -rowname,-(qsec:carb))