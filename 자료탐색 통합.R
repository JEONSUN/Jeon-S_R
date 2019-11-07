#논리>숫자>문자 
#행렬은 하나의 요인만 사용가능 , 데이터프레임 -2차
#1차원 구조 : 하나의 변수를 나타내기 위한 1차원 구조 ex)백터 
#2차원 구조 : 배열은 2차원 이상의 구조를 가진 데이터 형태 ,행렬 ,데이터프레
#3차~ array배열, 리스트
x = c(1,"1",T)
x
str(x)

#기존의 데이터 프레임을 tibble로 전환 as_tibble()
library(tidyverse)
cars
as_tibble(cars)
#개별 벡터를 이용한 tibble 생성 ,길이가 1일 경우에만 순환법칙 적용
tibble(x=1:3,y=x+1,z=1)
#데이터프레임에서는 적용불가

#순환법칙
x=1:4
y=c(2,4)
x+y
#대응되는 길이가 다를 경우 짧은 쪽에서 반복해서 계산
x=c(1,2)
y=c(3,4,5,6)
x+y

letters

#행단위로 입력하여 tibble 생성
tribble(~x,~y,1,"a",2,"b",3,"c")

# mass패키지 안에 있는 cars93만 불러와라
#패키지 base패키지,추천 패키지, 내가다운패키지
data(Cars93, package="MASS")
Cars93

#처음 10개 케이스만 출력
as_tibble(Cars93)

#변수 이름과 더불어 변수의 유형을 함께 표시
#cars93의 모든 변수를 나타내는 대신 3줄만 표시하라
print(as_tibble(Cars93), n=3, width=Inf)

#전통적 데이터 프레임 - 자료출력시 row name 함께 출력 ㅡ tibble은 생략
#head 처음 6개 케이스 출력
head(mtcars) 

#row name 제거
mtcars_t <- as_tibble(mtcars)
print(mtcars_t, n=6)

#생략된 row name 변수로 전환
mtcars_d <- rownames_to_column(mtcars, var='rownames')
mtcars_t <- as_tibble(mtcars_d)
mtcars_t

#인덱싱(대괄호)안에 들어가는 것들 정수형 벡터(양수-위치,음수-해당위치 제거), 논리형 벡터(선택시 true, 제거시 false)
#예전 데이터프레임 부분매칭 허용

df1 <- data.frame(xyz=1:3, abc=letters[1:3])
df1$x

#tibble 부분 매칭 불
tb1 <- as_tibble(df1)
tb1$x

#,사용시 행렬 인덱싱 방식

mtcars[, 1:2] 
mtcars[,1]

#tibble에서 변수의 개수 관계없이 항상 tibble 유지
mtcars_t[,1:2]
mtcars_t[,1]
mtcars_t[1,1]

tibble(x=1, y=1:9,z=rep(1:3,each=3))
tibble(x=1, y=1:9,z=rep(c(1,2,3),each=3))

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
df2 <- data.frame(id=rep(1:3,each=2), x1=c(2,2,3,1,4,4))
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

