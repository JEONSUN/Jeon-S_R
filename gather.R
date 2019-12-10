library(tidyverse)
table1

table4a %>% 
  gather(key=year,value=cases,'1999','2000')


# 예: 어떤 제품의 3년 동안 분기별 판매량
df_1%>%gather(key=Qtr,value=Sales,Qtr.1:Qtr.4)%>%
  arrange(Year)

table2

# spread()에 의한 tidy 데이터 만들기
# spread(data,key=,value=)
# key : 여러 변수의 이름이 입력된 열 이름
# value : 여러 변수의 자료가 입련된 열 이름

table2 %>%
  spread(key=type,value=count)

# 예: 한 사람의 신장과 체중 데이터
df_2 <- data.frame(NAME=("kim","Park","Lee"),type=("Height","Weight"),measure=c(170,75,165,63,175,85))
# tidy 데이터로 변환
df_2%>%spread(key=type,value=measure)


