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
# �밢�� �г� �鼱 diag=list(continuous=,discrete=)
# �׷��� �ۼ��� ����Ʈ �� ���� wrap()



# ���� ����
# - �밢�� �Ʒ��� �г� ����
# - ������ ����: �������� ȸ������ �߰�
# - combo: facet ������׷��� ���� ������ 10���� ����

# �ð��� ��� color�� ���� am ����
ggpairs(mtcars_2,aes(color=am),
        lower=list(continuous=wrap("smooth",se=FALSE),combo=wrap("facethist",bins=10)))
