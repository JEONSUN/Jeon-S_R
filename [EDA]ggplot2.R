ggplot2
library(tidyverse)
#패키지 ggplot2에 있는 데이터 프레임 mpg의 변수 displ과 hwy의 산점도 작성
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy)) #mapping=aes() 시각적 요소
#변수 class의 색 변경
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class)) #aes()밖에서 사용자가 원하는 값으로 지정
#변수 drv의 점 모양 변경
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,shape=drv))
#변수 cyl의 크기 변경
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,size=cyl))
#변수 색, 점모양, 크기 변경
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class,shape=drv,size=cyl))
#변수 색, 점모양 변경
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class,shape=drv))
#모든 점을 빨간색으로
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color='red'))
#여러 요소를 동시에 setting
#점의 내부색-red,점의 외곽선 색- blue,점모양=21,점의 외곽선 두께조절-stroke=2
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy),shape=21,fill='red',color='blue',size=3,stroke=2)
#함수 aes() 안에서 시각적 요소에 특정 값을 setting한 경우의 결과
#mapping <- 시각적 요소와 변수 연결 <- 새로운 변수 'color'가 생성되어 해당 색 blue에 대응하는 red가 나머지 색을 띄게됨
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color='blue'))
#setting <- 사용자가 임의로 지정
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy),color='blue')
# 그룹별 그래프 작성 : Facet
# 범주형 변수가 다른 변수에 미치는 영향력을 그래프로 확인하는 방법
# 시각적 요소에 범주형 변수를 mapping
# 범주형 변수로 그룹을 구성하고, 각 그룹별 그래프 작성 : faceting

# facet을 적용하기 위한 함수
# 1. facet_wrap() : 한 변수에 의한 facet
# 2. facet_grid() : 한 변수 또는 두 변수에 의한 facet

#데이터를 구분하는 변수가 하나인 경우: facet_wrap(~x)
#mpg의 변수 displ과 hwy의 산점도를 class의 범주별로 작성
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_wrap(~class)
#2seater케이스 제외 나머지 class의 범주별 작성
mpg%>%
filter(class !="2seater")%>%
ggplot()+geom_point(mapping=aes(x=displ,y=hwy))+facet_wrap(~class)
#패널 배치 조절
#2x3 패널 배치를 3x2 배치로 수정 ncol=2
#패널에 그래프 배치 순서를 열 단위로 수정 dif='v'
pp <- mpg%>%
  filter(class !="2seater")%>%
  ggplot()+
  geom_point(mapping=aes(x=displ,y=hwy))
pp+facet_wrap(~class,ncol=2)
pp+facet_wrap(~class,ncol=2,dir="v")

# facet_grid()
# 한 변수에 의한 faceting
# 하나의 행으로 패널 배치 : facet_grid(.~x)
# 하나의 열으로 패널 배치 : facet_grid(x~.)
# 두 변수에 의한 faceting
# facet_grid(y~x)
# 행 범주 : y의 범주
# 열 범주 : x의 범주


# 데이터 프레임 mpg에서 데이터 변수 div와 cyl로 구분항 displ과 hwy의 산점도 작성
# 단 drv가 "r" 인 자료와 cyl이 5인 자료 제거
library(tidyverse)
pp <- mpg %>% filter(drv!="r" & cyl!=5) %>% ggplot(mapping=aes(x=displ,y=hwy)) + geom_point() 
pp + facet_grid(drv~.)
pp + facet_grid(~cyl)
pp + facet_grid(drv~cyl)

# 연속형 변수를 범주형 변수로 변환 후 faceting
# cut_interval(x,n) : 벡터 x를 n개의 같은 길이의 구간으로 구분
# cut_width(x,width) : 벡터 x를 길이가 width인 구간으로 구분
# cut_number(x,n) : 벡터 x를 n개의 구간으로 구분하되 각 구간에 속한 데이터의 개수가 비슷하게 구분


# 데이터 프레임 airquality에서 변수 Ozone, Solar.R, Wind의 관계 탐색
# 1. 변수 Wind를 4개 구간으로 구분하되 속한 자료의 개수가 비슷하도록
# 2. 4개의 구간에서 Ozone과 Solor.R의 산점도 작성

airquality %>% mutate(Wind_d=cut_number(Wind, n=4)) %>%
    ggplot() + 
  geom_point(mapping=aes(x=Solar.R, y=Ozone)) +
facet_wrap(~Wind_d)

# 기하 객체 : Geometric object
# Base_graphics에서 그래프 작성 방식 : pen on paper
# 높은 수준의 그래프 함수 : 좌표축과 주요 그래프 작성
# 낮은 수준의 그래프 함수 : 점,선,문자 등을 추가하여 원하는 그래프 작성
# ggplot2에서 그패르 작성 방식
# 작성하고자 하는 그래프 : 몇몇 유형의 그래프(점,선 등등)
# 몇몇 유형의 그래프를 각기 따로 작성
# 작성된 그래프를 겹쳐 놓음으로써 원하는 그래프 작성

# 원하는 유형의 그래프(점,선 등등) 작성
# = 해당되는 기하 객체(geom)을 사용하여 그래프 작성
  

# 기하 객체의 사용
# 해당되는 geom 함수의 실행
# geom 함수 실행 -> 해당 유형의 그래프가 작성된 layer 작성
# 여러 개의 geom 함수 실행 : 여러 layer 생성되고 이것들이 겹쳐져서 원하는 그래프 작성

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy))

#글로벌 매핑과 로컬 매핑
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+geom_smooth(mapping=aes(x=displ,y=hwy))

#글로벌 매핑
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point()+geom_smooth()

#점의 색 추가
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv))+geom_smooth(se=FALSE)
#
ggplot(data=mpg,mapping=aes(x=displ,y=hwy,color=drv))+geom_point()+geom_smooth(se=FALSE)
#drv의 값에 따라 점의 색을 구분,선의 종류를 다르게하며,점의 크기 확대
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv),size=2)+
geom_smooth(mapping=aes(linetype=drv),se=FALSE)

#변수 drv의 그룹별로 따로 비모수 회귀곡선 작성하되, 선의 색과 종류는 같은 것을 사용
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point()+
geom_smooth(mapping=aes(group=drv),se=FALSE)

#각 geom 함수에서 다른 데이터 사용
#mpg의 변수 displ과 hwy의 산점도 drv에 따라 점의색 구분
#비모수 회귀곡선 추가하되 drv가 4인 데이터만을 대상으로 추정
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv),size=2)+
geom_smooth(data=filter(mpg,drv=="4"),se=FALSE,color="red")
