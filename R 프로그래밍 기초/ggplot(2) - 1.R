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
