#������
str(state.region) #factor ��
state.region[1:10] #factor�ε� ������ ����
state.region

p1 <- ggplot(data=data.frame(state.region))+geom_bar(mapping=aes(x=state.region))
p1
p1+coord_flip()


counts <- table(state.region)
counts
library(tidyverse)
df_1 <- as.data.frame(counts)
df_1
df_1 %>% ggplot(mapping=aes(x=state.region,y=Freq))+geom_col(fill="skyblue")+labs(x="Region",y="count")

#���� �׷���
ggplot(data.frame(state.region))+
  geom_bar(aes(x="",fill=state.region),width=1)+labs(x="",y="")+coord_polar(theta="y")


#
library(scales)
library(tidyverse)
counts <- table(state.region)
df_2 <- as.data.frame(counts) %>% mutate(pct=percent(Freq/sum(Freq)))
df_2


#�������� 1.4
#������ ���� ����
library(MASS)

Carsize <- cut(MASS::Cars93$EngineSize,
breaks=c(0,1.6,2.0,Inf),labels=c("Small","Mid","Large"))
Carsize
data.frame(Carsize) %>%count(Carsize)

ggplot(data.frame(Carsize),mapping=aes(x=Carsize))+geom_bar(fill="tomato")+labs(x="") #ggplot�ȿ� �ִ� data�� ������ dataframe����!

p <- MASS::Cars93 %>% 
  mutate(group=cut(EngineSize,breaks=c(0,1.6,2.0,10),labels=c("Small","Mid","Large"))) %>%
  filter(!is.na(group)) %>% 
  group_by(group) %>% 
  summarise(Freq=n()) %>% 
  mutate(pct=percent(Freq/sum(Freq)))

p %>% ggplot() + geom_bar(aes(x=group,y=Freq),stat="identity")
p %>% ggplot(aes(x="",y=Freq, fill=group)) + 
  geom_col(width=1) + 
  geom_text(aes(label=pct), size=5, position=position_stack(vjust=0.5)) + 
  coord_polar(theta="y")

data.frame(table(Carsize)) %>% #pdf ��
mutate(pct=percent(Freq/sum(Freq))) %>%
  ggplot(aes(x="",y=Freq,fill=Carsize))+
  geom_col(width=1)+geom_text(aes(label=pct), size=5, position=position_stack(vjust=0.5)) + 
  coord_polar(theta="y")+labs(x="")

# �̺��� �ڷ� Ž��
# (1) �� ������ ���� ���� �ľ�
# (2) �� ������ ���� ��
# (3) �� ������ ���� Ž��

# �̺��� ������ �ڷ�
# ����׷��� : �׾� �ø� ����, ������ �ٿ� ���� ����
# Mosaic plot

# �̺��� ������ �ڷ�
# ���� �񱳸� ���� �׷���
# ���� Ž���� ���� �׷���

data(Arthritis,package="vcd")
head(Arthritis) 
#1���� ��������ǥ �ۼ�
table <-with(Arthritis,table(Improved))
table

#1���� ��뵵������ǥ �ۼ�
prop.table(table) #�Ҽ��� �ڸ��� ���� �ʿ�
options("digits") #�Ҽ��� �ڸ��� ����Ʈ�� =7
options("digits"=2) #2�ڸ��� ����

prop.table(table)
table1 <- with(Arthritis,table(Treatment,Improved)) # ù��°����:�ຯ��
table1

#�Ѱ���� �߰�
addmargins(table1)

#2���� ��뵵�� ����ǥ(���պ���) �ۼ�
prop.table(table1)

#���Ǻ��� ����ǥ
prop.table(table1,1)
prop.table(table1,2)
#������ ���� ��ġ��
library(tidyverse)
data(Arthritis,package="vcd")
with(Arthritis,table(Treatment,Improved))
df_1 <- mutate(Arthritis,Improved=factor(Improved,labe=c("No","Yes","Yes")))
with(df_1,table(Treatment,Improved))

#airquality���� ���� Ozone�� ���� 80�� �Ѵ� ����
with(airquality,table(ozhi=Ozone>80,Month))

#������ ã��
with(airquality,
     table(ozhi=Ozone>80,Month,useNA = "ifany"))

#�̺��� �� �ٺ��� ������ �ڷḦ ���� �׷���
#�׾ƿø� ���� �׷���
#���ڷ� ���
ggplot(Arthritis)+geom_bar(aes(x=Treatment,fill=Improved))

#����ǥ ���
table1 <- with(Arthritis,table(Treatment,Improved))
p <- ggplot(data.frame(table1),aes(x=Treatment,y=Freq,fill=Improved))
p+geom_col() #geom_col() = geom_bar(stat="identity")

#������ �ٿ� ���� ���� �׷���
#���ڷ� ���
pp<- ggplot(Arthritis,aes(x=Treatment,fill=Improved))
pp+geom_bar(position="dodge")
pp+geom_bar(position="dodge2")

#����ǥ ���
p+geom_col(position="dodge")
p+geom_col(position="dodge2")

#��뵵���� �̿��� ������ �ٿ� ���� ���� �׷���
ggplot(Arthritis,aes(x=Improved,y=stat(prop),group=1))+geom_bar()+facet_wrap(~Treatment)

#���Ǻ� Ȯ���� ���� �׾� ���� ���� �׷���
ggplot(Arthritis,aes(x=Treatment,fill=Improved))+geom_bar(position="fill")

#mosaic plot
#�ΰ� �̻��� ������ ���� ���� Ž���� ������ �׷���
#��Ű�� vcd�� �Լ� mosaic()���� �ۼ�
#����ǥ �Է�
library(vcd)
mosaic(table1,direction="v")

#���ڷ� �Է�:R�������� ���� ����
#~����+���� ����
mosaic(~Treatment+Improved,data=Arthritis,direction="v")

#��������~�������� ����
mosaic(Improved ~Treatment,data=Arthritis,direction="v")

str(Titanic)
mosaic(Survived ~ Sex+Age,data=Titanic,direction="v")

mosaic(Survived ~Class+Sex,data=Titanic,direction="v")


#�������� 1
data <- data.frame(parent=rep(c("yes","no"),each=2),child=rep(c("yes","no"),times=2),num=c(58,8,2,16))  
data
ex9_5 <- ggplot(data,aes(x=parent,y=num,fill=child))+labs(y="")+theme(legend.position="top")  
ex9_5+geom_col()
ex9_5+geom_col(position="dodge")
ex9_5+geom_col(position="fill")