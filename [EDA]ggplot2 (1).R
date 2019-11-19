#����� ��ȯ
#stat="identity" ������ 
#stat="smooth" ���� ȸ�Ͱ 
#stat = "count" ���� �׷��� 

#geom �Լ� ��� stat �Լ��� �׷��� �ۼ� ����

#mpg�� ���� trans�� ���� �׷��� �ۼ�
library(tidyverse)
ggplot(data=mpg,mapping=aes(x=trans))+geom_bar()
ggplot(data=mpg,mapping=aes(x=trans))+stat_count()

#stat �Լ�
#���� count : ���� ��
#���� prop : �׷캰 ����

#mpg�� ���� trans�� ���� �׷����� ��� ������ �ۼ�
ggplot(data=mpg)+geom_bar(mapping=aes(x=trans,y=stat(prop),group=1)) #�� ���ָ��� ������ 1�̹Ƿ� ��� ������ 100%�� �ν� 
#group�� �ϳ��� ���������.
ggplot(data=mpg)+geom_bar(mapping=aes(x=trans,y=stat(prop),group=1))


#stat ����Ʈ ���� �ƴ� ���� ����������ϴ� ���

#geom �Լ��� ����Ʈ stat�� �ƴ� �ٸ� stat�� ����ؾ� �ϴ� ���
#auto�� auto���� manual�� manual�� ���� ��������ǥ,����׷��� �ۼ�
#���յ� ������ ���� ����tibble �ۼ�

mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
  count(am)

#��������ǥ�� ���� �׷��� �ۼ�
ggplot(data=mpg_am)+geom_bar(mapping=aes(x=am,y=n),stat="identity") #stat=identity �Էµ� �ڷ� �״�� �Է�

#��ġ���� position adjustments
#������ �ڷ�: �������� ���� �������� ���
#������ �ڷ�: �̺��� ���� �׷��� �ۼ�

#mpg���� ���� cty�� hwy�� ������ �ۼ�
ggplot(data=mpg,mapping=aes(x=cty,y=hwy))+geom_point() #������ 234���� ����������, �� ������ ���� �ݿø� ó���Ǿ� ���� ���� ������

#jittering�ǽ�
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_point(position="jitter")
#geom_jitter
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_jitter(width=0.05,height=0.4)
ggplot(data=mpg, mapping=aes(x=cty,y=hwy))+geom_jitter(width=0.4,height=0.05)

#diamonds���� ���� carat�� price�� ������
ggplot(data=diamonds)+geom_point(mapping=aes(x=carat,y=price))

#mpg���� trans�� ���ָ� auto�� manual�� ������ ���� am ����
#���� cyl�� 5�� ���̽� ���� �� am�� �̺��� ���� �׷��� �ۼ�
mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
filter(cyl!=5) #���� cyl�� 5�� ���̽� ����

p_1 <- ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),fill=am))+
  xlab("Number of Cylinders")
p_1 +geom_bar() # ���� �׷��� �׸���
#������ �ٿ� ���� ���� �׷���
p_1+geom_bar(position="dodge")
p_1+geom_bar(position="dodge2") #�׷��� ���� ���� ����
#cyl�� �������� �ϴ� cyl�� am�� ���Ǻ� Ȯ��
p_1+geom_bar(position="fill")

#19.10.8

# ������ �� �ִ� ���ڱ׸�
# - geom_boxplot()
# - �ʿ��� �ð��� ��� : x = �׷��� �����ϴ� ����(����)
#                        y = ������ ����
library(tidyverse)
mpg_am <- mpg %>%
  mutate(am=substr(trans,1,nchar(trans)-4))%>%
  filter(cyl!=5) #���� cyl�� 5�� ���̽� ����
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot()+ #as.fctor ��� ���ҽ� cyl�� ������ �ƴ� ������ ������
  xlab('number of cylinder')

#�׷��� �����ϴ� ������ �� ���� ����� ���ڱ׸�
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot(mapping=aes(fill=am))+ #as.fctor ��� ���ҽ� cyl�� ������ �ƴ� ������ ������
  xlab('number of cylinder') #position='dodge�� ����Ʈ�� �����
#�׷��� �����ϴ� ������ �� ���� ����� ���ڱ׸�
ggplot(data=mpg_am,mapping=aes(x=as.factor(cyl),y=hwy))+geom_boxplot(mapping=aes(fill=am))+  
xlab('number of cylinder')+ #position='dodge�� ����Ʈ�� �����
facet_wrap(.~am)

# Coordinate System
# ��ǥ�� : �ð��� ��� x�� y�� �ٰŷ� �׷����� �� ����� 2���� ��ġ�� �����ϴ� ü��
# ��ǥ���� ����
# - coord_cartesian() : ����Ʈ
# - coord_flip() : cartesian ���� x��, y���� ����
# - coord_polar() : ����ǥ

# ��:mpg���� displ�� hwy�� �������� ���� ȸ�Ͱ �߰��� �׷��� �ۼ�,
# x���� ������ (3,6)���� ����� �׷��� �ۼ�
p <- ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+geom_point()+geom_smooth()
p
p+coord_cartesian(xlim=c(3,6))     # y���� ������ ������ �ÿ� ylim=c() ���!
p+coord_cartesian(ylim=c(20,30))

#scale�� ���� xy�� ���� ����
# - scale : �ڷ�� �ð��� ����� ���� �� XY��� ���� ���� ���� ������ �ǹ�
# - ��κ��� ��� ����Ʈ ���¿��� �׷��� �ۼ�
# - XY�� ���� ����, XY�� �� ������ �ʿ��� ���״� scale �Լ��� ����ϸ� ����
# - scale �Լ��� �Ϲ����� ���� : scale_*1*_*2*()
#   - *1* : �����ϰ��� �ϴ� �ð��� ��� : color, x, y, fill ���
#   - *2* : ����Ǵ� scale ���� : discrete,continous ��� 

# �� : ������ X ������ ���� (3,6)���� ���� : scale_x_continous(limits=c(3,6))
# �� : ������ X���� �� ���� : scale_x_continous(name="Engine")

# �����Լ�
# - XY�� ���� ���� : xlim(3,6), ylim(0,1)
# - XY�� �� ���� : xlab("Engine"), ylab(), labs(x="Engine")

#�Լ� xlim()�� ���� ����
p+xlim(3,6)+xlab('Engine Displacement') #xlim�� ����� ��� 3,6�� ������ ��� �ڷ� ����

#�Լ� coord_certesian()�� ���� ���� 
p+coord_cartesian(xlim=c(3,6))+xlab('Engine Displacement')

# �Լ� coord_flip()�� Ȱ�� : ������ ���ڱ׸� �ۼ�
# - ��κ��� geom �Լ� : �־��� X���� ���� ���� ǥ��
# - ���ڱ׸� : ���� ������ �ۼ��Ǵ� ���� ����Ʈ
# - ���� ���� ���� �׸� : ����Ʈ �������� �ۼ��ϰ�, �׷����� ��ǥ�� 90�� ȸ��
# - �Լ� coord_flip() : �ۼ��� �׷����� ��ǥ ȸ��

# mpg���� class�� �׷캰�� hwy�� ���ڱ׸� �ۼ�
mpg %>% ggplot(mapping=aes(x=class,y=hwy)) + 
  geom_boxplot() + coord_flip()

# �� ������ ���ڱ׷��� �ۼ�
# - �Լ� geom_boxplot()���� x��y ��� �ʿ�
# - x���� �ϳ��� ��, y���� ������ ���� ����
mpg %>% ggplot(mapping=aes(x="",y=hwy)) + 
  geom_boxplot() + xlab("")
#x�� y�� ��ȯ
mpg %>% ggplot(mapping=aes(x="",y=hwy)) + 
  geom_boxplot() + xlab("") + coord_flip()

# �Լ� coord_polar()�� Ȱ�� : ���� �׷��� �ۼ�
# - ����ǥ(polar coordinate) : 2���� ������ ��� �� ���� ��ġ�� �������� �Ÿ��� ������ ǥ��
# - �Լ� coord_polar() : ��ī��Ʈ ��ǥ�� �� ��ǥ�� ��ȯ
# - ���� theta : �ð��� ��� x�� y �� ������ ��ȯ�� ��� ���� (����Ʈ�� theta="x")
# �Լ� cooord_polar()�� Ȱ���Ͽ� ���� �׷������� ������ �׷���

# - Coxcomb �Ǵ� Wind rose �׷���
# - ���� �׷���
# - Bullseye

# mpg�� ���� class�� Coxcomb �׷��� �ۼ�
# ����׷��� �ۼ�
# - �� ���븶�� �ٸ� �� ���
# - ���� ���� ���� ����
# - ���� ����
b2 <-  mpg %>% ggplot(mapping=aes(x="",fill=class)) + 
geom_bar(width=1) + #geom_bar������ y�����ϸ� �ȵ�. *geom_bar ����Ʈy�� count, �����ؾ��Ҷ��� identity�� ��� 
labs(x="",y="")
b2
#thete ="Y"�� �Լ� coord_polar()����: ���� �׷��� �ۼ�
b2+coord_polar(theta="y")

b2+coord_polar(theta="x")


