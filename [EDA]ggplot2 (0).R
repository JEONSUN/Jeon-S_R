ggplot2
library(tidyverse)
#��Ű�� ggplot2�� �ִ� ������ ������ mpg�� ���� displ�� hwy�� ������ �ۼ�
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy)) #mapping=aes() �ð��� ���
#���� class�� �� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class)) #aes()�ۿ��� ����ڰ� ���ϴ� ������ ����
#���� drv�� �� ��� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,shape=drv))
#���� cyl�� ũ�� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,size=cyl))
#���� ��, �����, ũ�� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class,shape=drv,size=cyl))
#���� ��, ����� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color=class,shape=drv))
#��� ���� ����������
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color='red'))
#���� ��Ҹ� ���ÿ� setting
#���� ���λ�-red,���� �ܰ��� ��- blue,�����=21,���� �ܰ��� �β�����-stroke=2
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy),shape=21,fill='red',color='blue',size=3,stroke=2)
#�Լ� aes() �ȿ��� �ð��� ��ҿ� Ư�� ���� setting�� ����� ���
#mapping <- �ð��� ��ҿ� ���� ���� <- ���ο� ���� 'color'�� �����Ǿ� �ش� �� blue�� �����ϴ� red�� ������ ���� ��Ե�
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy,color='blue'))
#setting <- ����ڰ� ���Ƿ� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy),color='blue')
# �׷캰 �׷��� �ۼ� : Facet
# ������ ������ �ٸ� ������ ��ġ�� ������� �׷����� Ȯ���ϴ� ���
# �ð��� ��ҿ� ������ ������ mapping
# ������ ������ �׷��� �����ϰ�, �� �׷캰 �׷��� �ۼ� : faceting

# facet�� �����ϱ� ���� �Լ�
# 1. facet_wrap() : �� ������ ���� facet
# 2. facet_grid() : �� ���� �Ǵ� �� ������ ���� facet

#�����͸� �����ϴ� ������ �ϳ��� ���: facet_wrap(~x)
#mpg�� ���� displ�� hwy�� �������� class�� ���ֺ��� �ۼ�
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+facet_wrap(~class)
#2seater���̽� ���� ������ class�� ���ֺ� �ۼ�
mpg%>%
filter(class !="2seater")%>%
ggplot()+geom_point(mapping=aes(x=displ,y=hwy))+facet_wrap(~class)
#�г� ��ġ ����
#2x3 �г� ��ġ�� 3x2 ��ġ�� ���� ncol=2
#�гο� �׷��� ��ġ ������ �� ������ ���� dif='v'
pp <- mpg%>%
  filter(class !="2seater")%>%
  ggplot()+
  geom_point(mapping=aes(x=displ,y=hwy))
pp+facet_wrap(~class,ncol=2)
pp+facet_wrap(~class,ncol=2,dir="v")

# facet_grid()
# �� ������ ���� faceting
# �ϳ��� ������ �г� ��ġ : facet_grid(.~x)
# �ϳ��� ������ �г� ��ġ : facet_grid(x~.)
# �� ������ ���� faceting
# facet_grid(y~x)
# �� ���� : y�� ����
# �� ���� : x�� ����


# ������ ������ mpg���� ������ ���� div�� cyl�� ������ displ�� hwy�� ������ �ۼ�
# �� drv�� "r" �� �ڷ�� cyl�� 5�� �ڷ� ����
library(tidyverse)
pp <- mpg %>% filter(drv!="r" & cyl!=5) %>% ggplot(mapping=aes(x=displ,y=hwy)) + geom_point() 
pp + facet_grid(drv~.)
pp + facet_grid(~cyl)
pp + facet_grid(drv~cyl)

# ������ ������ ������ ������ ��ȯ �� faceting
# cut_interval(x,n) : ���� x�� n���� ���� ������ �������� ����
# cut_width(x,width) : ���� x�� ���̰� width�� �������� ����
# cut_number(x,n) : ���� x�� n���� �������� �����ϵ� �� ������ ���� �������� ������ ����ϰ� ����


# ������ ������ airquality���� ���� Ozone, Solar.R, Wind�� ���� Ž��
# 1. ���� Wind�� 4�� �������� �����ϵ� ���� �ڷ��� ������ ����ϵ���
# 2. 4���� �������� Ozone�� Solor.R�� ������ �ۼ�

airquality %>% mutate(Wind_d=cut_number(Wind, n=4)) %>%
    ggplot() + 
  geom_point(mapping=aes(x=Solar.R, y=Ozone)) +
facet_wrap(~Wind_d)

# ���� ��ü : Geometric object
# Base_graphics���� �׷��� �ۼ� ��� : pen on paper
# ���� ������ �׷��� �Լ� : ��ǥ��� �ֿ� �׷��� �ۼ�
# ���� ������ �׷��� �Լ� : ��,��,���� ���� �߰��Ͽ� ���ϴ� �׷��� �ۼ�
# ggplot2���� ���и� �ۼ� ���
# �ۼ��ϰ��� �ϴ� �׷��� : ��� ������ �׷���(��,�� ���)
# ��� ������ �׷����� ���� ���� �ۼ�
# �ۼ��� �׷����� ���� �������ν� ���ϴ� �׷��� �ۼ�

# ���ϴ� ������ �׷���(��,�� ���) �ۼ�
# = �ش�Ǵ� ���� ��ü(geom)�� ����Ͽ� �׷��� �ۼ�
  

# ���� ��ü�� ���
# �ش�Ǵ� geom �Լ��� ����
# geom �Լ� ���� -> �ش� ������ �׷����� �ۼ��� layer �ۼ�
# ���� ���� geom �Լ� ���� : ���� layer �����ǰ� �̰͵��� �������� ���ϴ� �׷��� �ۼ�

ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))
ggplot(data=mpg)+geom_smooth(mapping=aes(x=displ,y=hwy))

#�۷ι� ���ΰ� ���� ����
ggplot(data=mpg)+geom_point(mapping=aes(x=displ,y=hwy))+geom_smooth(mapping=aes(x=displ,y=hwy))

#�۷ι� ����
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point()+geom_smooth()

#���� �� �߰�
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv))+geom_smooth(se=FALSE)
#
ggplot(data=mpg,mapping=aes(x=displ,y=hwy,color=drv))+geom_point()+geom_smooth(se=FALSE)
#drv�� ���� ���� ���� ���� ����,���� ������ �ٸ����ϸ�,���� ũ�� Ȯ��
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv),size=2)+
geom_smooth(mapping=aes(linetype=drv),se=FALSE)

#���� drv�� �׷캰�� ���� ���� ȸ�Ͱ �ۼ��ϵ�, ���� ���� ������ ���� ���� ���
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point()+
geom_smooth(mapping=aes(group=drv),se=FALSE)

#�� geom �Լ����� �ٸ� ������ ���
#mpg�� ���� displ�� hwy�� ������ drv�� ���� ���ǻ� ����
#���� ȸ�Ͱ �߰��ϵ� drv�� 4�� �����͸��� ������� ����
ggplot(data=mpg,mapping=aes(x=displ,y=hwy))+
geom_point(mapping=aes(color=drv),size=2)+
geom_smooth(data=filter(mpg,drv=="4"),se=FALSE,color="red")