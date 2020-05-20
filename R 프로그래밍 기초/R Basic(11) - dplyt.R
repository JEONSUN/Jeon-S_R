# dplyr에 의한 데이터 변환
# 통계 데이터 셋 :
# 변수가 열, 관찰값이 행을 이루는 2차원 구조
# 데이터 프레임으로 입력

# filter() : 특정 조건을 만족하는 관찰값 선택
# arrange() : 특정 변수를 기준으 관찰값 정렬
# select() : 변수 선택
# mutate() : 새로운 변수 선택
# group_by() : 그룹 생성
# summarise() : 자료 요약

######################################################

# 관찰값의 선택
# 조건에 따른 관찰값의 선택 : filter()
# 기본적인 형태 : filter(df, condition)
# df : 데이터 프레임
# condition : 관찰값 선택 조건
library(tidyverse)

mtcars_t <- as_tibble(mtcars)
filter(mtcars_t, mpg >= 30)

mtcars %>% as_tibble() %>% filter(mpg >= 30)

# mpg가 30이상이고, 변수 wt가 1.8 미만인 자동차 선택
filter(mtcars_t,mpg>=30 & wt<1.8)

# mpg가 30이하이고, 변수 cyl이 6또는 8, 변수 am이 1인 자동차 선택
filter(mtcars_t, mpg<=30 & cyl %in% c(6,8) & am == 1)
filter(mtcars_t, mpg<=30 , cyl %in% c(6,8) , am == 1)

# 변수 mpg의 값이 mpg의 중앙값과 q3 사이에 있는 자동차 선택
# 분위수 계산 : 함수 quantile(x,probs = )
filter(mtcars_t, mpg >= median(mpg) & 
         mpg <= quantile(mpg,probs= 0.75))

filter(mtcars_t, 
       between(mpg, median(mpg),
               quantile(mpg,probs = 0.75)))

# 예제 airquality
# 변수 Ozone 또는 Solar.R이 결측값인 관찰값 선택
air_t <-as_tibble(airquality) 
filter(air_t, is.na(Ozone)|is.na(Solar.R))

air_t <-as_tibble(airquality) 
filter(air_t, is.na(Ozone&Solar.R))

# 중복된 케이스 제거
# 1. 특정 변수의 값이 중복된 케이스 제거
df1 <- data.frame(id = rep(1:3,times = c(2,3,4)),x1 = 1:9)
duplicated(df1$id) # 중복된 숫자 찾기
filter(df1, !duplicated(id))

# 2. 모든 변수의 값이 중복된 행 제거
df2 <- data.frame(id = rep(1:3, each = 2), 
                  x1 = c(2,2,3,1,4,4))
df2                  
filter(df2, !duplicated(df2))

# 관찰값의 단순임의추출
# sample_n(): 추출하는 행의 개수 size에 지정
# sample_frac() : 추출하는 행의 비율 size에 지정
# 비복원 추출이 디폴트
# 복원 추출을 원하는 경우 replace = TRUE 입력

# 임의로 3개 행 추출
# 임의로 1%의 행 추출
iris_t <- as_tibble(iris)
sample_n(iris_t,size = 3)
sample_frac(iris_t,size = 0.01)

# base R 함수 sample()에 의한 방법
sample(1:5, size = 3)
sample(1:5, size = 3, replace = TRUE)

my_index <- sample(1:nrow(iris), size = 3)
iris[my_index,]

# 특정 변수의 값이 가장 큰(작은) 관찰값 선택
# top_n(df,n,wt)
# df : 데이터 프레임
# n : 선택할 행의 개수  # n이 양수 : wt값이 큰 관찰값
# wt : 순서를 결정할 변수 지정 # n이 음수 : wt값이 작은 관찰값

# iris_t에서 Sepal.Width의 값이 가장 큰 두 관찰값 및 가장 작은 두 관찰값
top_n(iris_t,n = 5,wt = Sepal.Width)
top_n(iris_t,n = -5,wt = Sepal.Width)

###############################################################################

#관찰값의 정렬 : arrange()
# 특정 변수를 기준으로 데이터 프레임의 행 재배열
# 기본적인 사용법 : arrange(df,va1_1,var_2,...)
# 오름차순 정렬이 디폴트 내림차순 정렬시 desc()에 변수 입력

#변수 mpg의 값이 가장 좋지 않은 자동차부터 배열
mtcars_t <- as_tibble(mtcars)
arrange(mtcars_t,mpg)

# 변수 mpg가 가장 좋지 않은 자동차부터 배열하되, mpg 값이 같은 자동차는 변수 wt의 값이 노높은 자동차부터 배열
arrange(mtcars_t,mpg,desc(wt))

# 5월 1일부터 5월 10일까지의 자료만을 대상으로 Ozone의 값이 가장 낮았던 날부터 재배열
airs <- as_tibble(airquality)
airs1 <- filter(airs,Month==5&Day<=10)
arrange(airs1,Ozone)

# airs에서 변수 ozone이 결측값인 케이스를 가장 앞으로 배열
arrane(airs,!is.na(Ozone))

# airs에서 변수 ozone이 가장 높은 날부터 배열하되 결측값이 있는 케이스를 가장 앞으로 배치
arrange(airs,!is,na(Ozone),desc(Ozone))
