 #로지스틱 회귀모형

 # 8장 정형 데이터 마이닝

 # 01. 데이터 마이닝 개요 : 거대한 양의 데이터 속에서 쉽게 드러나지 않는 유용한 정보를 찾아내는 과정

 # (1) 분류 : 의사결정나무, memory-based reasoning 등
 # (2) 추정 : 연속된 변수값 추정. 신경망 모형
 # (3) 예측 : 장바구니 분석, 의사결정나무, 신경망 등
 # (4) 연관분석 : 장바구니분석
 # (5) 군집 : 데이터마이닝이나 모델링의 준비 단계
 # (6) 기술

 # 데이터마이닝 5단계 : 목적 정의 - 데이터 준비 - 데이터 가공 - 데이터 마이닝 기법 적용 - 검증

 # 02. 분류분석 

 # 1. 로지스틱 회귀모형 *** : 반응변수가 범주형인 경우. 즉 두가지 범주로 되어있을 때, 종속변수와 독립변수간의 관계식을 이용해 두 집단 분류
  # 회귀 분석이기에 지도학습으로 분류(Supervised Learning). 선호되는 이유? 독립변수에 대해 어떠한 가정도 필요x, 연속성 및 이산형 모두 가능함.

 # 오즈비(Odds ratio) : 변수가 성공/실패로 구성된다면, 한 집단이 다른 집단에 비해 성공할 승산의 비에 대한 측정량
       # 성공률/실패율 = Pi/(1-Pi)
  # 오즈비는 음이 아닌 실숫값. 성공 가능성 높은 경우 1.0보다 큰 값, 실패가 일어날 가능성이 높으면 1.0보다 작은 값 가짐


 # 온도에 따른 거북이 알의 수컷, 암컷 결과 실험
x<-c(27.2,27.7,28.3,28.4,29.9) #온도
male<-c(2,17,26,19,27) #수컷 수
female<-c(25,7,4,8,1) #암컷 수
total=male+female #합계
pmale<-male/total #수컷 비율

 # 독립변수 : 온도, 종속변수 : 수컷비율
  # 단순선형회귀식
z<-lm(pmale~x) #회귀분석(종속~독립)
summary(z)

 #추정 회귀식 : 수컷비율 = -6.9020+0.2673*온도
p<-coefficients(z)[1]+coefficients(z)[2]*x
p
 # 1보다 큰 값이 존재함

 #로짓변환 값 log(pmale/(1-pmale))을 종속변수로 한 단순성형회귀식 추정.
   # 적절한 변환 통해 곡선을 직선 형태로 바꿀 수 있음

logit<-log(pmale/(1-pmale))
z1<-lm(logit~x)
summary(z1)

# 예측값 수컷비 출력
logit2<-coefficients(z1)[1]+coefficients(z1)[2]*x
rmalehat<-exp(logit2)/(1+exp(logit2))
rmalehat
# 로짓변환하여 온도별 예측 확률값은 0~1 사이 값 가짐

# 최대우도추정법 : 관측값들이 가정된 모집단에서 하나의 표본으로 추출될 가능성이 가장 크게 되도록 하는 회귀계수 추정법

logit<-glm(pmale~x,family = "binomial",weights = total)
summary(logit)
 # 추정 회귀식 : 수컷 비율 = -61.3183+2.211*온도.  27.3도에서 암컷과 수컷을 구분짓는 경계값이 됨

 # 회귀 계수 해석
exp(-61.3183)*exp(2.211*27) #27도에서 오즈 예측값. 0.2
exp(-61.3183)*exp(2.211*28) #28도에서 오즈 예측값. 1.8
 #28도에서 오즈 예측값은 27도에서의 오즈 예측값보다 exp(2.211)차이.
 #28도에서 암컷에서 수컷으로 부화할 가능성은 0.2*9.125=1.825


 # iris 데이터를 이용한 로지스틱 회귀
iris
colnames(iris)<-tolower(colnames(iris)) #컬럼명 소문자로 변환
a<-subset(iris,species=="setosa"|species=="versicolor")
#로지스틱 회귀를 하기 위해 범주가 2개인 setosa=1과 versicolor=2만 추출.
a$species<-factor(a$species) #2개 레벨을 가진 새로운 factor(범주)형

 #glm() : 선형회귀분석 lm과 유사. glm(모형,data,family="binomial")
b<-glm(species~sepal.length,data=a,family = binomial)
summary(b)

 # sepal.length p-value 유의수준보다 낮아 매우 유의한 변수다.
coef(b)
 #sepal.length : 5.140336 (회귀계수)

 #로지스틱 회귀계수 값은 exp(5.140336)의 값이므로 약 170배가 된다.
exp(coef(b))["sepal.length"]
 #sepal.length가 한 단위 증가함에 따라 Vericolor일 오즈가 10배 증가

fitted(b)[c(1:3,98:100)]
 #로지스틱 모델은 0 또는 1로 값을 예측하기에, 0.5이하면 setosa, 0.5이상이면 versicolor 예측값을 의미
predict(b,newdata = a[c(1,50,51,100),],type = "response")
 #type을 response로 지정하고 예측 수행하면, 0~1 사이 확률 구해줌
cdplot(species~sepal.length,data=a)
#연속형 변수의 변화에 따른 범주형 변수의 조건부 분포를 보여줌.
 #즉 sepal.length가 증가함에 따라 veriscolor의 확률이 증가함을 보여준다.

#다항 로지스틱 회귀분석 : 32종류의 자동차에 대한 11개 변수값 측정 자료
attach(mtcars) #attach는 코드에서 필드이름만으로 데이터에 바로 접근 가능
str(mtcars)

 #이항변수 vs(0:flat engine, 1:straight engine)를 반응변수로,
 #mpg와 am(Transmission: automatic=0, manual=1)을 예측변수로 하는 로지스틱 회귀모형 추정

vs
mpg
am

glm.vs<-glm(vs~mpg+am,data=mtcars,family = "binomial")
summary(glm.vs)
 # 해석
 #am이 주어질 때, mpg값이 한 단위 증가할 때 vs=1 오즈가 exp(0.6809)=1.98(98%) 증가
 #mpg가 주어질 때 오즈가 대한 am의 효과는 exp(-3.0073)=0.05배. 변속기가 수동인 경우 자동에 비해 vs=1의 오즈가 95% 감소

anova(glm.vs,test="Chisq") #모형의 적합 단계별로 이탈로의 감소량과 유의성 검정 결과 제시

#Mcfadden R square로 모델 fit 확인 가능
install.packages("pscl")
library(pscl)
pR2(glm.vs)
 #R square 값이 0.69로, 데이터셋의 분산의 약 69.1% 설명

