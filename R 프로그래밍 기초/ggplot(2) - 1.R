library(tidyverse)
library(ggplot2)
mpg
# 산점도 그리기
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

# 색 추가(class) # 모양 변화(shape) # 크기별 변화(size)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy,color = class, shape = drv,size = cyl))
# 그래프에 너무 많은 정보가 있다 - 좋은 그래프가 아니다.

# 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = drv, shape = drv))

colors()

# 모든 그래프의 점을 빨간색으로
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),color = "red")

# 여러 시각적 요소를 동시에 
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy),shape = 21, color = "blue", fill = "red", size = 3, stroke = 2)
             
# setting과 mapping
# setting
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy),color = "blue")
# mapping - 변수와의 연결을 의미 -변수 이름은 blue라는 값을 갖는 변수 생성 - 
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = "blue"))


##################################################################################
library(tidyverse)
ggplot(data=mpg) + 
  geom_point(mapping=aes(x=displ, y=hwy)) + 
  facet_wrap(~ class)  # class 별로 facet

# class변수의 2seater를 제거하고 그래프 출력
mpg %>% filter(class != "2seater") %>%
  ggplot() + 
  geom_point(mapping=aes(x=displ, y=hwy)) + 
  facet_wrap(~ class)

# 패널 배치 조절
# facet_wrap
pp <- mpg %>%
  filter(class != "2seater") %>%
  ggplot() +
  geom_point(mapping=aes(x=displ, y=hwy))
pp + facet_wrap(~class, ncol=2) # 행별로 정렬
pp + facet_wrap(~class, ncol=2, dir="v") # 열 단위 비교 (열부터 채움) 

# facet_grid
my_plot <- mpg %>%
  filter(cyl != 5, drv != "r") %>%
  ggplot() +
  geom_point(mapping=aes(x=displ, y=hwy))

my_plot + facet_grid(drv ~ .) # drv별로 facet grid
my_plot + facet_grid(. ~ cyl) # cyl별로 ""
my_plot + facet_grid(drv ~ cyl) # drv와 cyl로 

# 4파트로 비슷한 개수로 분리
air_1 <-airquality %>% mutate(Wind_d = cut_number(Wind,4))
air_1 %>% ggplot() +
  geom_point(mapping=aes(x=Solar.R,y=Ozone)) +
  facet_wrap(~Wind_d)

air_1 %>%
  ggplot() +
  geom_point(mapping=aes(x=Solar.R,y=Ozone, color=Wind_d,
                         size=Wind_d))

##############################
# geometric object
# 높은 수준의 그래프 함수 : 좌표축과 주요 그래프 작성
# 점, 선, 문자 등을 추가하여 원하는 그래프 작성

# ggplot2 시스템
# 원하는 유형의 그래프(점 그래프, 선 그래프 등등) 작성
# 해당되는 기하 객체를 사용하여 그래프 작성

# 동일 자료에 다른 geom 적용
# mpg의 변수 displ과 hwy를 대상으로 point geom과 smooth geom 적용
# point geom : 점 그래프 작성
# smooth geom : 비보수 회귀곡선 작성
mpg %>% ggplot(aes(x = displ, y = hwy)) +
  geom_point() 

mpg %>% ggplot(aes(x = displ, y = hwy)) + 
  geom_smooth()

# 글로벌 매핑으로 중복 입력을 방지하자
mpg %>% ggplot(aes(x = displ, y = hwy)) +
  geom_point() + geom_smooth()

# mpg의 변수 displ과 hwy의 비모수 회귀곡선 작성
# 그위에 산점도 추가하되 drv의 값에 따라 점의 색을 구분
mpg %>% ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv)) + 
  geom_smooth(se = FALSE)

# drv값에 따라 선의 색도 구분해보자.
mpg %>% ggplot(aes(x = displ, y = hwy, color = drv)) +
  geom_point() + 
  geom_smooth(se = FALSE)

# drv 그룹별 선의 종류를 다르게 표시하고 
# drv의 값에 따라 점의 색을 구분하고 점의 크기를 확대해보자
mpg %>% ggplot(aes(x = displ, y = hwy)) +
  geom_point(aes(color = drv), size = 2)+ 
  geom_smooth(aes(linetype = drv),se = FALSE)

# drv의 그룹별로 따로 비모수 회귀곡선 작성하되, 선의 색과 종류는 같은 것을 사용
mpg %>% ggplot(aes(x = displ, y = hwy)) +
  geom_point()+ 
  geom_smooth(aes(group = drv),se = FALSE) # group : 그룹을 구성하는 시각적 요소

# mpg의 변수 displ과 hwy의 산점도, drv에 따라 점의 색 구분
# 비모수 곡선 추가하되 drv가 4인 데이터만을 대상으로 추정
mpg %>% ggplot(aes(x= displ , y = hwy)) +
  geom_point(aes(color = drv))+
  geom_smooth(data = filter(mpg, drv==4), 
              se = FALSE, color = "red")

# 
