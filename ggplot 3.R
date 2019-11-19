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
# 1) 한 변수가 이산형인 경우의 예 : ChickWeight의 변수 Time과 Weight
p1+geom_jitter(width=0.2,height=0) #jitter 사용시 어느시간대 집중인지 확인하기위해 폭조정

# 2) 상자그림
class(ChickWeight$Time) # Time 변수가 숫자형 이므로 그룹핑 불가
p1+geom_boxplot(aes(group=Time)) # 시각적 요소 group에 x를 매핑해야함.

# 3) 상자그림과 jittering
p1+geom_jitter(width=0.1,fill="red",shape=21)+
  geom_boxplot(aes(group=Time),outlier.shape=NA,fill=NA,color="blue") 
# flll=NA : 상자그림 내부의 흰색 제거, geom_boxplot을 먼저 실행하고, 그 위에 점을 jittering하면 필요없음.


