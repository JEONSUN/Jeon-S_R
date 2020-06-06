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