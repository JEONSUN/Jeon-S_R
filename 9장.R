#범주형
str(state.region) #factor 임
state.region[1:10] #factor인데 정수로 저장
state.region

p1 <- ggplot(data=data.frame(state.region))+geom_bar(mapping=aes(x=state.region))
p1
p1+coord_flip()


counts <- table(state.region)
counts
library(tidyverse)
df_1 <- as.data.frame(counts)
df_1
df_1 %>% ggplot(mapping=aes(x=state.region,y=Freq))+geom_col(fill="skyblue")+labs(x="Region",y="count")

#파이 그래프
ggplot(data.frame(state.region))+
  geom_bar(aes(x="",fill=state.region),width=1)+labs(x="",y="")+coord_polar(theta="y")


#
library(scales)
library(tidyverse)
counts <- table(state.region)
df_2 <- as.data.frame(counts) %>% mutate(pct=percent(Freq/sum(Freq)))
df_2


#연습문제 1.4
#범주형 변수 생성
library(MASS)

Carsize <- cut(MASS::Cars93$EngineSize,
breaks=c(0,1.6,2.0,Inf),labels=c("Small","Mid","Large"))
Carsize
data.frame(Carsize) %>%count(Carsize)

ggplot(data.frame(Carsize),mapping=aes(x=Carsize))+geom_bar(fill="tomato")+labs(x="") #ggplot안에 있는 data는 무조건 dataframe형식!

p <- MASS::Cars93 %>% 
  mutate(group=cut(EngineSize,breaks=c(0,1.6,2.0,10),labels=c("Small","Mid","Large"))) %>%
  filter(!is.na(group)) %>% 
  group_by(group) %>% 
  summarise(Freq=n()) %>% 
  mutate(pct=percent(Freq/sum(Freq)))

p %>% ggplot() + geom_bar(aes(x=group,y=Freq),stat="identity")
p %>% ggplot(aes(x="",y=Freq, fill=group)) + 
  geom_col(width=1) + 
  geom_text(aes(label=pct), size=5, position=position_stack(vjust=0.5)) + 
  coord_polar(theta="y")

data.frame(table(Carsize)) %>% #pdf 식
mutate(pct=percent(Freq/sum(Freq))) %>%
  ggplot(aes(x="",y=Freq,fill=Carsize))+
  geom_col(width=1)+geom_text(aes(label=pct), size=5, position=position_stack(vjust=0.5)) + 
  coord_polar(theta="y")+labs(x="")

# 이변량 자료 탐색
# (1) 각 변수의 개별 분포 파악
# (2) 두 변수의 분포 비교
# (3) 두 변수의 관계 탐색

# 이변량 범주형 자료
# 막대그래프 : 쌓아 올린 형태, 옆으로 붙여 놓은 형태
# Mosaic plot

# 이변량 연속형 자료
# 분포 비교를 위한 그래프
# 관계 탐색을 위한 그래프

data(Arthritis,package="vcd")
head(Arthritis) 
#1차원 도수분포표 작성
table <-with(Arthritis,table(Improved))
table

#1차원 상대도수분포표 작성
prop.table(table) #소수점 자릿수 조정 필요
options("digits") #소수점 자릿수 디폴트값 =7
options("digits"=2) #2자리로 조정

prop.table(table)
table1 <- with(Arthritis,table(Treatment,Improved)) # 첫번째변수:행변수
table1

#한계분포 추가
addmargins(table1)

#2차원 상대도수 분할표(결합분포) 작성
prop.table(table1)

#조건변수 분할표
prop.table(table1,1)
prop.table(table1,2)
#요인의 범주 겹치기
library(tidyverse)
data(Arthritis,package="vcd")
with(Arthritis,table(Treatment,Improved))
df_1 <- mutate(Arthritis,Improved=factor(Improved,labe=c("No","Yes","Yes")))
with(df_1,table(Treatment,Improved))

#airquality에서 월별 Ozone의 값이 80이 넘는 날수
with(airquality,table(ozhi=Ozone>80,Month))

#결측값 찾기
with(airquality,
     table(ozhi=Ozone>80,Month,useNA = "ifany"))

#이변량 및 다변량 범주형 자료를 위한 그래프
#쌓아올린 막대 그래프
#원자료 사용
ggplot(Arthritis)+geom_bar(aes(x=Treatment,fill=Improved))

#분할표 사용
table1 <- with(Arthritis,table(Treatment,Improved))
p <- ggplot(data.frame(table1),aes(x=Treatment,y=Freq,fill=Improved))
p+geom_col() #geom_col() = geom_bar(stat="identity")

#옆으로 붙여 놓은 막대 그래프
#원자료 사용
pp<- ggplot(Arthritis,aes(x=Treatment,fill=Improved))
pp+geom_bar(position="dodge")
pp+geom_bar(position="dodge2")

#분할표 사용
p+geom_col(position="dodge")
p+geom_col(position="dodge2")

#상대도수를 이용한 옆으로 붙여 놓은 막대 그래프
ggplot(Arthritis,aes(x=Improved,y=stat(prop),group=1))+geom_bar()+facet_wrap(~Treatment)

#조건부 확률에 의한 쌓아 놓은 막대 그래프
ggplot(Arthritis,aes(x=Treatment,fill=Improved))+geom_bar(position="fill")

#mosaic plot
#두개 이상의 범주형 변수 관계 탐색에 유용한 그래프
#패키지 vcd의 함수 mosaic()으로 작성
#분할표 입력
library(vcd)
mosaic(table1,direction="v")

#원자료 입력:R공식으로 변수 선언
#~변수+변수 형태
mosaic(~Treatment+Improved,data=Arthritis,direction="v")

#반응변수~설명변수 형태
mosaic(Improved ~Treatment,data=Arthritis,direction="v")

str(Titanic)
mosaic(Survived ~ Sex+Age,data=Titanic,direction="v")

mosaic(Survived ~Class+Sex,data=Titanic,direction="v")


#연습문제 1
data <- data.frame(parent=rep(c("yes","no"),each=2),child=rep(c("yes","no"),times=2),num=c(58,8,2,16))  
data
ex9_5 <- ggplot(data,aes(x=parent,y=num,fill=child))+labs(y="")+theme(legend.position="top")  
ex9_5+geom_col()
ex9_5+geom_col(position="dodge")
ex9_5+geom_col(position="fill")
