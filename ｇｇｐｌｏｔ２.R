#통계적 변환
#stat="identity" 산점도 
#stat="smooth" 비모수 회귀곡선 
#stat = "count" 막대 그래프 

#geom 함수 대신 stat 함수로 그래프 작성 가능

#mpg의 변수 trans의 막대 그래프 작성
library(tidyverse)
ggplot(data=mpg,mapping=aes(x=trans))+geom_bar()
ggplot(data=mpg,mapping=aes(x=trans))+stat_count()

#stat 함수
#변수 count : 절대 빈도
#변수 prop : 그룹별 비율

#mpg의 변수 trans의 막대 그래프를 상대 도수로 작성
ggplot(data=mpg)+geom_bar(mapping=aes(x=trans,y=stat(prop),group=1)) #각 범주마다 비율이 1이므로 모든 변수가 100%로 인식 
#group을 하나로 묶어줘야함.
ggplot(data=mpg)+geom_bar(mapping=aes(x=trans,y=stat(prop),group=1))


#stat 디폴트 값이 아닌 따로 지정해줘야하는 경우

#geom 함수의 디폴트 stat이 아닌 다른 stat을 사용해야 하는 경우
#auto는 auto끼리 manual은 manual로 통합 도수분포표,막대그래프 작성
#통합된 범주의 도수 분포tibble 작성

mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
  count(am)

#도수분포표로 막대 그래프 작성
ggplot(data=mpg_am)+geom_bar(mapping=aes(x=am,y=n),stat="identity") #stat=identity 입력된 자료 그대로 입력

#위치조정 position adjustments
#연속형 자료: 산점도의 점이 겹쳐지는 경우
#범주형 자료: 이변량 막대 그래프 작성

#mpg에서 변수 cty와 hwy의 산점도 작성
ggplot(data=mpg,mapping=aes(x=cty,y=hwy))+geom_point() #데이터 234개로 보이지않음, 두 변수의 값이 반올림 처리되어 같은 값이 많아짐

#jittering실시
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_point(position="jitter")
#geom_jitter
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_jitter(width=0.05,height=0.4)
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_jitter(width=0.4,height=0.05)

#diamonds에서 변수 carat과 price의 산점도
ggplot(data=diamonds)+geom_point(mapping=aes(x=carat,y=price))

#mpg에서 trans의 범주를 auto와 manual로 통합한 변수 am 생성
#변수 cyl이 5인 케이스 제거 후 am과 이변량 막대 그래프 작성
mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
filter(cyl!=5) #변수 cyl이 5인 케이스 제거

p_1 <- ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),fill=am))+
  xlab("Number of Cylinders")
p_1 +geom_bar() # 막대 그래프 그리기
#옆으로 붙여 놓은 막대 그래프
p_1+geom_bar(position="dodge")
p_1+geom_bar(position="dodge2") #그래프 사이 여백 생김
#cyl을 조건으로 하는 cyl과 am의 조건부 확률
p_1+geom_bar(position="fill")

#19.10.8

# 나란히 서 있는 상자그림
# - geom_boxplot()
# - 필요한 시각적 요소 : x = 그룹을 구성하는 변수(요인)
#                        y = 연속형 변수
library(tidyverse)
mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
  filter(cyl!=5) #변수 cyl이 5인 케이스 제거
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot()+ #as.fctor 사용 안할시 cyl을 요인이 아닌 숫자형 변수로
  xlab('number of cylinder')

#그룹을 구성하는 변수가 두 개인 경우의 상자그림
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot(mapping=aes(fill=am))+ #as.fctor 사용 안할시 cyl을 요인이 아닌 숫자형 변수로
  xlab('number of cylinder') #position='dodge가 디폴트로 적용됨
#그룹을 구성하는 변수가 두 개인 경우의 상자그림
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot(mapping=aes(fill=am))+  
xlab('number of cylinder')+ #position='dodge가 디폴트로 적용됨
facet_wrap(.~am)

# Coordinate System
# 좌표계 : 시각적 요소 x와 y를 근거로 그래프의 각 요소의 2차원 위치를 결정하는 체계
# 좌표계의 종류
# - coord_cartesian() : 디폴트
# - coord_flip() : cartesian 에서 x축, y축을 돌림
# - coord_polar() : 극좌표

# 예:mpg에서 displ과 hwy의 산점도에 비모수 회귀곡선 추가한 그래프 작성,
# x축의 범위를 (3,6)으로 축소한 그래프 작성
p <- ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+geom_point()+geom_smooth()
p
p+coord_cartesian(xlim=c(3,6))     # y축의 범위를 설정할 시엔 ylim=c() 사용!
p+coord_cartesian(ylim=c(20,30))

#scale에 의한 xy축 범위 조정
# - scale : 자료와 시각적 요소의 매핑 및 XY축과 범례 등의 내용 조정을 의미
# - 대부분의 경우 디폴트 상태에서 그래프 작성
# - XY축 범위 조정, XY축 라벨 변경이 필요한 경우네는 scale 함수를 사용하며 조정
# - scale 함수의 일반적인 형태 : scale_*1*_*2*()
#   - *1* : 수정하고자 하는 시각적 요소 : color, x, y, fill 등등
#   - *2* : 적용되는 scale 지정 : discrete,continous 등등 

# 예 : 연속형 X 변수의 범위 (3,6)으로 수정 : scale_x_continous(limits=c(3,6))
# 예 : 연속형 X축의 라벨 변경 : scale_x_continous(name="Engine")

# 간편함수
# - XY축 범위 조정 : xlim(3,6), ylim(0,1)
# - XY축 라벨 변경 : xlab("Engine"), ylab(), labs(x="Engine")

#함수 xlim()에 의한 조정
p+xlim(3,6)+xlab('Engine Displacement') #xlim을 사용할 경우 3,6의 범위에 벗어난 자료 삭제

#함수 coord_certesian()에 의한 조정 
p+coord_cartesian(xlim=c(3,6))+xlab('Engine Displacement')

# 함수 coord_flip()의 활용 : 평행한 상자그림 작성
# - 대부분의 geom 함수 : 주어진 X값에 대한 분포 표현
# - 상자그림 : 수직 방향의 작성되는 것이 디폴트
# - 수평 방향 상자 그림 : 디폴트 방향으로 작성하고, 그래프의 좌표를 90도 회전
# - 함수 coord_flip() : 작성된 그래프의 좌표 회전

# mpg에서 class의 그룹별로 hwy의 상자그림 작성
mpg %>% ggplot(mapping=aes(x=class,y=hwy)) + 
  geom_boxplot() + coord_flip()

# 한 변수의 상자그래프 작성
# - 함수 geom_boxplot()에는 x와y 모두 필요
# - x에는 하나의 값, y에는 연속형 변수 매핑
mpg %>% ggplot(mapping=aes(x="",y=hwy)) + 
  geom_boxplot() + xlab("")
#x와 y축 전환
mpg %>% ggplot(mapping=aes(x="",y=hwy)) + 
  geom_boxplot() + xlab("") + coord_flip()

# 함수 coord_polar()의 활용 : 파이 그래프 작성
# - 극좌표(polar coordinate) : 2차원 공간의 어느 한 점의 위치를 원점에서 거리와 각도로 표헌
# - 함수 coord_polar() : 데카르트 좌표를 극 좌표로 전환
# - 변수 theta : 시각적 요소 x와 y 중 각도로 전환할 요소 지정 (디폴트는 theta="x")
# 함수 cooord_polar()를 활용하여 막대 그래프에서 변형된 그래프

# - Coxcomb 또는 Wind rose 그래프
# - 파이 그래프
# - Bullseye

# mpg의 변수 class의 Coxcomb 그래프 작성
# 막대그래프 작성
# - 각 막대마다 다른 색 사용
# - 막대 사이 간격 제거
# - 범례 제거
b2 <-  mpg %>% ggplot(mapping=aes(x="",fill=class)) + 
geom_bar(width=1) + #geom_bar에서는 y지정하면 안됨. *geom_bar 디폴트y는 count, 지정해야할때는 identity일 경우 
labs(x="",y="")
b2
#thete ="Y"로 함수 coord_polar()실행: 파이 그래프 작성
b2+coord_polar(theta="y")

b2+coord_polar(theta="x")



