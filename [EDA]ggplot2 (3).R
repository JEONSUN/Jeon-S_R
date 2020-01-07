# �Ϻ��� �ڷ��� ������

# �ڷ��� �߽ɿ� ���� ��� ���
# ���(MEAN) : �Ϲ����� ��Ȳ���� ���� ���� ���Ǵ� �����跮
# �߾Ӱ�(MEDIAN) : ġ��ħ�� ���� ������ ��� ��պ��� ������ �߽��� �� ��Ȯ�ϰ� ��Ÿ��
# �ֺ� (MODE) : ������ �ڷ��� ��� ū �ǹ̰� ���� ���

# �� : faitful�� waiting�� ������

attach(faithful)
mean(waiting)
median(waiting)
table(waiting)
my_id <- which.max(table(waiting))
table(waiting)[my_id]
detach(faithful)

#UsingR ������ ��Ű�� cfb�� INCOME ���� �������� �ľ�

data(cfb,package="UsingR")
attach(cfb)
mean(INCOME) ;median(INCOME)
detach(cfb)

# �׷��� �ۼ�

ggplot(cfb,aes(x=INCOME,y=stat(density)))+
  geom_histogram(bins=15,fill="blue")+
  geom_density(color="red")

# �������� ���ϰ� ġ��ģ �����̹Ƿ� �α׺�ȯ�̳� ������ ��ȯ�� ���� �¿��Ī���� ��ȯ �õ��غ�����.
log_income <- log(cfb$INCOME)

range(log_income)
range(cfb$INCOME)

log_income=log(cfb$INCOME+1)
range(log_income)

# �α� ��ȯ�� �ڷ��� ����
ggplot(data.frame(log_income),aes(x=log_income,y=stat(density)))+
  geom_histogram(fill="blue",bins=35)+
  geom_density(color="red",size=1)

mean(log_income) ; median(log_income)


# ������ ������ ���� Ž���� ���� �׷��� : ������
# 1) �پ��� ������ ������ �ۼ�
# �⺻���� ������ ������ : Cars93 �� weight�� mpg.highway

data(Cars93, package="MASS")
library(tidyverse)

ggplot(Cars93,aes(x=Weight,y=MPG.highway))+geom_point()
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+geom_point(shape=21,color="red",fill="blue",stroke=1.5,size=3)

# �ð��� ��ҿ� �� ��° ���� ���� : ���������� �� ������ ���� Ž��
# color�� ���� origin ����
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=Origin))+geom_point()

# color�� ������ ���� enginesize ����
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=EngineSize))+geom_point()

# shape�� ����(Origin) �� ������ ���� (EngineSize)
ggplot(Cars93,aes(x=Weight,y=MPG.highway,shape=EngineSize))+geom_point()  # shape�� ������ ������ ������ �Ұ���4

# size�� ���� �� ������ ���� ����
ggplot(Cars93,aes(x=Weight,y=MPG.highway,size=EngineSize))+geom_point()  

# �������� ȸ������ �߰�
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(se=FALSE,method="lm")
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(se=FALSE)

# ȸ�������� ���� ȸ�Ͱ�� �Բ� �������� �߰�
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_smooth(aes(color="lm"),method="lm",se=FALSE)+
  geom_smooth(aes(color="loess"),se=FALSE)+labs(color="method")

# �������� ����, ������ �߰�
# ���� �߰� �Լ�: geom_abline(slope,intercept)
# ������ �߰� �Լ� : geom_vline(xintercept)
# ���� �߰� �Լ� : geom_hline(yintercept)

# ������, ȸ������, ���� Weight�� ��տ� ������, ���� MPG.highway�� ��տ� ����
ggplot(Cars93,aes(x=Weight,y=MPG.highway),)+
  geom_point()+ 
  geom_smooth(method="lm",se=FALSE)+
  geom_vline(aes(xintercept=mean(Weight),color="meanWeight"))+ 
  geom_hline(aes(yintercept=mean(MPG.highway),color="meanMPG"))+labs(color="method")

# �������� ���� �� �߰�
# Weight�� MPG.highway�� ������
# MPG.highway > 40�� ���� �� �߰�
# �� ���� : Manufacturer�� Model�� �� ������ ��
Cars93
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
geom_text(data=filter(Cars93,MPG.highway>40),aes(x=Weight,y=MPG.highway,label=paste(Manufacturer,Model))) #�� ���� : paste
# ���� ���� �� �� �� ������ �ʿ� 
# �� ��ġ ���� : nudge_x & nudge_y �̿�
# nudge_x : ���ǰ� - ����, ���ǰ� - �������� �̵�
# nudge_y : ���ǰ� - ����, ���ǰ� - �Ʒ��� �̵� 
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+
  geom_text(data=filter(Cars93,MPG.highway>40),aes(x=Weight,y=MPG.highway,label=paste(Manufacturer,Model)),nudge_x=100)

# geom_text()���� �ּ��� ��ġ�� ũ������
fit <- lm(MPG.highway ~ Weight, Cars93)
r2 <- round(summary(fit)$r.squared,2)
ggplot(Cars93,aes(x=Weight,y=MPG.highway))+
  geom_point()+geom_smooth(method="lm",se=FALSE)+
  geom_text(x=3500,y=45,size=7,label=paste("R^2==",r2),parse=TRUE)

# ���������� ���� �������� ����
# ��Ը� �ڷ��� ���
# �� ������ �� ������ �̻����� ���
# �ڷᰡ �ݿø��� ���
ChickWeight
ggplot(ChickWeight,aes(x=Time,y=weight))+geom_point()
p1 <- ggplot(ChickWeight,aes(x=Time,y=weight))
# ��� 1) �� ������ �̻����� ����� �� : ChickWeight�� ���� Time�� Weight
p1+geom_jitter(width=0.2,height=0) #jitter ���� ����ð��� �������� Ȯ���ϱ����� ������

# ��� 2) ���ڱ׸�
class(ChickWeight$Time) # Time ������ ������ �̹Ƿ� �׷��� �Ұ�
p1+geom_boxplot(aes(group=Time)) # �ð��� ��� group�� x�� �����ؾ���.

# ��� 3) ���ڱ׸��� jittering
p1+geom_jitter(width=0.1,fill="red",shape=21)+
  geom_boxplot(aes(group=Time),outlier.shape=NA,fill=NA,color="blue") 
# flll=NA : ���ڱ׸� ������ ��� ����, geom_boxplot�� ���� �����ϰ�, �� ���� ���� jittering�ϸ� �ʿ����.

# ��Ը� �ڷ��� �� : diamonds�� ���� carat�� price�� ������
library(tidyverse)
ggplot(diamonds,aes(x=carat,y=price))+geom_point()

# carat<3�� �ڷḸ�� ������� ������ �ۼ�
p1<- ggplot(filter(diamonds,carat<3),aes(x=carat,y=price))
p1+geom_point()
# ��� 1: ���� ũ�⸦ ���̰� �������� ���̴� ��
ggplot(filter(diamonds,carat<3),aes(x=carat,y=price))+geom_point(alpha=0.1,shape=20)

# ��� 2: geom_bin2d()�� 2���� ������׷� �ۼ�
# xy 2���� ������ ���簢���� �������� ����
# �� ������ ���� �ڷ��� ������ ������ ǥ��
p1+geom_bin2d()

# ���� ���� �ø��� ���� ��ȭ�� �� �׷���
p1+geom_bin2d(bins=100)+
  scale_fill_gradient(low="purple",high="yellow")  # scale_fill_gradient(): two color(low-high) gradient ����

# scale_*_gradient�� �ٸ� ���� �� : Cars93�� Weight vs MPG.highway�� ������
library(MASS)
ggplot(Cars93,aes(x=Weight,y=MPG.highway,color=EngineSize))+geom_point()+scale_color_gradient(low="purple",high="yellow")
# ������ ���� EngineSize�� color�� ����

# ��� 3 : x�� ������ ���������� ��ȯ�ϰ� ���ڱ׸� �ۼ�
# ������ ������ �������� ��ȯ�ϴ� �Լ� : cut()�� �̿��� �Լ�
# cut_interval(x,n) : ���� x�� n���� ���� ������ �������� ����
# cut_width(x,width) : ���� x�� ���̰� width�� �������� ����
# cut_number(x,n) : ���� x�� n���� �������� �����ϵ� �� ������ ���� �������� ������ ����ϰ� ����

# ���� carat�� �������� 0, ������ 0.1�� �ϴ� �������� ����
# �� ������ �ڷḦ ������� side-by-side boxplot �ۼ�
p1+ geom_boxplot(aes(group=cut_width(carat,
                                     width=0.1,boundary = 0)))

# 20���� �������� �����ϵ�, �� ������ ���� �ڷ��� ������ �����ϰ� ����
p1+geom_boxplot(aes(group=cut_number(carat, n=20))) # ������ ������ ���������� boxplot�� ������.

# ������ ����Ȯ���е� �׷���
# �� ������ ������ ����Ž������ ū ������ �� �� �ִ� �׷���

# ��: faithful�� eruptions�� waiting�� ����Ȯ���е� ����

p2 <- ggplot(faithful,aes(x=eruptions,y=waiting))+xlim(1,6)+ylim(35,100)
p2+geom_density_2d() 
# ����� �׷���
# - �� ������� ���� ������ �� �ʿ�
# - ������ ���̸� �����ϴ� ���� �� ȿ����

# ������ ����� ���� ǥ��
p2+geom_density_2d(aes(color=stat(level)))+ #stat(level) : geom_density_2d()���� ����� ����� ����
scale_color_gradient(high="red",low="blue")

# �� ������ �������� ����� �׷��� �߰�
p2+geom_point(shape=20)+geom_density_2d(aes(color=stat(level)))+scale_color_gradient(high="red",low="blue")

# ���̰� ���� ������ ���е� ������ ä��� �׷��� - stat_density_2d()���� geom="polygon" ���
p2+stat_density_2d(aes(fill=stat(level)),geom="polygon")+scale_fill_gradient(high="white",low="red")



# �׷��� ���� ��ü�� Ÿ�Ϸ� ����
# Ȯ���е��� ���̿� ���� �� Ÿ���� ���� �ٸ���
# geom="raster" Ȥ�� "title" ���
p2+stat_density_2d(aes(fill=stat(density)),geom="raster",contour=FALSE)+scale_fill_gradient(high="yellow",low="black")

# ������ ���
# - ���� ������ �̷���� �ڷῡ�� �� �������� ¦�� ���� �ۼ��� �������� ��� ���·� ǥ���� �׷���
# - �ڷ� �м����� �ʼ����� �׷���

# �ۼ� �Լ�
# - ��Ű�� GGally�� �Լ� ggpairs()

# GGally: ggpairs()�� ���� ������ ���
# - mtcars�� ���� mpg,wt,disp,cyl,am�� ������ ��� �ۼ�
# ���� : ggpairs(df)
library(GGally)
library(tidyverse)
mtcars
mtcars_1 <- mtcars %>% 
  select(mpg,wt,disp,cyl,am)
ggpairs(mtcars_1)  # ��� ������ ������
# am,cyl�� �������� ��ȯ
mtcars_2 <- mtcars_1 %>%
  mutate(cyl=factor(cyl),am=factor(am))
ggpairs(mtcars_2)

# �� �гο� �ۼ��Ǵ� ����Ʈ �׷���
# - �밢�� �г�: ������(Ȯ���е� �׷���), ������(����׷���)
# - �밢�� ���� �г�: ������(������), ������(facet ���� �׷���), combo(���ڱ׸�)
# - �밢�� �Ʒ��� �г�: ������(������), ������(facet ���� �׷���), combo(facet ������׷�)

# �� �гο� �ۼ��Ǵ� ����Ʈ �׷����� ����
# �밢�� �� �Ʒ� �г�: �ɼ� upper, lower