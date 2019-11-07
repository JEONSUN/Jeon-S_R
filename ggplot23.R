#19-10-10 수
#5장 연습문제 1
#1.1
library(tidyverse)
ggplot(barley,mapping=aes(x=yield,y=variety,color=year))+geom_point()+facet_wrap(~site)

#1.2
library(tidyverse)
ggplot(barley,mapping=aes(x=yield,y=variety,color=site,shape=year))+geom_point()

#1.3
barley %>% group_by(variety) %>%
  summarise(mean_yield=mean(yield))%>%
  arrange(desc(mean_yield))

#2.1
mpg %>% count(fl)

#2.2
mpg_1 <- mpg %>% filter(fl %in% c("p","r"))
ggplot(data=mpg_1)+geom_bar(mapping=aes(x=fl,y=stat(prop),group=1))

#2.3
mpg_1 %>% count(trans) #count() 종류별 빈도 확인

#2.4
mpg_2 <- mpg_1%>% mutate(am=substr(trans,1,nchar(trans)-4))
ggplot(data=mpg_2)+geom_bar(mapping=aes(x=fl,fill=am),position="fill")
 
#2.5
ggplot(data=mpg_2)+geom_boxplot(mapping=aes(x=fl,y=hwy))

#2.6
ggplot(data=mpg_2)+geom_boxplot(mapping=aes(x=fl,y=hwy))+facet_wrap(~am,ncol=1)+coord_flip()

#3.1 월별 Ozone의 결측값 비율 그래프
airs <- as_tibble(airquality)
airs %>% mutate(missing= is.na(Ozone))%>%
  ggplot(aes(x=Month,fill=missing))+geom_bar(position="fill")+
  labs(y="proportion of missing data")
#3.2
airs%>%group_by(Month)%>%summarise(avg_Oz=mean(Ozone,na.rm=TRUE))%>% #OZ평균값은 하나이므로 mutate 사용하면 안됨!
ggplot(aes(x=Month,y=avg_Oz))+geom_bar(stat="identity",fill="steelblue")

#3.3
airs%>%mutate(gp_wind=if_else(Wind>=mean(Wind),"High wind","Low wind"),
              gp_temp=if_else(Temp>=mean(Temp),"High temp","Low temp"))%>%
ggplot(aes(x=Solar.R,y=Ozone))+geom_point()+facet_grid(gp_wind~gp_temp)
