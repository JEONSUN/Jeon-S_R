 #1) �Լ� f�� ���� 
f <- function(x, y)
  {r<-sqrt(x^2+y^2)10*sin(r)/r}
#2) ����  ���� x, y�� ����
x<- y<- seq(-10,10,length=30)

x <-y <- seq(-10,10,length=30)
z <- outer(x,y,f)
persp(x,y,z,col="steelblue")

library(rgl)


volcano

persp(volcano,col="springgreen")


# MASS :: topo �ڷ�
# ������ 310��� feet�� ��� ������ ���� ����
# x,y : ���Ͱ��ƴ�, z : ����� �ƴ�
# �־��� �ڷ�δ� ���õ� �ۼ� �Ұ�
# �־��� �ڷḦ �̿��Ͽ� ������ ���� �� ������� �����ؾ���.


## ���� ���� �� ����ǥ�� ����
### akima::interp()�� ���� �̺��� ������

library(MASS)
library(akima)
topo
topo.inter=with(topo,interp(x,y,z))
topo.inter  

topo.spline=with(topo,interp(x,y,z,linear=FALSE))

persp3d(topo.spline,col="purple")


# ���� 4) ����
lat=matrix(seq(90,-90,len=50)*pi/180,50,50,byrow=TRUE)
long=matrix(seq(-180,180,len=50)*pi/180,50,50)

r=6378.1
x=r*cos(lat)*cos(long)
y=r*cos(lat)*sin(long)
z=r*sin(lat)

persp3d(x,y,z,col="white",
        texture=system.file("textures/world.png",package="rgl"),
        specular="black",axes=FALSE,box=FALSE,
        xlab="",ylab="",zlab="",
        normal_x=x,normal_y=y,normal_z=z)