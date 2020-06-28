# 1.
# 변수명 4글자

dfdf <- data.frame('성명' = c('한현수','황병수'), '취미' = c('축구',
                                                   '게임') )
dfdf


# 2.
library(tidyverse)
dfdf <- data.frame('성명' = c('한현수','황병수'), '취미' = c('축구',
                                                   '게임'), '키' = c(168,171) )
dfdf


dfdf %>%
  ggplot(aes(x=성명,y=키)) +
  geom_col(aes(fill = 키))

#3.
nums <- c(0,1,2,3,4)
for(n in 1:500){
  circle <- sample(c(0,1,2),2,replace = T)
  
  
  index <- sum(circle)+1
  nums[index] <- nums[index] +1
  
  probability <- nums/n
  
  barplot(probability,
          names.arg = c(0,1,2,3,4),
          xlab="두 수의 합",
          ylab="확률",
          col=rainbow(5),
  )
}
#4.
library(ggmap)
register_google(key = "AIzaSyB4I4dsUqAj6pisgckesbLpy5JaiLoeSxk")
map <- get_googlemap(center=c('125.a201552043','36.a201552043'))
ggmap(map)


map <- get_googlemap(center = c('125.a201552043','36.a201552043'),
                     maptype = 'roadmap')
ggmap(map)

map <- get_googlemap(center = c('125.a201552043','36.a201552043'),
                     maptype = 'roadmap',
                     zoom=16)

#5.
library(rvest)
url <- "C:/학번/dept.html"
url
html <- read_html(url,encoding = "utf-8")
html
title <- html_nodes(html, "td") %>%
  html_text()
title

#6.
dsae <- xmlToDataFrame(getNodeSet(c201552043,"//info/info"))
dsae

#7.


#8.
