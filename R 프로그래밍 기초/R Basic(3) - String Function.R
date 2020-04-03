# 문자열을 위한 함수

# 함수 nchar() : 문자열을 구성하고 있는 문자 개수
x <- c('park','lee','kwon')
nchar(x)
# 한글도 글자수를 셈
nchar('응용통계학과')

#########################

# 함수 paste(): 문자열의 결합
#옵션 sep의 활용
paste('모든','사람에게는','통계적','사고능력이','필요하다')

paste('모든','사람에게는','통계적','사고능력이','필요하다', 
      sep = '-')

paste('모든','사람에게는','통계적','사고능력이','필요하다', 
      sep = '')

#입력된 숫자는 문자로 전환되어 문자열과 결합
paste('원주율은', pi,'이다')

#문자형 벡터가 입력되면 대응되는 요소끼리 결합
#벡터의 길이가 서로 다르면 순환법칙 적용
paste('stat',1:3,sep = '') # stat이 3번 반복

paste(c('stat','math'),1:3, sep = '-') # 길이가 짧은 벡터를 순환법칙으로 맞춤 

##############################

# 빈칸 없이 문자열 결합 
# 1. 함수 paste()에 옵션 sep = ''사용
# 2. 함수 paste0()사용
paste0('stat',1:3) # sep보다 paste0가 훨씬 편하다

# 문자형 벡터의 문자열을 하나로 결합 : 옵션 collapse
paste0(letters, collapse = '') # 문자형 벡터를 하나로 합칠때
paste0(LETTERS, collapse = ",") # 구분자를 ,로 줌

#############################################

# substr(): 주어진 문자열의 일부분 선택
# substy(x, start, stop)
# -start, stop : 정수형 스칼라 또는 벡터(대응되는 숫자끼리 시작점과 끝점 구성)
substr('statistics',1, 4) #시작점 1, 끝점 4

x <- c('응용통계학과','정보통계학과','학생회장')
substr(x,3,6) #시작점 3번째~6번글자 출력
substr(x,c(1,3),c(2,6)) # 시작점 1,끝점 2
                        # 시작점 3,끝점 2 다시 1,2 반복

# 예제 : 문자형 벡터 x에는 미국의 세 도시와 그 도시가 속한 주 이름이 입력
x <- c("New York,NY","Ann Arbor, MI","Chicago, IL")

# 세 도시가 속한 주 이름만을 선택하여 출력
substr(x, nchar(x)-1,nchar(x))

######################################3

# 함수 strsplit() : 문자열의 분리
# 옵션 split에 지정된 기준으로 분리. 결과는 리스트
# 세 도시의 이름과 주 이름 분리
y <- strsplit(x, split = ",")
y

# unlist를 사용해 리스트 y를 벡터로 변환 
unlist(y)

# 문자열을 구성하는 모든 문자의 분리
unlist(strsplit('PARK',split = ""))

# 점(.)을 기준으로 문자열 분리하는 경우
# 옵션 split = "." 원하는 결과를 얻을 수 없음.
unlist(strsplit("a.b.c",split = "."))

# 옵션 split = "[.]" 또는 split = "||."
unlist(strsplit("a.b.c",split = "[.]"))
# 옵션 split에는 정규표현식이 사용되며
# 정규표현식에서 점(.)은 다른의미가 있다

#################################################

# 함수 toupper(), tolower() : 대(소)문자로 수정
x <-c('park','lee','kwon')
(y <- toupper(x))
tolower(y)

# 벡터 x의 첫 글자만 대문자로 변환
substr(x,1,1) <- toupper(substr(x,1,1))
x

#############################################

# 함수 sub(), gsub() : 문자열의 치환
# sub(old,new,문자열) : 문자열의 첫 번째 old만 new로 치환
# gsub(old,new,문자열) : 문자열의 모든 old가 new로 치환

x <- "Park hates stats. He hates math, too."
sub("hat", "lov", x) # 첫번째 hat만 바뀜
gsub("hat", "lov", x) # 전부 바뀜

# 예제
# 문자열 "banana1","banana2","banana3" 생성
x <- c("banana1","banana2","banana3") # 반복이므로
x <- paste0('banana',1:3) # paste0로 사용하는게 더 간단함
x
# 첫 번째 a를 A로 변경
sub('a','A',x)
# 모든 a를 A로 변경
gsub('a','A',x)

# 문자열의 일부 삭제는 new에 ""입력

z <- "Everybody cannot do it"
sub("not","",z)