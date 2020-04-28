# 데이터 프레임
# 특성
# 행렬과 같은 2차원 구조
# 하나의 열에는 같은 유형의 자료
# 각각의 열은 서로 다른 유형의 자료가 올 수 있음
# 통계 데이터 셋에 적합한 구조

# 데이터 프레임의 생성
df1 <- data.frame(x = c(2,4,6), y=c("a","b","c"))
df1

# 입력된 문자열 벡터를 요인으로 자동 변환
str(df1) # str : 데이터 객체의 구조 확인

# 문자열 벡터가 요인으로 변환되는 것을 막기 위해서는 stringsAsFactors = FALSE 입력
df2 <- data.frame(x = c(2,4,6), y=c("a","b","c"), stringsAsFactors = FALSE)
str(df2)

#데이터 프레임의 행과 열 이름, 변수 개수 확인
# 열(변수) 이름 : 함수 colnames(), names()
# 행 이름 : 함수 rownames()
# 변수 개수 : length()
df2
colnames(df2)
names(df2)
rownames(df2)
length(df2)

# 데이터 프레임의 인덱싱1 : 리스트에 적용되는 방식
# 열(변수) 선택
# df[[a]] 또는 df[a]의 형식 : 벡터 a는 숫자형 혹은 문자형
# df[[a]] : 한 변수의 선택, 결과는 벡터
# df[a] : 하나 또는 그 이상의 변수 선택, 결과는 데이터 프레임
df2 
df2[1] # 데이터 프레임
df2[[1]] # 벡터
df2['x'] # 데이터 프레임
df2[['x']] # 벡터

# 데이터 프레임의 변수 선택
# 벡터 형태로 선택하는 것이 일반적
# df[[a]]의 형태가 더 많이 사용됨
# 조금 더 편한 방법 : $ 기호 사용
df2[['x']]
df2$x

# 데이터 프레임을 조금 더 편하게 사용하기 위한 함수
# 데이터 프레임을 대상으로 하는 통계 분석
# 데이터 프레임의 개별 변수를 벡터 형태로 선택하여 분석 진행
# 인덱싱 기법에 의한 변수 선택 : 매우 번거로운 방법

# 편하게 데이터 프레임에 접근하는 방법
# 함수 attach()
# 함수 with()

# 함수 with()의 사용법
# 일반적인 사용 형태 : with(데이터 프레임, R 명령문)
# with() 안에서는 지정된 데이터 프레임의 변수를 인덱싱 없이 사용 가능
airquality # 미국 뉴욕시의 공기 질과 관련된 데이터
str(airquality)
# 변수 Temp의 표준화
z.Temp <- (airquality$Temp - mean(airquality$Temp))/sd(airquality$Temp)
z.Temp
# with문 사용
z.Temp <- with(airquality, (Temp - mean(Temp))/sd(Temp))
z.Temp

# 함수 attach()의 사용
# 여러 줄의 명령문에서 특정 데이터 프레임을 계속 이용해야 하는 경우
attach(airquality)
mean(Temp); mean(Wind)
sd(Temp); mean(Temp)
detach(airquality)

# 함수 attach() 사용 시 주의할 점
# 데이터프레임의 변수 중 현재 작업 공간에 있는 다른 객체와 이름이 같은 변수가 있는 경우
attach(airquality)
cor(Temp,Wind)
Temp <- c(77,65,89,90)
cor(Temp,Wind) # 길이가 맞지않아 오류가 뜬다
length(Wind)
Temp
detach(airquality)

# 함수 attach()로 불러오는 데이터 프레임의 변수가 현재 작업공간에 있는 다른 객체와 이름이 같으면 경고 문구
Temp <- c(77,65,89,80)
attach(airquality)

Temp
Temp ; mean(Temp)
mean(airquality$Temp)
rm(Temp)
mean(Temp)
