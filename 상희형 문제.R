# 문제 
# 데이터는 car 패키지에 있는 UN 데이터이다.
library(tidyverse)
library(car)
UN
# region의 결측값은 제거하고, Latin Amer와 North America를 합쳐 America로 만들고, 
UN %>% as_tibble()%>% filter(!is.na(region))%>%mutate(America=subset(region %in% c("Latin Amer","North America")))
# Carbibean과 NorthAtlantic과 Oceania를 합쳐 Etc로 만들고,


# 각 region별로 fertility의 평균을 막대그래프로 다음과 같이 그려라.
# 단 그래프의 색은 빈도의 개수가 커질수록 연하게, 작을수록 진하게 표현하여라.
# 그리고 막대 위에 범주의 개수를 표시하고, 범주는 안나타나게 하여라.

# 위의 막대그래프를 파이차트로 바꿔라



