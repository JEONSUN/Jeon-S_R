# 변수 선택 select
# mtcars에서 row names를 변수 rowname으로 전환하고 변수 rowname과 mpg 선택
library(tidyverse)
mtcars_t <- mtcars%>%rownames_to_column(var = "rowname") %>% as_tibble()
mtcars_t

select(mtcars_t,rowname,mpg)

# mtcars_t의 mpg부터 wt까지 모두 선택
select(mtcars_t,mpg:wt)
select(mtcars_t,2:7)

# rowname과 qsec에서 carb까지 제거
select(mtcars_t,-rowname,-(qsec:carb))
select(mtcars_t,-1,-(8:12))

# 문자열 매칭 함수
# mtcars_t에서 "m"으로 시작되는 변수 선택
select(mtcars_t,starts_with("m"))
# "p"로 이름이 끝나는 변수 선택
select(mtcars_t,ends_with("p"))
# "a"가 이름에 있는 변수 선택
select(mtcars_t,contains("a"))

# iris에서 pe가 이름에 있는 변수 선택
names(iris)
iris_t <- as_tibble(iris)
select(iris_t,contains("pe")) 
# 소문자와 대문자를 구분하지 않음
# ignore.case = TRUE가 디폴트이기 때문
# 소문자, 대문자 구분하기
select(iris_t,contains("pe", ignore.case =FALSE)) 
# pe가 이름에 있는 변수 제거
select(iris,-contains("pe"))
select(iris,-contains("pe",ignore.case = FALSE))
# Sp가 이름이 시작되는 변수 제거
select(iris,-starts_with("Sp"))
# th로 이름이 끝나는 변수 제거
select(iris,-ends_with("th"))

# 변수 배열 변경: 몇몇 변수를 제일 앞으로 옮겨 배치
# iris에서 마지막 변수 Species를 첫 번째 변수로 재배열
# everything()
select(iris,Species,everything())

# 변수 이름 수정
# select() : 이름이 명시되지 않는 변수는 자동 제거
# rename() : 변수 이름 수정에는 더 효과적

# 데이터 프레임 mtcars_t에서 변수 rowname을 model로 수정
# select에 의한 수정
select(mtcars_t, model=rowname) # model만 살아남아있음
# rename에 의한 이름 수정
rename(mtcars_t,Model=rowname)

##########################################################3
# 새로운 변수의 추가 mutate
# mtcars에 kml과 gp_kml생성하고 데이터 프레임에 두 변수 추가
# kml : 1 mpg는 0.43kml
# gp_kml : kml이 10이상이면 good 10미만이면 bad
mtcars_t <- as_tibble(mtcars)
mtcars_t <- mutate(mtcars_t, kml = mpg*0.43,
       gp_kml = if_else(kml >= 10, "good","bad"))
# 생성된 두 변수의 위치 이동
mtcars_t %>% select(kml,gp_kml,everything())

# 새로운 변수만 유지하고 나머지 변수 모두 삭제
# transmute() 사용
transmute(mtcars_t,
          kml = mpg*0.43,
          gp_kml = if_else(kml>=10,"good","bad"))