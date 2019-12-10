 #1) 함수 f의 정의 
f <- function(x, y)
  {r<-sqrt(x^2+y^2)10*sin(r)/r}
#2) 격자  벡터 x, y의 정의
x<- y<- seq(-10,10,length=30)

x <-y <- seq(-10,10,length=30)
z <- outer(x,y,f)
persp(x,y,z,col="steelblue")

library(rgl)


volcano

persp(volcano,col="springgreen")


# MASS :: topo 자료
# 면적이 310평방 feet인 어느 지역의 지형 정보
# x,y : 벡터가아님, z : 행렬이 아님
# 주어진 자료로는 투시도 작성 불가
# 주어진 자료를 이용하여 벡터의 구성 및 반응행렬 추정해야함.


## 격자 구성 및 반응표면 추정
### akima::interp()에 의한 이변량 보간법

library(MASS)
library(akima)
topo
topo.inter=with(topo,interp(x,y,z))
topo.inter  

topo.spline=with(topo,interp(x,y,z,linear=FALSE))

persp3d(topo.spline,col="purple")


# 예제 4) 지구
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
