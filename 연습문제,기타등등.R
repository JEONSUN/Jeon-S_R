mtcars
mtcars %>%group_by(cyl) %>% ggplot(mapping=aes(x=mpg,y=disp,color=cyl))+geom_point()

mpg
mpg_1 <- mpg %>% mutate(am=substr(trans,1,nchar(trans)-4)) %>% 
  ggplot(mapping=aes(x=cty,fill=am))+geom_bar(position="fill")+facet_wrap(~year,nrow=2)
library(tidyverse)
mpg %>% 
  ggplot(mapping=aes(x=displ,y=hwy,color=year))+geom_point()+geom_smooth(se=FALSE,method="lm")+coord_cartesian(xlim=c(1,6))

mpg %>% 
  ggplot(mapping=aes(x=displ,y=hwy,color=year))+geom_point()+geom_smooth(se=FALSE,method="lm")+coord_cartesian(xlim=c(1,6))





#p.72 문제7
df1 <- tibble(x=1,y=1:9,z=rep(1:3,each=3),w=sample(letters,9))
df1
df1[,df1,y]
#7-1 df1의 두번째 열을 선택하여 벡터로 출력해보자. 기호[[]]와 $을 사용하는 것으로 세 가지 방법이 있다.
df1[,2]
df1[2]
df1[[2]]
df1$y
library(tidyverse)
#p.135 문제1
#데이터 프레임 airquality
#1.1 wind의 값이 mean(Wind) 이상이고 temp의 값이 mean(temp) 미만인 관찰값 선택하여 air_sub1에 할당 변수는 ozone,solar,month만 선택
air_sub1 <-as_tibble(airquality) %>% filter(Wind>=mean(Wind),Temp<mean(Temp))%>%select(Ozone, Solar.R, Month)

#1.2 wind의 값이 mean(wind)미만이고 temp의 값이 mean(temp) 이상인 관찰값 선택하여 air_sub2에 할당 변수는 ozone,solar,month만 선택
air_sub2 <- as_tibble(airquality) %>% filter(Wind<mean(Wind),Temp>=mean(Temp))%>% select(Ozone,Solar.R,Month)
#1.3 두 데이터 프레임 air_sub1과 air_sub2에 있는 두 변수 Ozone과 Solar.R의 평균값 및 케이스의 개수를 계산하여 다음과 같은 결과를 얻자
summarise(air_sub1,n=n(),m_Oz=mean(Ozone,na.rm=TRUE),m_solar.R=mean(Solar.R,na.rm=TRUE))
#1.4
air_sub3 %>% group_by(Month)%>%
  summarise(n=n(),m_oz=mean(Ozone,na.rm=TRUE),)
#1.5 처음 네 변수의 평균 계산
airquality%>% summarise_at(1:4,mean,na.rm=TRUE)
#1.6 처음 네 변수의 평균과 중앙값 계산
airquality%>%summarise_at(1:4,list(m=mean,med=median),na.rm=TRUE)

#문제 2
#데이터 프레임 mtcars
#2.1 rowname을 변수 model을 추가하고 처음 3 케이스 출력
mtcars_t <- rownames_to_column(mtcars,var="model")%>%
as_tibble()%>%
print(n=3)
#2.2 model,mpg,cyl,disp,hp,wt,am만을 선택하여 데이터 프레임 cars에 할당
cars <- mtcars_t %>% select(model:hp,wt,am)
#2.3
#2.4 cars <- mutata(cars,disp_cc)



library(tidyverse)
mpg
mpg_t <- as_tibble(mpg)          
ggplot(data=mpg_t)+
  geom_bar(mappig=aes(x=cyl,y=hwy),stat='identity')

# 연습문제 : mpg의 변수 displ과 hwy의 산점도 drv에 따라 점의 색 구분하고, 비모수 회귀곡선 추가하되, drv=4 인 데이터만 추정
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
  geom_point(mapping=aes(color=drv))+
  geom_smooth(data=filter(mpg,drv==4),se=FALSE,color='red')

ggplot(mpg,mapping=aes(x=trans))+geom_bar()
#auto 끼리 manual 끼리 묶어서 막대 그래프를 그려보자.
mpg %>%mutate(mpg,mapping=aes(x))


#자탐 족보 문제풀이
# 1.1
library(tidyverse)
airs <- as_tibble(airquality) %>% print(n=5)

# 1.2
airquality %>% group_by(Month) %>% summarise(m_Oz=mean(Ozone,na.rm=TRUE))%>%
  ggplot(mapping=aes(x=Month,y=m_Oz),fill="blue")+geom_bar(stat="identity",fill="blue")+ylab("Mean Ozone") #색...

# 1.3
airquality %>% as_tibble() %>% 
  mutate(group=if_else(Wind>=mean(Wind,na.rm=TRUE),"High_Wind","Row_Wind")) %>% 
  ggplot(mapping=aes(x=Solar.R,y=Ozone))+geom_point()+facet_wrap(~group,ncol=2)

# 2
mtcars_t <- mtcars %>% 
  as_tibble() %>% 
  rownames_to_column(var="rowname") %>% 
  rename(model="rowname") %>% 
  select(model,mpg,disp,wt)%>%
  arrange(mpg,desc(disp))%>%#mpg의 값이 가장 작게, mpg의 값이 같은 케이스는 disp의 값이 크게
  print(n=5)

# 2.2.1
mtcars_t %>% mutate(gp_wt=if_else(wt>=median(wt),"Heavy","Not heavy"))%>%
  ggplot(mapping=aes(x=disp,y=mpg,color=gp_wt))+geom_point()+geom_smooth(se=FALSE,method=lm)

# 2.2.2
mtcars_t %>% mutate(gp_wt=if_else(wt>=median(wt),"Heavy","Not heavy"))%>%
  ggplot(mapping=aes(x=disp,y=mpg))+geom_point()+geom_smooth(se=FALSE,method=lm)+facet_wrap(.~gp_wt,ncol=2)


#기말 중간파트
# 1
iris %>% ggplot(mapping=aes(x="",y=Sepal.Width))+geom_boxplot()+coord_flip()+xlab("")

# 2
iris %>%
  group_by(Species) %>%
  ggplot(mapping=aes(x=Sepal.Width,y=Sepal.Length))+geom_point()+geom_smooth(aes(color=Species),se=FALSE)
