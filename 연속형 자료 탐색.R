# 자료 탐색 (2)
# 연속형 자료 탐색

# 일변량 연속형 자료 탐색


# 상자 그림
library(UsingR)
library(tidyverse)
bp <- ggplot(alltime.movies, aes(x="",y=Gross)) + geom_boxplot() + labs(x="")
bp
bp+ coord_flip()

# 이상값으로 표시된 자료 확인
# 함수 ggplot_build()의 결과물 이용
ggplot_build(bp)
# 리스트: 상자그림 작성과 관련된 통계량 및 레이어 정보
my_out <- ggplot_build(bp)[[1]][[1]]$outliers
str(my_out) #outlier로 처리된 Gross 값

# 해당 자료 출력
# 방법1 
alltime.movies
top_movies <- alltime.movies %>% 
  rownames_to_column(var="Top_movies")%>%
  as_tibble() %>% 
  filter(Gross>400)

# 방법2 #정석
(bp_out <- my_out[[1]])
top_movies <- alltime.movies %>% 
  rownames_to_column(var="Top_movies")%>%
  as_tibble() %>% 
  filter(Gross%in%bp_out)

Top_movies

# 상자그림에 자료의 위치를 점으로 표시
# 함수 geom_point() 추가
# 상자그림에서 이상값을 원으로 표시하는 것 중지 : 자료의 점과 겹쳐짐. outlier.shape=NA추가

bp1<- ggplot(alltime.movies,aes(x="",y=Gross))+geom_point()+geom_boxplot(outlier.shape=NA)+labs(x="")
bp1
bp1 + geom_point(color='red') #자료의 점이 겹쳐지므로 geom_jitter 사용해야함!

# geom_jitter()로 상자그림에 자료 위치 표시
bp1 + geom_jitter(color='red',width=0.01)

# 상자그림에 평균값 위치 표시
# 함수 stat_summary(): 자료의 요약 통계량을 그래프에 표시 
# 하나의 x값에 대하여 주어진 y의 요약 통계량 값 계산
# 원하는 요약 통계량 : 변수 fun.y에 지정
# 원하는 그래프 형태 : 변수 geom에 지정

ggplot(alltime.movies,aes(x="",y=Gross))+
  geom_boxplot()+
  stat_summary(fun.y="mean",geom="point",
               color="red",shape=3,size=4,stroke=2)+
  labs(x="")

# violin plot 그리기
library(vioplot)
attach(alltime.movies)
vioplot(Gross)
vioplot(Gross,col="red")
vioplot(Gross,horizontal = TRUE,col="green")
detach(alltime.movies)

# 히스토그램
# geom_histogram()
# 히스토그램의 구간 조절 : bins(구간의 개수) 혹은 binwidth(구간 폭)

# faithful의 waiting 변수 사용
h<- ggplot(faithful,aes(x=waiting))
h+geom_histogram()
h+geom_histogram(bins=20) # 구간 개수
h+geom_histogram(binwidth=3) # 구간 폭

# 확률밀도함수 그래프
# 연속형 자료의 분포 표현에 가장 적합한 그래프
# - 함수 geom_density()로 작성


# faithful의 waiting 변수 사용
p <-  ggplot(faithful,aes(x=waiting))+
  geom_density(fill="steelblue") # 디폴트 형태 #끝까지 연결 되어있지않음
p+xlim(30,110) # x축 구간 확대 : 함수 xlim() 사용

# 히스토그램과 겹치게 사용

ggplot(faithful,aes(x=waiting,y=stat(density)))+
  geom_histogram(fill="red",binwidth=5)+
  geom_density(color="blue",size=1)+
  xlim(30,110)

#geom_density와 geom_histogram의 순서를 바꾸면 히스토그램과 겹치는부분에 선이 안보임
# 옵션 alpha : 그래프 투명도 조절 [0,1] 범위에서 값이 작아지면 투명도 증가
ggplot(faithful,aes(x=waiting,y=stat(density)))+
  geom_density(color="blue",size=1)+
  geom_histogram(fill="red",binwidth=5,alpha=0.6)+ 
  xlim(30,110)
