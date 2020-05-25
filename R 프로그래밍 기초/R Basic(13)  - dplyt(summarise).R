# 그룹 생성 및 그룹별 자료 요약
# 함수 summarise() : 변수의 요약 통계량 계산
library(tidyverse)
# 데이터 프레임 mpg의 변수 hwy의 평균 계산
summarise(mpg,hwy_mpg=mean(hwy))

# summarise()에서 사용되는 함수
# 결과가 숫자 하나로 출력되는 함수만 사용 가능 : mean(), sd(), min(),max()
# 결과가 벡터인 함수는 사용 불가 ex) range()

# 유용한 함수 :
# n() : 케이스의 개수
# n_distinct(): 서로 다른 숫자의 개수
summarise(mpg,n = n(),n_hwy = n_distinct(hwy),
          avg_hwy = mean(hwy), sd_hwy = sd(hwy))
# group_by()
# 한 개 이상의 변수로 데이터 프레임을 그룹으로 구분
# 기본적인 사용법 : group_by(df,var)
# 실행 결과 : grouped_df라는 class 속성이 추가된 tibble
# 출력된 상태로는 실행 전과 차이가 없음

# 데이터 프레임 mpg를 변수 cyl에 따라 그룹으로 구분하고,
# 각 그릅에 속한 케이스의 개수 및 그룹별 변수 hwy의 평균값 계산
by_cyl <- group_by(mpg,cyl)
summarise(by_cyl, n=n(),avg_mpg = mean(hwy))
# by_cyl같이 의미 없는 객체를 생성하는건 복잡함
# pipe 기능이 필요
mpg %>% group_by(cyl) %>%
  summarise(n = n(), avg_hwy = mean(hwy))

# pipe 연산자
# 1)airquality의 월별변수 ozone의 평균값
airs_Month <- airquality %>% group_by(Month)
airs_Month %>% summarise(avg_Oz = mean(Ozone,na.rm = TRUE))
# 2) 월별 날수, 변수 ozone에 결측값이 있는 날수 및 실제 측정이 된 날수
airs_Month %>% summarise(n_total = n(), n_miss = sum(is.na(Ozone)), n_obs=sum(!is.na(Ozone)))
# 3) 월별 첫날과 마지막 날 변수 ozone의 값
airs_Month %>% summarise(min_day = first(Ozone),max_day = last(Ozone))
# 4) 월별 변수 ozone의 가장 작은 값과 가장 큰 값
# 5) 월별로 변수 ozoen의 개별 값이 전체 기간 동안의 평균값보다 작은 날수 