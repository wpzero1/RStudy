
# ** 2. 신경망 모형

 # 1) 인공신경망 : 분류 및 군집화 (데이터 위에 여러가지 층을 얹어서 작업함)
 # Input Layer -> Hidden Layer -> Output Layer. 은닉층의 노드는 주어진 입력에 따라 활성화되고, 출력값을 계산하여 출력층에 전달한다.

 # 스팸 분류, 불만족 고객 분류 등
 # 지도학습의 한 방법으로, 역전파알고리즘 또는 예측분석에 사용.
 # neuralnet과 nnet 활용 **

# 2) 신경망 학습은 가중치(Weight)의 조절 작업
 # 원리
  # 입력값 -> 입력층, 모델의 출력값이 원하는 출력값과 같은지 확인하고, 같지 않으면 가중치 조절
  # 즉 Output = f(w0+w1*input1+w2*input2...) 즉, 가중치와 input값의 합들.
 # f를 활성함수라 하는데, 결과의 범위를 제한하고 계산의 편의성을 제공. 시그모이드 함수(미분 용이), 부호함수, 소프트맥스 함수 등

 # 3) 신경망의 은닉층 및 은닉 노드 수를 정할 때 고려 사항 *
    # 다층 신경망은 단층에 비해 훈련 어려움
    # 노드가 많을수록 복잡성을 잡아내기 쉬우나 과적합 가능성 높음
    # 은닉층 노드가 너무 적으면 복잡한 의사결정 경계 만들 수 없다
    # 시그모이드 활성함수를 가지는 2개 층의 네트워크는 임의의 의사결정 경계를 모형화
    # 출력층 노드 수는 출력 범주의 수로, 입력은 입력 차원의 수로 결정

 # 4) 장점 **
    # 변수의 수가 많거나 입출력 변수간에 복잡한 비선형 관계에 용이
    # 잡음에 민감하게 반응 x
    # 입력, 결과변수가 연속 / 이산형인 경우 모두 처리 가능
 
 # 5) 단점 *
    # 결과 해석 쉽지 않ㅇ
    # 최적 모형 도출 어려움
    # 데이터 정규화 하지 않으면 지역해(local minimum)에 빠질 위험
    # 모형 복잡하면 시간 소요 많음음

# 예제 : iris 자료에 대한 신경망 모형 분석

colnames(iris)<-tolower(colnames(iris))
install.packages("nnet")
library(nnet)
data<-iris
Scale<-data.frame(lapply(data[,1:4], function(x) scale(x)))
Scale$species<-data$species
index<-sample(1:nrow(Scale),round(0.75*nrow(Scale)),replace=FALSE)
#신경망 모형 적합 전 scaling(정규화) 필요

train<-Scale[index,] #데이터 분할(train/test)
test<-Scale[-index,]
model<-nnet(species~.,size=2,decay=5e-04,data=train)
summary(model)
 # 출력, 은닉, 입력 노드의 수와 가중치의 수를 보여주고,
 # 입력 -> 은닉 노드로 가는 가중치 값 / 은닉 -> 출력으로 가는 가중치 값을 보여줌

 #신경망 모델 검증 : predict 함수 : 테스트 집합에 대한 에측 결과 벡터로 제공
predict.model<-predict(model,test[,1:4],type="class")
predict.model

#오분류표를 만들기 위해 table 함수 이용, 실제 결과와 예측 ㄱ려과 교차표 작성
actual<-test$species
confusion.matrix<-table(actual,predict.model)
confusion.matrix

Table<-table(test$species, predict.model)
#accuracy는 예측한 값이 true든 false든 상관없이 정확히 예측한 값의 비율을 나타냄
accuracy<-sum(diag(Table))/sum(Table)
accuracy
sum(predict.model==actual)/NROW(predict.model)
# 92.1%의 정확도

