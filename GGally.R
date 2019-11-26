# 산점도 행렬
# - 여러 변수로 이루어진 자료에서 두 변수끼리 짝을 지어 작성된 산점도를 행렬 형태로 표현한 그래프
# - 자료 분석에서 필수적인 그래프

# 작성 함수
# - 패키지 GGally의 함수 ggpairs()

# GGally: ggpairs()에 의한 산점도 행렬
# - mtcars의 변수 mpg,wt,disp,cyl,am의 산점도 행렬 작성
# 사용법 : ggpairs(df)
library(GGally)
library(tidyverse)
mtcars
mtcars_1 <- mtcars %>% 
  select(mpg,wt,disp,cyl,am)
ggpairs(mtcars_1)  # 모든 변수는 숫자형
# am,cyl을 요인으로 전환
mtcars_2 <- mtcars_1 %>%
  mutate(cyl=factor(cyl),am=factor(am))
ggpairs(mtcars_2)

# 각 패널에 작성되는 디폴트 그래프
# - 대각선 패널: 숫자형(확률밀도 그래프), 범주형(막대그래프)
# - 대각선 위쪽 패널: 숫자형(상관계수), 범주형(facet 막대 그래프), combo(상자그림)
# - 대각선 아래쪽 패널: 숫자형(산점도), 범주형(facet 막대 그래프), combo(facet 히스토그램)

# 각 패널에 작성되는 디폴트 그래프의 변경
# 대각선 위 아래 패널: 옵션 upper, lower
# 대각선 패널 욥선 diag=list(continuous=,discrete=)
# 그래프 작성의 디폴트 값 변경 wrap()



# 변경 내용
# - 대각선 아래쪽 패널 수정
# - 숫자형 변수: 산점도에 회귀직선 추가
# - combo: facet 히스토그램의 구간 개수를 10개로 지정

# 시각적 요소 color에 요인 am 매핑
ggpairs(mtcars_2,aes(color=am),
        lower=list(continuous=wrap("smooth",se=FALSE),combo=wrap("facethist",bins=10)))

