
# 4. 앙상블 모형 : 여러개의 분류모형에 의한 결과 종합, 분류의 정확도를 높이는 방법

 # 1) 배깅(Bagging : bootstrap aggregating) : 원 데이터 집합으로부터 크기가 같은 표본을 여러번 단순 임의 복원추출, 각 표본에 대해 분류기를 생성 후 그 결과를 앙상블.

 # 일반적으로 OVERFITTING 모델에 사용하면 좋다.

#예제
install.packages("adabag")
library(adabag)
library(rpart)
data(iris)
set.seed(1) #난수 생성기. 같은 분석 결과 확인
train<-c(sample(1:50,25), sample(51:100,25), sample(101:150,25))
#species에서 각각 25개 sampling
iris.bagging<-bagging(Species~., data=iris[train,], mfinal=10,control=rpart.control(maxdepth=1))
# mfinal : tree 반복생성 횟수, control은 tree분석의 rpart.control 적용, maxdepth는 최대 깊이
iris.bagging

iris.bagging$importance #가장 큰 기여를 하는 변수는 Petal.Length (70.32%)

barplot(iris.bagging$importance[order(iris.bagging$importance,decreasing=TRUE)],ylim=c(0,100),main="Variables Relative Importance", col="red")

table(iris.bagging$class, iris$Species[train], dnn=c("Predicted Class", "Observed Class"))
 #하나가 잘못 분류되었음.

1-sum(iris.bagging$class == iris$Species[train]) /length(iris$Species[train])
 #error : 1.3%
iris.predbagging <- predict.bagging(iris.bagging, newdata=iris[train,])
iris.predbagging
 #predict() 함수 써도 결과는 동일

 # 2) 부스팅
 #배깅의 과정과 유사하나, sampling 과정에서 분류가 잘못된 데이터에 더 큰 가중을 주어 표본 추출 (Adaboosting)

library(adabag)
set.seed(1)
train<-c(sample(1:50,25),sample(51:100,25),sample(101:150,25))
iris.adaboost<-boosting(Species~.,data=iris[train,],mfinal=10,control=rpart.control(maxdepth=1))
iris.adaboost

iris.adaboost$weights #배깅과 다른 점

barplot(iris.adaboost$importance[order(iris.bagging$importance,decreasing=TRUE)],ylim=c(0,100),main="Variables Relative Importance", col="red")

table(iris.adaboost$class, iris$Species[train,],dnn=c("Predicted Class", "Obeserved Class"))
#결과는 동일

# 3) 랜덤 포레스트
 # 배깅에 랜덤 과정을 추가한 방법. 예측변수들을 임의로 추출하고, 추출된 변수 내에서 최적의 분할을 만들어나감
 # 의사결정나무를 여러개 사용해, overfitting 문제 피할 수 있음

install.packages("randomForest")
library(randomForest)
library(rpart)
data(stagec)
stagec3<-stagec[complete.cases(stagec),]
# complete.cases() : 해당 행의 모든 값에 NA 있는지 확인
 
#데이터 분할 (training, test set)
 #nrow(stagec3) : stagec3의 행 개수, 즉 1,2라는 범주를 샘플링
 #replace=TRUE 복원추출. prob=c(0.7, 0.3) 범주 1을 70%, 2를 30% 뽑음
set.seed(1234)
ind<-sample(2,nrow(stagec3),replace=TRUE,prob=c(0.7,0.3))
 #데이터 일부분을 복원추출로 꺼내고, 해당 데이터에 대해서만 의사결정 나무를 만듬
train<-stagec3[ind==1,]
test<-stagec3[ind==2,]
rf<-randomForest(ploidy~.,data=train,ntree=100,proximity=T,importance=T)
 #proximity 분석 대상 자료 간의 유사도를 산정한 값
table(predict(rf),train$ploidy)
print(rf)

 #confusion matrix(정오 분류표) OOB(out of bag) : 모델 훈련에 사용되지 않은 데이터를 사용한 에러 추정치

varImpPlot(rf)
 #정확도는 g2가 제일 높고, 불순도 개선 기여도 역시 g2가 가장 높다.

