library(tidyverse)
library(MASS)

# 1
car <- Cars93 %>% as_tibble() %>%
  dplyr::select("Manufacturer","Model","MPG.highway","Cylinders",
           "Weight","Origin") %>%
  print(n=3)

# 2
car <- car %>% mutate(make = paste(Manufacturer, Model,sep=" ")) %>%
  dplyr::select("make","MPG.highway","Cylinders","Weight","Origin")%>%
  print(n=3)

# 3-1
car %>% group_by(Cylinders) %>%
  summarise(n = n())

# 3-2
car <- car %>% filter(Cylinders %in% c(4,6,8))%>%
  print()

# 4
car %>% ggplot(aes(x= MPG.highway,y= Weight)) +
  geom_point()

# 4-2
# mpg.highway가 증가할수록 weight는 더 적어지는 추세를 보인다.

# 5
  car %>% arrange(desc(MPG.highway)) %>%
  dplyr::select(make, MPG.highway) %>%
  head(n=2)

# 6
car %>%
  ggplot(aes(x = Cylinders, fill = Origin)) +
  geom_bar(position = "dodge",width = 0.8)

# 6-1
ggplot(data=car)+
  geom_bar(mapping=aes(x=Cylinders, y=stat(prop),group=1))+
  facet_wrap(~Origin)

# 7
ggplot(car, aes(x=Cylinders, y = MPG.highway))+
  geom_boxplot()

# 8
ggplot(car, aes(x=Cylinders, y = MPG.highway,fill=Origin))+
  geom_boxplot()


#9
ggplot(car, aes(x=MPG.highway, y =Weight ))+
  geom_point() +
  facet_grid(Cylinders~Origin)


