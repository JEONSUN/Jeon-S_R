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




