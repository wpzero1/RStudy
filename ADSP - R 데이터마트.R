
# 02. 데이터 마트 (* 기출)

# 데이터 마트란 데이터의 한 부분, 특정 사용자가 관심을 갖는 데이터를 담은 비교적 작은 규모의 DW.

 # 1. R reshape2의 melt(), cast() 함수 (** 기출)

   # 데이터를 통계분석에 필요한 데이터 구조로 재구조화(reshaping)하는 작업

# melt() 여러 변수로 구성된 데이터를 데이터 id, variable, value 형태로 재구성
# cast() : melt()된 데이터를 다시 여러 칼럼으로 변환, reshape2
 
 # 2. reshape 활용

install.packages("reshape")
library(reshape)
install.packages("reshape2")
library(reshape2)

data(airquality) #데이터 불러오기
colnames(airquality) <-tolower(colnames(airquality))
head(airquality) #앞부분 데이터 일부 보기
head(airquality,3) # 데이터 조회 개수 정하기

#(* 기출) : 명령어들

names(airquality) #변수명 알고싶을 때
names(airquality) <-tolower(colnames(airquality)) #대소문자가 구분되는 R에서, 변수명 변환하는 명령어

T<-melt(airquality,id=c("month","day"),na.rm=TRUE)
T
#melt id에 있는 변수를 기준으로 나머지 변수를 variable이란 이름의 데이터로 만듬.
#여러 변수를 하나의 명목형 변수로 reshape하여 시각화 하기 편하게 하기 위함

cast(T,day~month~variable) #행을 day, 열을 month로 각 변수를 새롭게 배열
b<-acast(T,month~variable,mean) #각 변수들의 month 평균
b

d<-cast(T,month~variable,mean,margins = c("grand_rw","grand_col"))
#margin 관련 옵션, 행과 열에 대한 합계 산출

e<-cast(T,day~month,mean,subset=variable=="ozone")
e
#subset 기능을 이용해, 특정 변수(ozone)만 처리하도록 함

f<-cast(T,month~variable,range)
f
#range기능은 min은 _X1이라는 변수, max는 _X2라는 변수명을 끝에 붙여줌


#sqldf 패키지 : sql사용

install.packages("sqldf")
library(sqldf)
data(iris) #세종류의 붓꽃 종류, 붓꽃 종은 Speices 컬럼에 저장됨
sqldf("select * from iris") # " " 안에 sql문 적기

sqldf("select * from iris limit 10") #특정 행수만 조회(head와 동일)
sqldf("select count(*) from iris where species like 'se%'") #se로 시작되는 붓꽃 speicies의 개수를 셈

# 4 plyr (***)
#ply() 함수는 앞에 두개의 문자를 접두사로 가진다. 첫번째 문자는 입력 데이터 형태, 두번째는 출력 데이터 형태.
 #ddply는 데이터프레임을 입력, 출력한다

#Plyr 패키지는 데이터를 분리하고, 특정함수를 적용, 결과를 재결합하는 함수

set.seed(1) #난수를 생성할때마다 같은 값의 난수 생성
d<-data.frame(year=rep(2012:2014, each=6),count=round(runif(9,0,20)))
#2012 ~2014 각각 6개를 만들고 count라는 변수에 난수 생성하는 runif(난수의 수, 최솟값, 최댓값)을 이용, 0~20사이 정수 9개 저장

d

install.packages("plyr")
library(plyr)

#ddply 이용해 sd(표.편), mean의 비율인 cv(변동계수) 구하기
 # ddply(data, 변수, fun=NULL)
 # adply는 행 또는 컬럼 단위로 함수 적용하지만, ddply는 변수들에 나열한 컬럼에 따라 데이터 나눈뒤 함수 적용

ddply(d,"year",function(x){
  mean.count=mean(x$count)
  sd.count=sd(x$count)
  cv=sd.count/mean.count
  data.frame(cv.count=cv)
})

summarise() #데이터 요약정보를 새로운 변수에 만드는 함수 *
ddply(d,.(year),summarise,mean.count=mean(count))

transform() #연산 결과를 df의 새로운 컬럼에 저장
ddply(d,.(year),transform,total.count=sum(count))
