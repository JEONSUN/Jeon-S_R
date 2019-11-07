airs_month <- airquality%>%
  group_by(Month)

#1 월별 평수 ozone의 값
airs_month %>%
  summarise(oz_avg=mean(Ozone,na.rm=TRUE))

#2 월별로 날수와 변수 Ozone에 결측값이 있는 날수, 그리고 Ozone이 실제 관측된 날수
airs_month %>%
  summarise(total=n(),na_Oz=sum(is.na(Ozone)),no_miss=sum(!is.na(Ozone)))

#3 월별로 첫날과 마지막 날의 변수 Ozone의 값
airs_month %>% 
  summarise(first_Oz=first(Ozone),last_Oz=last(Ozone))

airquality
airquality%>%filter(Month==5)%>%filter(Ozone==first(Ozone)|Ozone==last(Ozone)) #filter 사용시 이렇게 일일이 달마다 입력해야함

#4 월별로 변수 Ozone의 가장 작은 값과 가장 큰 값
airs_month %>%
  summarise(max_Oz=max(Ozone,na.rm=TRUE),min_Oz=min(Ozone,na.rm=TRUE))

#5 월별로 변수 Ozone의 개별 값이 전체 기간 동안의 평균값보다 작은 날수
m_Oz <- with(airquality,mean(Ozone,na.rm=TRUE)) #with(df,r명령문)
airs_month %>%
  summarise(low_Oz=sum(Ozone <m_Oz,na.rm=TRUE))

#p.135 연습문제

#1.1
air_sub1 <- as_tibble(airquality)%>%
  filter(Wind>=mean(Wind,na.rm=TRUE),Temp<mean(Temp,na.rm=TRUE))%>%
  select(Ozone,Solar.R,Month)
air_sub1
#1.2
air_sub2 <- as.tibble(airquality)%>%
  filter(Wind<mean(Wind,na.rm=TRUE),Temp>=mean(Temp,na.rm=TRUE))%>%
  select(Ozone,Solar.R,Month)
air_sub2
#1.3
air_sub1%>%summarise(n=n(),m_oz=mean(Ozone,na.rm=TRUE),m_solar=mean(Solar.R,na.rm=TRUE))
air_sub2%>%summarise(n=n(),m_oz=mean(Ozone,na.rm=TRUE),m_solar=mean(Solar.R,na.rm=TRUE))
#1.4
air_sub1%>%
  group_by(Month)%>%
  summarise(n=n(),m_oz=mean(Ozone,na.rm=TRUE),m_solar=mean(Solar.R,na.rm=TRUE))
air_sub2%>%
  group_by(Month)%>%
  summarise(n=n(),m_oz=mean(Ozone,na.rm=TRUE),m_solar=mean(Solar.R,na.rm=TRUE))

#2.1
mtcars %>% rownames_to_column(var="rowname") %>% 
  as_tibble()%>%
  rename(model=rowname)%>%
  print(n=3)

#2.2
cars <- mtcars %>% 
  rownames_to_column(var="rowname") %>% 
  as_tibble()%>%
  rename(model=rowname)%>%select((model:hp),wt,am) %>% print()

#2.3
cars %>% mutate(disp_cc=16.4*disp) %>%
  select(-disp) %>% 
  print()

#2.4
cars %>% mutate(disp_cc=16.4*disp) %>%
  mutate(type=if_else(disp_cc<1000,"Compact",
                      if_else(disp_cc<1500,"Small",
                              if_else(disp_cc<2000,"Midsize","Large")))) %>%
  print(n=3)

#2.5
cars %>% mutate(disp_cc=16.4*disp) %>%
  mutate(type=if_else(disp_cc<1000,"Compact",
                      if_else(disp_cc<1500,"Small",
                              if_else(disp_cc<2000,"Midsize","Large")))) %>%
  filter(am==1 & cyl==8)%>%
  select(model,mpg,disp_cc,type) %>% 
  print()

#2.6
cars %>% mutate(disp_cc=16.4*disp) %>%
  group_by(cyl) %>%
  summarise(n=n(),mpg=mean(mpg,na.rm=TRUE),disp_cc=mean(disp_cc,na.rm=TRUE),hp=mean(hp,na.rm=TRUE),wt=mean(wt,na.rm=TRUE))

#3
x.id <- sample(1:nrow(airquality), size=15, replace = FALSE)
sampe_1 <- airquality[x.id[1:10],]
sampe_2 <- airquality[x.id[11:15],]
sampe_1
sampe_2

x.sample <- sample(1:nrow(airquality),size=15,replace = FALSE)
sample1 <- airquality[x.sample[1:10],]
sample2 <- airquality[x.sample[11:15],]
sample1
sample2

# p.171 5장 연습문제

# 1
library(tidyverse)
library(lattice)
barley %>% 
  ggplot(mapping=aes(x=yield,y=variety,color=year))+
  geom_point()+
  facet_wrap(~site) 

# 1.2
barley %>%
  ggplot(mapping=aes(x=yield,y=variety,color=site,shape=year))+geom_point() 
barley %>%
  ggplot(mapping=aes(x=yield,y=variety))+geom_point(mapping=aes(color=site,shape=year)) #위와 같은 방법

# 1.3
barley
barley %>% 
  as_tibble() %>% 
  group_by(variety) %>%
  summarise(mean_yield=mean(yield,na.rm=TRUE)) %>%
  arrange(desc(mean_yield)) #select를 안해줘도 mean yield만 나오는지.. >summarise 는 값 하나 추출

# 2.1
mpg %>% 
  as_tibble() %>% 
  count(fl)

# 2.2
mpg %>% as_tibble() %>% filter(fl %in% c("p","r")) %>% #p와 r만 선택 %in%
  ggplot()+geom_bar(mapping=aes(x=fl,y=stat(prop),group=1)) #stat(prop)는 그룹별 비율을 의미 <group=1을 반드시 지정 해줘야함.

# 2.3
mpg_1 <- mpg %>% as_tibble() %>% filter(fl %in% c("p","r"))
count(mpg_1,trans)   

# 2.4
mpg_2 <-mpg_1 %>% mutate(am=substr(trans,1,nchar(trans)-4))
ggplot(mpg_2)+geom_bar(mapping=aes(x=fl,fill=am),position="fill") 
#fill=am 막대그래프 쌓아올리기 위해선 시각적 요소 x와 fill에 변수 하나씩 대응 시켜야함
#position= fill 을 지정시 모든 막대의 높이 1이 됨.

# 2.5
mpg_2 %>% ggplot()+geom_boxplot(mapping=aes(x=fl,y=hwy))

# 2.6
mpg_2 %>% ggplot()+geom_boxplot(mapping=aes(x=fl,y=hwy))+facet_wrap(~am,nrow=2)+coord_flip()

# 3.1
airquality %>%
  group_by(Month) %>%   
  mutate(Missing=if_else(is.na(Ozone),"TRUE","FALSE"))%>%
  ggplot()+geom_bar(mapping=aes(x=Month,fill=Missing),position="fill")+ylab("Proportion of missing data")

# 3.2
airquality %>%
  group_by(Month) %>% summarise(m_oz=mean(Ozone,na.rm=TRUE)) %>%
  ggplot(mapping=aes(x=Month,y=m_oz))+geom_bar(stat="identity",fill="steelblue")+ #stat(prop)를 사용하는 이유
  ylab("Mean Ozone")

  airquality %>%
  group_by(Month) %>% summarise(m_oz=mean(Ozone,na.rm=TRUE)) %>%                 #왜 y도 사용이 가능한가...
  ggplot()+geom_bar(mapping=aes(x=Month,y=m_oz),stat="identity",fill="steelblue") #stat="identity" 를 사용하는 이유

# 3.3
airquality %>%
  mutate(group_wind=if_else(Wind>=mean(Wind,na.rm=TRUE),"High Wind","Low Wind"),
         group_temp=if_else(Temp>=mean(Temp,na.rm=TRUE),"High Temp","Low Temp")) %>%
  ggplot(mapping=aes(x=Solar.R,y=Ozone))+geom_point()+facet_grid(group_wind~group_temp)

#10.15
library(tidyverse)
mtcars_t <- mtcars %>% 
  as_tibble() %>% 
  rownames_to_column(var="rowname") %>% 
  rename(model="rowname") %>% 
  select(model,mpg,disp,wt)%>%
  arrange(mpg,desc(disp))%>%#mpg의 값이 가장 작게, mpg의 값이 같은 케이스는 disp의 값이 크게
  print(n=5)

mtcars_t %>% mutate(gp_wt=if_else(wt>=median(wt),"Heavy","Not heavy")) %>% 
ggplot(mapping=aes(x=mpg,y=disp))+geom_point(aes(color=gp_wt,size=2))+geom_smooth(aes(color=gp_wt),se=FALSE,method="lm")

mtcars_t %>% mutate(gp_wt=if_else(wt>=median(wt),"Heavy","Not heavy")) %>% 
  ggplot(mapping=aes(x=mpg,y=disp))+geom_point()+geom_smooth(se=FALSE,method=lm)+facet_wrap(~gp_wt,ncol=2)+xlab("노유경 공부해")

#2
mpg
mpg_1 <- mpg %>%
  filter(drv==4)%>% #년도가 2개뿐이라 그룹으로 안묶어도 된다.
  mutate(year=factor(year)) %>% #요인 변환
  select(model,year,displ,cty,hwy)%>%
  arrange(year,desc(displ),cty)%>% 
  print(mpg_1)
#2.2
print(mpg_1)
mpg %>% mutate(gp_displ=displ>=2.0,"high","low")%>%
  ggplot()+geom_jitter(mapping=aes(x=cty,y=hwy,color=gp_displ))+facet_wrap(~year,ncol=1) #색 추가

mpg %>% mutate(gp_displ=displ>=2.0,"high","low")%>%
  ggplot(mapping=aes(x=gp_displ,y=hwy))+geom_boxplot()+facet_wrap(~year,ncol=1)
  
library(tidyverse)
mtcars %>% 
  rownames_to_column(var="rowname") %>% 
  rename(model="rowname")
                        

mtcars %>% as_tibble() %>% rownames_to_column(var="rowname") %>% rename(model="rowname") %>%
  select(model,mpg,disp,wt)%>%arrange(desc(mpg),disp,wt)

p1<- airquality %>% as_tibble() %>% group_by(Month) %>% 
  mutate(Missing=if_else(is.na(Ozone),"TRUE","FALSE")) %>% 
  ggplot()+geom_bar(mapping=aes(x=Month,fill=Missing),position="fill") #stat=identity를 언제 사용해야하는가



