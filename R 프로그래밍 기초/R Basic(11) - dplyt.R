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
# 관찰값의 단순임의추출 : sample_n(), sample_frac()

