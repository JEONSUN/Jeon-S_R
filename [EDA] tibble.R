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