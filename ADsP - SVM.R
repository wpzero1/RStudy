
 # 5. 서포트 벡터 머신(SVM, Support Vector Machine)

 # 서로 다른 분류에 속한 데이터 간의 간격이 최대가 되는 선을 찾아, 이를 기준으로 데이터 분류
 # Kerlab, e1071 등 패키지
 # 그림처럼 특징에 따라 서로 유사한 그룹끼리 칸막이를 쳐서 나누는 것. 칸막이를 초평면이라 부름(hyperplane)

 # 장점 : 에러율이 낮고 결과 해석 용이
 # 단점 : 튜닝 파라미터 및 커널 선택에 민감, 이진분류만 다룰 수 있음

# iris 데이터 분류 및 예측
iris
head(iris)
install.packages("e1071")
library(e1071)
s<-sample(150,100) #150중 100 샘플링
col<-c("Petal.Length","Petal.Width","Species") #컬럼명 지정
col
iris_train<-iris[s,col] #train 데이터셋
iris_test<-iris[-s,col] #test 데이터셋

#linear kernerl 방식으로 modeling
iris_svm<-svm(Species~.,data=iris_train,cost=1,kernel="linear")
 #cost : 커널 파라미터 cost, kernel : 커널 함수
plot(iris_svm, iris_train[,col])
 #svm train vs test 결과 예측

p<-predict(iris_svm,iris_test[,col],type="class")
plot(p)
table(p,iris_test[,3])

 #SVM을 잘 적용하려면 파라미터값을 정하는 것이 중요. 파라미터, 즉 SVM에서 Cost는 데이터를 얼마나 잘 나누는지와 잘못 구분한점으로 인한 비용의 합을 최소화하는 선을 찾는다. 즉 Cost를 사용해 과적합 정도 조절.