# ex 4.1.1)
library(tidyverse)
air_sub1 <- filter(airquality,Wind >= mean(Wind), Temp < mean(Temp))%>%
  select(Ozone,Solar.R,Month)
air_sub1

# 4.1.2)
air_sub2 <- filter(airquality, Wind < mean(Wind), Temp >= mean(Temp))%>%
  select(Ozone,Solar.R,Month)
air_sub2

# 4.1.3)
air_sub1 %>% summarise(n = n(), m_oz = mean(Ozone,na.rm = TRUE), m_solar = mean(Solar.R,na.rm=TRUE))
air_sub2 %>% summarise(n = n(), m_oz = mean(Ozone,na.rm = TRUE), m_solar = mean(Solar.R,na.rm=TRUE))

# 4.1.4)
air_sub1 %>% group_by(Month) %>% 
  summarise(n = n(), m_oz = mean(Ozone,na.rm = TRUE), m_solar = mean(Solar.R, na.rm = TRUE))
   
air_sub2 %>% group_by(Month) %>% 
  summarise(n = n(), m_oz = mean(Ozone,na.rm = TRUE), m_solar = mean(Solar.R, na.rm = TRUE))

# 4-2-1)
mtcars_t<- mtcars %>% 
  rownames_to_column(var = "model") %>% 
  as_tibble() %>% 
  print(n=3)
# 4-2-2)
cars <- mtcars_t %>% 
  select(1:5,wt,am) %>%
  print()
# 4-2-3)
cars<- cars %>% 
  mutate(disp_cc = disp * 16.4)%>% 
  select(!disp) %>% 
  print()

# 4-2-4)
cars<- cars %>% mutate(type = if_else(disp_cc < 1000, "Compact", 
                               if_else(disp_cc < 1500, "Small",
                                       if_else(disp_cc < 2000,"Midsize", "Large")))) %>% print()
# 4-2-4) 
cars <- cars %>% mutate(type = cut(disp_cc,breaks = c(0,1000,1500,2000,10000), 
                                   include.lowest = TRUE, right = FALSE, 
                                   labels = c("Compact","Small","Midsize","Large"))) %>% print()
# 4-2-5)
cars %>% filter(am == 1 & cyl == 8) %>% 
  select(model,mpg,disp_cc,type)
  
# 4-2-6)
cars %>% group_by(cyl) %>%
  summarise(mean_mpg= mean(mpg) , mean_disp= mean(disp_cc),mean_wt = mean(wt))

# 4-3)
# base R 함수 sample()에 의한 방법
sample(1:5, size = 3)
sample(1:5, size = 3, replace = TRUE) # 복원 추출

my_index <- sample(1:nrow(iris), size = 3)
iris[my_index,]

library(tidyverse)
x1 <- sample(1:nrow(airquality), size=15, replace = FALSE) # airquality의 row의 개수를 크기 15로 조절하여 비복원 추출
x1
airquality[x1[1:10],] # 비복원 추출한 nrow를 각각 1부터 10번째 row, 11부터 15번째 row까지 airquality에서 인덱싱
airquality[x1[11:15],]

air_t <- as_tibble(airquality)
sample_n(air_t,size = 10 )
sample_n(air_t,size = 5 )


# 5장 연습문제
library(tidyverse)
library(lattice)

# 5-1-1
barley %>% ggplot(aes(x= yield,y=variety, color = year))+
  geom_point()+
  facet_wrap(~site)
  
# 5-1-2
barley %>% ggplot(aes(x= yield,y=variety, shape = year, color = site))+
  geom_point()

# 5-1-3
barley %>% 
  group_by(variety) %>% 
  summarise(mean_yield = mean(yield,na.rm=TRUE)) %>% 
  arrange(desc(mean_yield))

# 5-2-1
# fl별 종류별 빈도
mpg %>% count(fl)

# 5-2-2
mpg_1 <- mpg %>% filter(fl %in% c("p","r"))
mpg_1%>%
  ggplot()+ geom_bar(aes(x=fl,y=stat(prop),group=1))


# 5-2-3
mpg %>% count(trans)

# 5-2-4
mpg_2 <- mpg_1 %>% mutate(am = substr(trans,1,nchar(trans)-4))
mpg_2 %>% ggplot() +
  geom_bar(aes(x=fl,fill=am), position = "fill")

# 5-2-5
mpg_1 %>% ggplot() +
  geom_boxplot(aes(x=fl,y=hwy))

# 5-2-6
mpg_2 %>% ggplot() +
  geom_boxplot(aes(x=fl,y=hwy))+
  facet_wrap(~am,ncol = 1)+
  coord_flip()
