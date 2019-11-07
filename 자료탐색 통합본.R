#논리>숫자>문자 
#행렬은 하나의 요인만 사용가능 , 데이터프레임 -2차
#1차원 구조 : 하나의 변수를 나타내기 위한 1차원 구조 ex)백터 
#2차원 구조 : 배열은 2차원 이상의 구조를 가진 데이터 형태 ,행렬 ,데이터프레
#3차~ array배열, 리스트
x = c(1,"1",T)
x
str(x)

#기존의 데이터 프레임을 tibble로 전환 as_tibble()
library(tidyverse)
cars
as_tibble(cars)
#개별 벡터를 이용한 tibble 생성 ,길이가 1일 경우에만 순환법칙 적용
tibble(x=1:3,y=x+1,z=1)
#데이터프레임에서는 적용불가

#순환법칙
x=1:4
y=c(2,4)
x+y
#대응되는 길이가 다를 경우 짧은 쪽에서 반복해서 계산
x=c(1,2)
y=c(3,4,5,6)
x+y

letters

library(tidyverse)
#행단위로 입력하여 tibble 생성
tribble(~x,~y,1,"a",2,"b",3,"c")

# mass패키지 안에 있는 cars93만 불러와라
#패키지 base패키지,추천 패키지, 내가다운패키지
data(Cars93, package="MASS")
Cars93

#처음 10개 케이스만 출력
as_tibble(Cars93)

#변수 이름과 더불어 변수의 유형을 함께 표시
#cars93의 모든 변수를 나타내는 대신 3줄만 표시하라
print(as_tibble(Cars93), n=3, width=Inf)

#전통적 데이터 프레임 - 자료출력시 row name 함께 출력 ㅡ tibble은 생략
#head 처음 6개 케이스 출력
head(mtcars) 

#row name 제거
mtcars_t <- as_tibble(mtcars)
print(mtcars_t, n=6)

#생략된 row name 변수로 전환
mtcars_d <- rownames_to_column(mtcars, var='rownames')
mtcars_t <- as_tibble(mtcars_d)
mtcars_t

#인덱싱(대괄호)안에 들어가는 것들 정수형 벡터(양수-위치,음수-해당위치 제거), 논리형 벡터(선택시 true, 제거시 false)
#예전 데이터프레임 부분매칭 허용

df1 <- data.frame(xyz=1:3, abc=letters[1:3])
df1$x

#tibble 부분 매칭 불
tb1 <- as_tibble(df1)
tb1$x

#,사용시 행렬 인덱싱 방식

mtcars[, 1:2] 
mtcars[,1]

#tibble에서 변수의 개수 관계없이 항상 tibble 유지
mtcars_t[,1:2]
mtcars_t[,1]
mtcars_t[1,1]

tibble(x=1, y=1:9,z=rep(1:3,each=3))
tibble(x=1, y=1:9,z=rep(c(1,2,3),each=3))

#dplyr
#mtcars에서 mpg가 30이상인 자동차 선택
filter(mtcars_t,mpg>=30)
#mtcars에서 mpg가 30이상이며 wt가 1.8미만인 자동차 선택
filter(mtcars_t,mpg>=30 & wt<1.8)
#변수 mpg가 30이하, 변수 cyl이 6 또는 8, 변수 am이 1인 자동차 선택
filter(mtcars_t,mpg<=30, cyl%in% c(6,8),am==1)
#변수 mpg의 값이 mpg의 중앙값과 q3사이에 있는 자동차 선택
filter(mtcars_t,mpg>=median(mpg) & mpg<=quantile(mpg,probs=0.75))
#between사용하여 특정 수 숫자 사이에 있는지 확이
filter(mtcars_t,between(mpg,median(mpg) ,quantile(mpg,probs=0.75)))

#변수 Ozone 또는 Solar.R의 결측값만 추출
airquality
airs<- as_tibble(airquality)
filter(airs, is.na(Ozone)|is.na(Solar.R))
#특정 변수의 값이 중복된 케이스 제거
#1,2,3이 각각 처음으로 나와 중복이 아닐경우엔 false로 나온다
df1 <- data.frame(id=rep(1:3 , time=2:4),x1=1:9)
df1
duplicated(df1$id)
filter(df1,!duplicated(id))
#모든 변수의 값이 중복된 행 제거
df2 <- data.frame(id=rep(1:3,each=2), x1=c(2,2,3,1,4,4))
df2
duplicated(df2)

iris
#sample_n <- 추출하고자 하는 행의 개수
#sample_frac <-  추출하고자 하는 행의 비율
#임의로 3개 행 추출
iris_t <- as_tibble(iris)

sample_n(iris_t,size=3)

my_index <- sample(1:nrow(iris),size=3)
iris[my_index,]
sample_frac(iris_t,size=0.05)
#base r 함수 sample()에 의한 방법
sample(1:5, size=3)
#복원추출을 할경우 replace 추가
sample(1:5, size=3 ,replace=TRUE)

#특정 변수의 값이 가장 큰(작은) 관찰값 선택
#top_n(df,n,wt) -n이 양수 wt 값이 가장 큰 관찰값 ,음수 일시 wt 값이 가장 작은값
#iris데이터에서 sepal.width의 가장 큰 두관찰값, 작은 두관찰값을 구하라!
top_n(iris_t,n=2,wt=Sepal.Width)
top_n(iris_t,n=-2,wt=Sepal.Width)

#관찰값 정렬 arrange()
#arrange(df,var_1,var_2,~) var1 <- 정렬기준변수 var2 <- var1의 값이 같은 관찰값의 정렬기준
#변수 mpg의 값이 가장 좋지 않은 자동차부터 재배열
mtcars_t <- as_tibble(mtcars)
arrange(mtcars_t,mpg)

#5월 1일부터 5월 10일까지의 자료만을 대상으로 변수 Ozone의 값이 가장 낮았던 날부터 재배열
airs <- as_tibble(airquality)
airs_1 <- filter(airs,Month==5,Day<=10)
arrange(airs_1,Ozone)
#데이터프레임 airs_1을 변수 Ozone이 결측값인 케이스를 가장 앞으로 배열
arrange(airs_1,is.na(Ozone))
#데이터프레임 airs_1을 변수 Ozone이 가장 높은 날부터 배열하되 결측값이 있는 케이스를 가장 앞으로 배치
arrange(airs_1, !is.na(Ozone))
#Ozone의 값이 가장 높은 날부터 재배열하되 결측값이 있는 케이스를 가장 앞으로 배열
arrange(airs_1, !is.na(Ozone),desc(Ozone))

#변수의 선택 select()
#mtcars의 row names를 변수 rowname으로 전환하고 변수 rowname과 mpg선택
mtcars_d <- rownames_to_column(mtcars,var="rowname")
mtcars_t <- as_tibble(mtcars_d)
select(mtcars_t,rowname,mpg)
#데이터 프레임 mtcars_t의 두번째 변수 mpg부터 일곱번째 변수 wt까지 모두 선택
select(mtcars_t,mpg:wt)
#데이터 프레임 mtcars_t에서 변수 roname과 qsec에서 carb까지 제거
select(mtcars_t, -rowname,-(qsec:carb))


#19-09-17 수업

#변수가 많은 경우 선택하고자 하는 변수의 이름을 일일이 나열하는 것은 상당히 비효율적
library(tidyverse)
mtcars_t <- as_tibble(mtcars)
#mcars_t에서 m으로 시작되는 변수 선택
select(mtcars_t,starts_with("a"))
#p로 이름이 끝나는 변수 선택
select(mtcars_t,ends_with("p"))
#a가 이름에 있는 변수 선택
select(mtcars_t,contains("a"))

#예제 iris
#iris 변수 이름
names(iris)
#pe가 이름에 있는 변수 선택
#pe,PE동시 선택 <- 대문자 소문자 구분하지않음
select(iris,contains("pe"))
#대문자,소문자 구분 옵션 <- ignore.case
select(iris,contains("pe",ignore.case = FALSE))

#pe가 이름이 있는 변수 제거
#변수제거,마이너스 옵션
select(iris,-contains("pe",ignore.case = FALSE))
#sp로 이름이 시작되는 변수 제거
select(iris,-starts_with("sp"))
#th로 이름이 끝나는 변수 제거
select(iris,-ends_with("th"))

#변수 배열 변경 몇몇 변수를 제일 앞으로 옮겨서 다시 배치
#데이터 프레임 iris에서 마지막 변수 species를 첫번째 변수로 재배열 <- 함수 everything()
select(iris,Species,everything())

#select() 이름이 명시되지않는 변수는 자동 제거
#rename() 변수 이름 수정에는 더 효과적
mtcars_t <- rownames_to_column(mtcars,var='rowname') #rownames를 변수로 전
mtcars_t <- mtcars_t
rename(mtcars_t,Model=rowname)
mtcars_t
#새로운 변수의 추가 <- mutate(df,새로운 변수 생성 표현식)
#변수 kml과 gp_kml을 생성하고, 데이터 프레임의 처음 두 변수로 추가
#if_else는 조건 충족시 처음 값 <- good 불충족시 <- bad
mtcars_t<- mutate(mtcars_t,kml=mpg*0.43,gp_kml=if_else(kml>=10,"good","bad"))
#처음 두 변수로 추가
select(mtcars_t,kml,gp_kml,everything())

#새로운 변수만 유지하고 나머지 변수 모두 삭제 <- transmute()
mtcars_t <- as_tibble(mtcars_t)
transmute(mtcars_t,kml,gp_kml)
#그룹 생성 및 그룹별 자료 요약 group_by, summarise()
#함수 summarise(df,name=fun):변수의 요약 통계량 계산
#결과 tibble name:계산된 통계량 값의 이름

#데이터 프레임 mpg의 변수 hwy의 평균 계산
summarise(mpg,hwy_mpg=mean(hwy))
#n() 케이스의 개수
#n_distinct() 서로 다른 숫자의 개수
summarise(mpg,n=n(),n_hwy=n_distinct(hwy),avg_hwy=mean(hwy),as_hwy=sd(hwy))

#함수 group_by(df,var)
#한 개 이상의 변수로 데이터 프레임 을 그룹으로 구분
#데이터 프레임 mpg를 변수 cyl에 따라 그룹으로 구분하고, 각 그룹에 속한 케이스의 개수 및 각 그룹별 변수 hwy의 평균값 계산
by_cyl <- group_by(mpg,cyl)# <- 분석 중간 단계에서 생성되는 객체, 객체 자체로는 큰의미가 없으며 복잡한 분석에서는 무수히 발생 
#pipe 기능 필요
summarise(by_cyl,n=n(),avg_mpg=mean(hwy))

#pipe 기능 한 명령문의 결과물을 바로 다음 명령문의 입력 요소로 사용 할 수 있도록 명령문을 서로 연결하는 기능
#pipe 연산자
mpg%>%group_by(cyl)%>%
  summarise(n=n(),avg_mpg=mean(hwy))

#예제 airquality
#pip기능을 사용하여 다음을 구하라
#1)월별 변수 ozone의 평균값,월별 날수, 2)변수 ozone에 결측값이 있는 날수 및 실제 측정이 된 날수, 
#3)월별 첫날과 마지막날 변수ozone의값, 4)월별 변수 ozone의 가장 작은 값과 가장 큰값
#5)월별로 변수 ozone의 개별 값이 전제 기간동안의 평균값보다 작은 날수
airs_month <- airquality%>%group_by(Month)
#1)
airs_month%>%summarise(avg_Oz=mean(Ozone,na.rm=TRUE))
#2)
airs_month%>%summarise(n_total=n(),n_miss=sum(is.na(Ozone)),n_obs=sum(!is.na(Ozone)))
#3)필요한 함수 first(),last(),nth()
airs_month%>%summarise(first_Oz=first(Ozone),last_Oz=last(Ozone))      
#4)
airs_month%>%summarise(max_Oz=max(Ozone,na.rm=TRUE),min_Oz=min(Ozone,na.rm=TRUE))
#5)
#with()사용하여 변수 오존의 전체기간동안의 평균값 계산
m_oz <- with(airquality,mean(Ozone,na.rm=TRUE))
m_oz
airs_month%>%summarise(low_oz=sum(Ozone<m_oz,na.rm=TRUE))


19-9-19
#선택된열을 대상으로 하는 함수
#모든 열을 대상으로 작업summarise_all
#사용자가 선택한 열만을 대상으로 작업 summarise_at
#특정 조건을 만족하는 열에만 적용summarise_if
library(tidyverse)
summarise_all(women,mean)
summarise_all(women,list(m=mean))
summarise_all(women,list(mean,median))
summarise_all(women,list(m=mean,med=median))
summarise_all(women,list(~mean(.),~median(.)))

#airquality의 각 변수의 결측값 개수 확인
summarise_all(airquality,list(~sum(is.na(.))))
summarise_all(airquality,list(na=~sum(is.na(.))))

#summarise_at
#선택할 변수 단순 나열: 함수c()사용
iris %>% summarise_at(c("Sepal.Length","Sepal.Width"),mean)
#문자열 매칭 함수에 의한 변수 선택: 함수var()사용
iris %>% summarise_at(vars(ends_with("th")),mean)
#요약통계량이 두 개 이상인 경우
iris %>% summarise_at(c("Sepal.Length","Sepal.Width"),list(mean,median))

#summarise_if()
#모든 변수의 평균 계산
summarise_all(iris,mean)
#"Sp"로 시작되는 변수를 제외한 모든 변수의 평균 계산
iris%>%select(-starts_with("Sp"))%>%summarise_all(mean)
#is.numeric <- ->is.na
#숫자형 변수만 평균 계산
iris%>%summarise_if(is.numeric,mean)
#iris 꽃잎과 꽃받침은 cm단위로 측정, 이것을 인치 단위로 변환
iris_t <- as_tibbe(iris)
iris_t %>% select_if(is.numeric)%>%
mutate_all(list(~./2.54))%>%            #기존의 자료가 변환된 자료로 대치됨
print(n=3)
#생성되는 변수에 이름 지정
iris_t %>% mutate_if(is_numeric,list(inch=~./2.54))%>%
  print(n=3,width=Inf)

#iris 케이스 선택 조건이 모든 변수를 대상으로 하는 경우
#어느 변수라도 1 미만의 값을 갖는 행 선택
iris_t %>%
  filter_if(is.numeric,any_vars(.<1)) %>% #any_vars -어느 변수라도, 적어도 하나의 결과가 true이면 true
  print(n>3) #all_vars 생성된 결과가 모두 true인 경우 true
#이름에 Len이 있는 변수의 자료가 모두 6.5 이상이 되는 행 선택
iris_t %>%
  filter_at(vars(contains("Len")),all_vars(.>=6.5))

