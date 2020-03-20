### 1

# 변수 생성하기
speed <- c(4,7,8,9,10,11,12,13,13,14)
dist <- c(2,4,16,10,18,17,24,34,26,26)

# 변수의 기술통계량 계산
# summary : 최소, 최대, 평균, 중앙값, 1사분위수, 3사분위수
# mean() : 평균
# sd() : 표준편차
summary(speed)
mean(dist)
sd(dist)

# 함수 cor로 상관계수 계산
cor(speed,dist)

# use - everything 은 결측값을 전부 na로 계산
# method = c("pearson", "kendall", "spearman")) <- 계산할 상관계수 피어슨,켄달,피어맨중 하나가 될수있음
cor(speed,dist, use ='everything', method = c('pearson','kendall','spearman'))
# all.abs는 결측값이 있을 경우 오류가 발생함
cor(speed,dist, use ='all.obs', method = c('pearson','kendall','spearman'))

# cor 안쓰고 상관계수 구해보기
spe <- sum(speed*dist)
spe1 <- sum(speed^2)
dis1 <- sum(dist^2)
top <- (10*spe)-(sum(speed)*sum(dist))
bot <- sqrt((10*spe1 - sum(speed)^2)*(10*dis1 - sum(dist)^2))
top/bot


cov(speed,dist)/sd(speed)*sd(dist)

# 함수 만드신 분한테 감사를 표하기

# 산점도 작성
plot(speed,dist)

### 2

# 작업하고 있는 디렉토리 확인
getwd()

# 디렉토리 변경
setwd()
# 작업공간이 파일로 저장되면 공간안에 저장된 객체가 자동으로 실행됨.

# 작업공간에 임시 저장된 객체 리스트 확인
# 1) 함수 ls() 실행
ls()

# 2) 우측 상단 environment에서 확인

# plots 창에 그려진 그래프 복사 혹은 저장 방법
# 메뉴 plots -> Save as Image 사용
# plots창 메뉴 export 이용
speed <- c(4,7,8,9,10,11,12,13,13,14)
dist <- c(2,4,16,10,18,17,24,34,26,26)

plot(speed,dist)


