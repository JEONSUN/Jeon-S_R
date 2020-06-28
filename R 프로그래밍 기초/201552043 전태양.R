# 1-1
fl2000 <- read.table("http://lib.stat.cmu.edu/datasets/fl2000.txt",header = TRUE,stringsAsFactors = FALSE)
# 1-2
dim(fl2000)
names(fl2000)
# 1-3
colnames(fl2000)[c(1,6,7)]
# 1-4
new_f<- fl2000[c(1,6,7)]

write.table(new_f,"C:/Users/82104/Desktop/example/fl_BG.txt",quote = FALSE,row.names = FALSE)


# 2-1
library(readr)
dirtbike <- read.csv("C:/Users/82104/Desktop/example/dirtbike_aug.csv")
# 2-2
dim(dirtbike)
names(dirtbike)
# 2-3
colnames(dirtbike)[c(1,7)]
# 2-4
dirtbike_1 <- dirtbike[c(1,7)]
write.table(dirtbike_1,"C:/Users/82104/Desktop/example/dirt_disp.txt",quote = FALSE,row.names = FALSE)

# 3-1
library(rvest)
url <- "https://en.wikipedia.org/wiki/South_Korea"
web <- read_html(url)
tbl <- html_nodes(web,"table")
top_company <- html_table(tbl[[20]])
top_company <- as.data.frame(top_company)
names(top_company) <- c("Rank","Name","HQ","Revenue","Profit","Assets")
top_company
# 3-2
top_Re <- top_company$Revenue
top_Re <- gsub(",","",top_Re)
mean(as.numeric(top_Re))
