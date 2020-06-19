library(tidyverse)
library(ggplot2)
mpg
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

# 위치 조정 : position adjustments
# 그래프 요소들의 위치 조정
# 연속형 자료 : 산점도의 점이 겹쳐지는 경우
# 범주형 자료 : 이변량 막대 그래프 작성

# 산점도의 점이 겹치는 문제 해결
# 산점도의 나타난 점의 개수가 전체 234개처럼 보이지않음. 
# jittering 사용
# 추가되는 난수의 크기를 조절하려 할때는 geom_jitter 사용
ggplot(mpg,aes(x = cty, y= hwy))+ 
  geom_point(position = "jitter")

# 함수 geom_jitter()
ggplot(mpg,aes(x= cty, y = hwy)) +
  geom_jitter(width = 0.5, height = 0.05)

ggplot(mpg,aes(x= cty, y = hwy)) +
  geom_jitter(width = 0.05, height = 0.4)

# diamonds에서 변수 carat과 price의 산점도
ggplot(diamonds, aes(x= carat,y = price))+
  geom_jitter()

# 이변량 막대 그래프 작성

# 이변량 막대 그래프 : geom_bar()에서 fill,position 사용
mpg_1 <- mpg %>%
  mutate(am =substr(trans,1,nchar(trans)-4))%>%
  filter(cyl!= 5) %>% print(n=3)
# 쌓아 올린 막대 그래프와 옆으로 붙여 놓은 막대 그래프 작성
p1 <- ggplot(mpg_1,aes(x = as.factor(cyl),fill = am)) +
  xlab("number of cyliders")

p1 + geom_bar()
# 옆으로 붙여 놓은 막대 그래프
p1 + geom_bar(position = "dodge")
p1 + geom_bar(position = "dodge2") # 간격을 좀 떨어트림.

# 조건부 확률로 쌓아 올린 막대 그래프
p1 + geom_bar(position = "fill")

###################################3

# 상자 그림
ggplot(data = mpg_1 , aes(x= as.factor(cyl), y= hwy))+
  geom_boxplot() + xlab("number of cylinders")

# 그룹을 구성하는 변수가 두 개인 경우의 상자그림
ggplot(mpg_1, aes(x = as.factor(cyl), y= hwy)) +
  geom_boxplot(aes(fill = am)) + xlab("number of cylinders")

# facet
ggplot(mpg_1, aes(x = as.factor(cyl), y= hwy)) +
  geom_boxplot() + 
  xlab("number of cylinders") +
  facet_wrap(~am)

# 좌표계
# 각 요소의 2차원 위치를 결정하는 체계
# coord_cartesian()의 활용
# x축의 범위를 (3,6)으로 축소한 그래프 작성
p <- ggplot(mpg,aes(x=displ,y=hwy))+ geom_point()+
  geom_smooth()
p + coord_cartesian(xlim = c(3,6))

# scale에 의한 xy축 범위 조정
# scale : 자료와 시각적 요소의 매핑 및 xy축과 범례 등의 내용 조정을 의미
# scale 함수의 일반적인 형태 : scale_1_2()
# 1: 수정하고자 하는 시각적 요소; color,x,y,fill 등등
# 2: 적용되는 scale 지칭; discrete,continuous등등

# 간편함수: xlim(3,6), ylim(0,1)
# xy축 라벨 변경 : xlab("engine"), ylab(),labs(x = "engine")

# 함수 xlim()에 의한 조정
# 좌표를 벗어난 데이터를 제외한 상태에서 작성
p + xlim(3,6) + xlab("engine displacement")

# coord_cartesian()에 의한 조정
# 그래프의 데이터를 전부 살리고 지정한 부분만 확대
p + coord_cartesian(xlim = c(3,6)) +
  xlab("engine displacement")

# coord_flip()의 활용 : 평행한 상자그림 작성
# 대부분의 geom 함수 : 주어진 x값에 대한 y의 분포 표현
# 수평 방향 상자그림 : 90도로 그래프 좌표를 회전시킨다.
ggplot(mpg,aes(x=class,y=hwy)) + 
  geom_boxplot()+
  coord_flip()

# 한 변수의 상자그림 작성
ggplot(mpg, aes(x = "", y=hwy)) + 
  geom_boxplot() +
  xlab("")
ggplot(mpg, aes(x = "", y=hwy)) + 
  geom_boxplot() +
  xlab("") +
  coord_flip()

# coord_polar의 활용 : 파이 그래프 작성
# 2차원 공간의 어느 한 점의 위치를 원점에서의 거리와 각도로 표현
# 함수 coord_polar() : 데카르트 좌표를 극좌표로 전환
# 변수 theta : 시각적 요소 x와y중 각도로 전환할 요소 지정, 디폴트(theta = "x")
b2 <- ggplot(mpg, aes(x="", fill = class))+ 
  geom_bar(width = 1)+ # 원으로 만들때 전체를 bar로 잡아줌
  labs(x="",y="")
b2

# coord_polar()실행
b2 + coord_polar(theta = "y")
