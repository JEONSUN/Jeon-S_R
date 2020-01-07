# 일변량 자료의 요약통계

# 자료의 중심에 대한 요약 통계
# 평균(MEAN) : 일반적인 상황에서 가장 많이 사용되는 요약통계량
# 중앙값(MEDIAN) : 치우침이 심한 분포의 경우 평균보다 분포의 중심을 더 정확하게 나타냄
# 최빈값 (MODE) : 연속형 자료의 경우 큰 의미가 없는 통계

# 예 : faitful의 waiting의 요약통계

attach(faithful)
mean(waiting)
median(waiting)
table(waiting)
my_id <- which.max(table(waiting))
table(waiting)[my_id]
detach(faithful)

#UsingR 데이터 패키지 cfb의 INCOME 변수 분포형태 파악

data(cfb,package="UsingR")
attach(cfb)
mean(INCOME) ;median(INCOME)
detach(cfb)

# 그래프 작성

ggplot(cfb,aes(x=INCOME,y=stat(density)))+
  geom_histogram(bins=15,fill="blue")+
  geom_density(color="red")

# 우측으로 심하게 치우친 분포이므로 로그변환이나 제곱근 변환을 통해 좌우대칭으로 변환 시도해봐야함.
log_income <- log(cfb$INCOME)

range(log_income)
range(cfb$INCOME)

log_income=log(cfb$INCOME+1)
range(log_income)

# 로그 변환된 자료의 분포
ggplot(data.frame(log_income),aes(x=log_income,y=stat(density)))+
  geom_histogram(fill="blue",bins=35)+
  geom_density(color="red",size=1)

mean(log_income) ; median(log_income)


# 연속형 변수의 관계 탐색을 위한 그래프 : 산점도
# 1) 다양한 유형의 산점도 작성
# 기본적인 형태의 산점도 : Cars93 의 weight와 mpg.highway

data(Cars93, package="MASS")
library(tidyverse)

ggplot(Cars93,aes(x=Weight,y=MPG.highway))+geom_point()
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+geom_point(shape=21,color="red",fill="blue",stroke=1.5,size=3)

# 시각적 요소에 세 번째 변수 매핑 : 산점도에서 세 변수의 관계 탐색
# color에 요인 origin 매핑
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=Origin))+geom_point()

# color에 숫자형 변수 enginesize 매핑
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=EngineSize))+geom_point()

# shape에 요인(Origin) 및 숫자형 변수 (EngineSize)
ggplot(Cars93,aes(x=Weight,y=MPG.highway,shape=EngineSize))+geom_point()  # shape에 숫자형 변수의 매핑은 불가능4

# size에 요인 및 숫자형 변수 매핑
ggplot(Cars93,aes(x=Weight,y=MPG.highway,size=EngineSize))+geom_point()  

# 산점도에 회귀직선 추가
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(se=FALSE,method="lm")
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(se=FALSE)

# 회귀직선과 비모수 회귀곡선을 함께 산점도에 추가
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(aes(color="lm"),method="lm",se=FALSE)+
  geom_smooth(aes(color="loess"),se=FALSE)+labs(color="method")

# 산점도에 수평선, 수직선 추가
# 직선 추가 함수: geom_abline(slope,intercept)
# 수직선 추가 함수 : geom_vline(xintercept)
# 수평선 추가 함수 : geom_hline(yintercept)

# 산점도, 회귀직선, 변수 Weight의 평균에 수직선, 변수 MPG.highway의 평균에 수평선
ggplot(Cars93,aes(x=Weight,y=MPG.highway),)+
  geom_point()+ 
  geom_smooth(method="lm",se=FALSE)+
  geom_vline(aes(xintercept=mean(Weight),color="meanWeight"))+ 
  geom_hline(aes(yintercept=mean(MPG.highway),color="meanMPG"))+labs(color="method")

# 산점도의 점에 라벨 추가
# Weight와 MPG.highway의 산점도
# MPG.highway > 40인 점에 라벨 추가
# 라벨 내용 : Manufacturer와 Model의 값 결합한 것
Cars93
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
geom_text(data=filter(Cars93,MPG.highway>40),aes(x=Weight,y=MPG.highway,label=paste(Manufacturer,Model))) #라벨 결합 : paste
# 가장 높은 값 라벨 명 조정이 필요 
# 라벨 위치 조정 : nudge_x & nudge_y 이용
# nudge_x : 양의값 - 우측, 음의값 - 좌측으로 이동
# nudge_y : 양의값 - 위로, 음의값 - 아래로 이동 
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_text(data=filter(Cars93,MPG.highway>40),aes(x=Weight,y=MPG.highway,label=paste(Manufacturer,Model)),nudge_x=100)

# geom_text()에서 주석의 위치와 크기지정
fit <- lm(MPG.highway ~ Weight, Cars93)
r2 <- round(summary(fit)$r.squared,2)
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+geom_smooth(method="lm",se=FALSE)+
  geom_text(x=3500,y=45,size=7,label=paste("R^2==",r2),parse=TRUE)

# 산점도에서 점이 겹쳐지는 문제
# 대규모 자료인 경우
# 두 변수중 한 변수가 이산형인 경우
# 자료가 반올림된 경우
ChickWeight
ggplot(ChickWeight,aes(x=Time,y=weight))+geom_point()
p1 <- ggplot(ChickWeight,aes(x=Time,y=weight))
# 대안 1) 한 변수가 이산형인 경우의 예 : ChickWeight의 변수 Time과 Weight
p1+geom_jitter(width=0.2,height=0) #jitter 사용시 어느시간대 집중인지 확인하기위해 폭조정

# 대안 2) 상자그림
class(ChickWeight$Time) # Time 변수가 숫자형 이므로 그룹핑 불가
p1+geom_boxplot(aes(group=Time)) # 시각적 요소 group에 x를 매핑해야함.

# 대안 3) 상자그림과 jittering
p1+geom_jitter(width=0.1,fill="red",shape=21)+
  geom_boxplot(aes(group=Time),outlier.shape=NA,fill=NA,color="blue") 
# flll=NA : 상자그림 내부의 흰색 제거, geom_boxplot을 먼저 실행하고, 그 위에 점을 jittering하면 필요없음.

# 대규모 자료의 예 : diamonds의 변수 carat과 price의 산점도
library(tidyverse)
ggplot(diamonds,aes(x=carat,y=price))+geom_point()

# carat<3인 자료만을 대상으로 산점도 작성
p1<- ggplot(filter(diamonds,carat<3),aes(x=carat,y=price))
p1+geom_point()
# 대안 1: 점의 크기를 줄이고 투명도를 높이는 것
ggplot(filter(diamonds,carat<3),aes(x=carat,y=price))+geom_point(alpha=0.1,shape=20)

# 대안 2: geom_bin2d()로 2차원 히스토그램 작성
# xy 2차원 공간을 직사각형의 영역으로 구분
# 각 영역에 속한 자료의 개수를 색으로 표현
p1+geom_bin2d()

# 구간 개수 늘리고 색에 변화를 준 그래프
p1+geom_bin2d(bins=100)+
  scale_fill_gradient(low="purple",high="yellow")  # scale_fill_gradient(): two color(low-high) gradient 생성

# scale_*_gradient의 다른 적용 예 : Cars93의 Weight vs MPG.highway의 산점도
library(MASS)
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=EngineSize))+geom_point()+scale_color_gradient(low="purple",high="yellow")
# 연속형 변수 EngineSize를 color에 매핑

# 대안 3 : x축 변수를 범주형으로 변환하고 상자그림 작성
# 숫자형 변수를 요인으로 전환하는 함수 : cut()을 이용한 함수
# cut_interval(x,n) : 벡터 x를 n개의 같은 길이의 구간으로 구분
# cut_width(x,width) : 벡터 x를 길이가 width인 구간으로 구분
# cut_number(x,n) : 벡터 x를 n개의 구간으로 구분하되 각 구간에 속한 데이터의 개수가 비슷하게 구분

# 변수 carat을 시작점을 0, 간격을 0.1로 하는 구간으로 구분
# 각 구간의 자료를 대상으로 side-by-side boxplot 작성
p1+ geom_boxplot(aes(group=cut_width(carat,
                                     width=0.1,boundary = 0)))

# 20개의 구간으로 구분하되, 각 구간에 속한 자료의 개수를 동일하게 유지
p1+geom_boxplot(aes(group=cut_number(carat, n=20))) # 데이터 개수가 많아질수록 boxplot이 좁아짐.

# 이차원 결합확률밀도 그래프
# 두 연속형 변수의 관계탐색에서 큰 역할을 할 수 있는 그래프

# 예: faithful의 eruptions와 waiting의 결합확률밀도 추정

p2 <- ggplot(faithful,aes(x=eruptions,y=waiting))+xlim(1,6)+ylim(35,100)
p2+geom_density_2d() 
# 등고선 그래프
# - 각 등고선에 대한 적절한 라벨 필요
# - 색으로 높이를 구분하는 것이 더 효과적

# 색으로 등고선 높이 표현
p2+geom_density_2d(aes(color=stat(level)))+ #stat(level) : geom_density_2d()에서 계산한 등고선 높이
scale_color_gradient(high="red",low="blue")

# 두 변수의 산점도에 등고선 그래프 추가
p2+geom_point(shape=20)+geom_density_2d(aes(color=stat(level)))+scale_color_gradient(high="red",low="blue")

# 높이가 같은 영역을 구분된 색으로 채우는 그래프 - stat_density_2d()에서 geom="polygon" 사용
p2+stat_density_2d(aes(fill=stat(level)),geom="polygon")+scale_fill_gradient(high="white",low="red")



# 그래프 영역 전체를 타일로 구분
# 확률밀도의 높이에 따라 각 타일의 색을 다르게
# geom="raster" 혹은 "title" 사용
p2+stat_density_2d(aes(fill=stat(density)),geom="raster",contour=FALSE)+scale_fill_gradient(high="yellow",low="black")

# 산점도 행렬
# - 여러 변수로 이루어진 자료에서 두 변수끼리 짝을 지어 작성된 산점도를 행렬 형태로 표현한 그래프
# - 자료 분석에서 필수적인 그래프

# 작성 함수
# - 패키지 GGally의 함수 ggpairs()

# GGally: ggpairs()에 의한 산점도 행렬
# - mtcars의 변수 mpg,wt,disp,cyl,am의 산점도 행렬 작성
# 사용법 : ggpairs(df)
library(GGally)
library(tidyverse)
mtcars
mtcars_1 <- mtcars %>% 
  select(mpg,wt,disp,cyl,am)
ggpairs(mtcars_1)  # 모든 변수는 숫자형
# am,cyl을 요인으로 전환
mtcars_2 <- mtcars_1 %>%
  mutate(cyl=factor(cyl),am=factor(am))
ggpairs(mtcars_2)

# 각 패널에 작성되는 디폴트 그래프
# - 대각선 패널: 숫자형(확률밀도 그래프), 범주형(막대그래프)
# - 대각선 위쪽 패널: 숫자형(상관계수), 범주형(facet 막대 그래프), combo(상자그림)
# - 대각선 아래쪽 패널: 숫자형(산점도), 범주형(facet 막대 그래프), combo(facet 히스토그램)

# 각 패널에 작성되는 디폴트 그래프의 변경
# 대각선 위 아래 패널: 옵션 upper, lower
