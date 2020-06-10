library(tidyverse)

# mpg의 변수 trans의 막대 그래프 작성
ggplot(data=mpg, mapping=aes(x=trans)) +
  geom_bar()

ggplot(data=mpg, mapping=aes(x=trans)) +
  stat_count()

# mpg의 변수 trans의 막대 그래프를 상대 도수로 작성
ggplot(data=mpg) +
  geom_bar(mapping=aes(x=trans,y=stat(prop)))

# group=1을 해줘야 하나의 그룹으로 묶여 제대로된 비율이 나타난다
ggplot(data=mpg) +
  geom_bar(mapping=aes(x=trans,y=stat(prop), group=1))

# geom함수에서 stat을 따로 지정해야 하는경우
mpg_am <- mpg %>% mutate(am=substr(trans,1,nchar(trans)-4)) %>%
  count(am)


ggplot(mpg_am) +
  geom_bar(mapping=aes(x=am,y=n),stat="identity")


ggplot(mpg_am) +
  geom_bar(mapping=aes(x=am,y=, group=1))

# 산점도에서 점이 겹쳐지는 문제 해결 
ggplot(mpg) +
  geom_point(aes(x=cty,y=hwy))

ggplot(mpg, aes(x=cty,y=hwy)) +
  geom_point(position="jitter")

ggplot(mpg, aes(x=cty,y=hwy)) +
  geom_jitter()
