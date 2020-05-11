# 텍스트 파일 불러오기
# 함수 scan()으로 한 변수의 관찰값 불러오기

x <- scan("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data1.txt")
x           # 결과는 벡터

# 함수 read.table()로 2차원 형태의 데이터 파일 불러오기
df1 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_1.txt")
df1

class(df1$V2) # 문자열 요인으로 자동 변환
# 문자열 요인으로 자동 변환 방지
df1 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_1.txt",
stringsAsFactors = FALSE)
class(df1$V2)

# 데이터 파일의 첫 줄에 변수 이름이 있는 경우
df2 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_2.txt",
       header = TRUE , stringsAsFactors = FALSE)
df2

# 데이터 파일에 # 기호로 시작되는 코멘트가 있는 경우 
df3 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_3.txt",
                  header = TRUE)
df3 # 데이터 파일에서 # 기호로 시작하는 줄은 무시

# 데이터 파일에 결측값이 NA가 아닌 다른 기호로 입력된 경우
df4 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_4.txt",
                  header = TRUE ,na.strings = ".", stringsAsFactors = FALSE)
df4

# 여러가지 결측값 기호 지정
df5 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data2_5.txt",
                  header = TRUE ,na.strings = c(".","?"), stringsAsFactors = FALSE)
df5

# 데이터 파일의 관찰값들이 콤마(,)로 구분된 csv 파일인 경우
df5 <- read.table("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data3.txt",
                  header = TRUE ,sep = ',', stringsAsFactors = FALSE)
df5

# 함수 read.csv()는 read.table과 본질적으로 동일한 함수
# 차이점은 header = TRUE가 디폴트
df5 <- read.csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data3.txt",
                  stringsAsFactors = FALSE)
df5

# 함수 read.fwf()로 고정된 포멧 구조를 갖는 2차원 형태의 데이터 불러오기
df7 <- read.fwf("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data4_1.txt",
                widths = c(2,1,4),stringsAsFactors = FALSE) # width로 각 변수 폭 지정
df7

# 고정 포맷 구조를 갖는 데이터 파일의 첫 줄에 변수 이름 추가
# 각 변수 이름은 탭으로 구분되어야 함 
df8 <- read.fwf("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data4_2.txt",
                widths = c(2,1,4),header = TRUE,stringsAsFactors = FALSE)
df8

# 외부 데이터 파일이 저장되어 있는 폴더의 정확한 경로를 잊은 경우
read.table(file.choose())

# 함수 write.table()를 사용하여 r 데이터 객체를 외부 텍스트 파일로 저장
head(women) 
write.table(women, "C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/new_data.txt")

write.table(women, "C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/new_data1.txt",quote = FALSE)

write.table(women, "C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/new_data2.txt",quote = FALSE,row.names = FALSE)

write.table(women, "C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/new_data3.txt",quote = FALSE,row.names = FALSE, sep = ",")
write.csv(women, "C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/new_data4.txt",quote = FALSE,row.names = FALSE)


#
library(readr)
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_1.txt")
# read_csv() 특성
# 자료의 유형을 스스로 파악
# 문자형 자료를 요인으로 자동으로 전환하지 않음
# 중간에 빈 칸이 있는 변수 이름 사용 가능
# 결과는 tibble

# 자료의 유형을 직접 선언하는 경우 : 옵션 col_types
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_1.txt",
col_types = "ici") # 문자형(c) , 정수형(i), 숫자형(d), 논리형(l)

# 파일의 첫 줄에 변수 이름이 없는 경우
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_2.txt",
col_names = FALSE, col_types = "ici")   # 첫줄에 변수 이름이 없는 경우에 col_names를 사용하지않으면 자료의 첫 행이 변수이름으로 지정 된다.       

# 변수 이름 직접 지정 
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_2.txt",
         col_names = c("age","gender","income"), col_types = "ici")

# 자료 파일에 주석이 있는 경우 : 옵션 comment에 주석 기호 지정
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_3.txt",
         col_types = "ici", comment = "#") # 결측값 입력 : NA, 콤마로 구분된 경우 : 빈 칸도 결측값으로 인식

# 자료 파일의 처음 몇 개
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_3.txt")

# 결측값이 NA가 아닌 다른 기호로 입력 된 경우 : 옵션 NA
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_4.txt",
        col_types = "ici", col_names = FALSE, na = ".")
# 두 개 이상의 다른 기호로 입력 된 경우
read_csv("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data5_5.txt",
         col_types = "ici", col_names = FALSE, na = c(".","?"))

# 엑셀 파일 불러오기
library(readxl)
df3 <- read_excel("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data6.xlsx")         
df3
read_excel("C:/Users/82104/Desktop/Program/R Tidyverse/R 프로그래밍 기초/data/data6.xlsx",
           range = "A1:B5")         

# 웹파일 불러오기
iris.url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/iris/iris.data"

iris.data <- read_csv(iris.url, col_types = "ddddc",
                      col_names = c("S.length","S.width","P.length",
                                    "P.width","Species"))
iris.data

# HTML table 불러오기
# wikipedia 웹페이지의 HTML 테이블 데이터 불러오기
library(rvest)
URL <- "https://en.wikipedia.org/wiki/World_population"
web <- read_html(URL)
# 읽어온 웹 페이지에서 함수 html_nodes()로 <table> 노드 추출
tbl <- html_nodes(web, "table")
length(tbl)
head(tbl)

# 원하는 테이블이 몇 번째 노드인지 아는 경우
tbl_1 <- html_table(tbl[7])
tbl_1

# xpath를 가지고 불러오기
tbl_2 <- html_nodes(web, xpath = '//*[@id="mw-content-text"]/div/table[5]')
tbl_2

top_pop <- tbl_1[[1]]
names(top_pop) <- c("rank","country","pop","area","density")
str(top_pop)
