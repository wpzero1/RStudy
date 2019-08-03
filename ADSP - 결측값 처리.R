# 03. 결측값 처리와 이상값 검색

 # 한번에 주석 처리는 ctrl shift c
# 
# 1. 결측값의 대치법
# 
# 1) 완전히 응답한 개체분석 - 완전한 것만. 효율성과 통계척 추론 타당성 문제.
# 
# 2) 평균대치법 : 평균값으로 결측값 대치해서 불완전 -> 완전 자료화.
# 
# 3) 단순 확률 대치법 : 평균대치법에서 추정량 표준오차의 과소 추정문제 보완. Hot-deck2, NearestNeighbour 2방법 등.
# 관측된 자료 토대로 추정된 통계량으로 결측값 대치할 때 어떤 적절한 확률값 부여한 후 대치
# 
# 4) 다중대치법 : 결측치를 가진 자료 분석에 용이. 단 추정량 표준오차의 과소 추정 등의 문제
# 
# 2. 데이터 기초 통계
# 
#  결측값 처리 관련 패키지 : Amelia II, Mice, mistools
#  NA(Not Available)는 결측값, 불가능한 값은 NaN(Not a Number)
#

install.packages("Amelia")
library(Amelia)

 y <- c(1,2,3,NA)
is.na(y)  #결측값 여부 확인 **

mydata[mydata$v1==99,"v1"]<-NA
# mydata의 v1변수 내에 99를 결측값 처리하기.

#해당 값 제외
x<-c(1,2,NA,3)
mean(x)
mean(x,na.rm=T) #제외하는 것. na.rm=T
Complete.cases()

french_fries[!complete.cases(french_fries),]
#해당 데이터 중에 comeplete.cases() 함수 이용한 결측값 확인

#Amelia 패키지 활용한 결측값 imputation

 # 결측값이 너무 많은 레코드에 분포하면 너무 많은 자료가 삭제되서 분석하기 어렵다. 그래서 결측값을 해당 변수의 대푯값으로 대체하는 경우도 있는데 문제가 있음.
 #그래서 변수들간의 관계를 이용해 imputation함

data(freetrade)
head(freetrade)

a.out<-amelia(freetrade,m=5,ts="year",cs="country") #m=imputation 데이터셋 수

#3번째 imputation 데이터셋 적용된 tariff 변수를 히스토그램으로
hist(a.out$imputations[[3]]$tariff, col="grey", border="white")

save(a.out,file="imputations.RData") #저장
write.amelia(obj=a.out,file.stem = "outdata") #데이터셋 각각 저장

missmap(a.out) #결측값 처리 전 결과

freetrade$tariff<-a.out$imputations[[5]]$tariff #imputation 값을 데이터셋 사용
missmap(freetrade)

# # 4. 이상값 검색 ***
#  - 의도하지 않게 잘못 입력한 Bad data
#  - 분석 목적에 부하하지 않아 제거
#  - 의도되지 않은 현상이나 분석에 포함해야 하는 경우 (이상값)
#  - 의도된 이상값

x<-rnorm(100) #표준정규분포를 따르는 난수 100개 생성
boxplot(x)
x<-c(x,19,28,30) #고의로 이상값 생성
outwith=boxplot(x)

#outlier 패키지 사용
install.packages("outliers")
library(outliers)
set.seed(1234)
y=rnorm(100)
outlier(y) #평균과 가장 차이가 많이 나는 값 출력 * 
outlier(y,opposite=TRUE) # 반대 방향으로 가장 차이가 많이 나는 값 출력

dim(y)<-c(20,5) #행 20, 열 5 행렬 생성
outlier(y)
outlier(y,opposite=TRUE) #각 열별로 반대 방향으로 열 평균과 가장 차이 많은 값 출력
boxplot(y)
