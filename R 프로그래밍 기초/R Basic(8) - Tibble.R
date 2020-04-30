# tibble : 개선된 형태의 데이터 프레임
# 함수 as_tibble() - tibble 생성
library(tidyverse)
cars
as_tibble(cars)

# 개별 벡터를 이용한 tibble의 생성
# 함수 tibble()
# tibble 길이가 1인 스칼라만 순환법칙 적용(z = 1:2 넣을시 오류가 나옴)
# 열 단위로 입력
tibble(x = 1:3, y = x + 1, z = 1) 

# 함수 tibble() vs data.frame()
# 함께 입력된 변수를 이용하여 다른 변수를 만드는 기능
data.frame(x = 1:3, y = x+1)

# 행 단위로 입력하여 tibble 생성
# 함수 tribble()
tribble(
  ~x, ~y,
  1,"a",
  2,"b",
  3,"c"
)

# 데이터 프레임과 티블의 차이
# 데이터 프레임 : 가능한 모든 자료를 화면에 출력, 대규모 자료의 경우 내용 확인에 어려움


data(Cars93, package = "MASS")
Cars93

# tibble : 처음 10개 케이스만 출력. 화면의 크기에 따라 출력되는 변수의 개수 조절
as_tibble(Cars93) # 변수 이름과 더불어 변수의 유형을 함께 표시'

# 변수 명 전부 출력
print(as_tibble(Cars93), n = 6, width = Inf)

tibble(mtcars)

# row names 처리 방식의 차이
# 데이터 프레임: 자료 출력시 row name 함께 출력
head(mtcars)

mtcars_t <- as_tibble(mtcars)
print(mtcars_t, n = 6)

# 생략된 row name : 변수로 전환
# 함수 rownames_to_column()
mtcars_d <- rownames_to_column(mtcars,var = "rownames")
mtcars_t <- as_tibble(mtcars_d)
mtcars_t

# 행렬 방식의 인덱싱 결과
# 전통적인 데이터 프레임 : 선택되는 변수의 개수에 따라 벡터 혹은 데이터 프레임
# tibble : 선택되는 변수의 개수와 관계 없이 항상 tibble 유지

mtcars[,1:2]
mtcars[,1]
mtcars_t[,1:2]
mtcars_t[,1]
mtcars_t[1,1]

mtcars_t$mpg
