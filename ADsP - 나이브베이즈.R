
# 6. 나이브 베이즈 분류모형
 # 베이즈 정리에 기반한 방법, 사후확률(일종의 조건부 결합확률) 계산 시 조건부 독립 가정하여 계산 단순화.
 # 사후확률이 큰 집단으로 새로운 데이터 분류

library(e1071)
data(iris)
colnames(iris)<-tolower(colnames(iris))
m<-naiveBayes(species~.,data=iris)
m


Conditional probabilities:
  sepal.length
Y             [,1]      [,2] # [,1]setosa 평균 [,2]setosa 표준편차
setosa     5.006 0.3524897
versicolor 5.936 0.5161711
virginica  6.588 0.6358796


table(predict(m,iris[,5]),iris[,5],dnn=list('predicted','actual'))


# 장점 : 지도학습 환경에서 매우 효율적 훈련, training data가 적어도 사용 가능
# 단점 : training data에는 없고 test data에 있는 범주에서는 확률이 0으로 나타나 정상적인 예측 불가. (각 분자에 +1을 줘서 해결 가능) / 서로 확률이 독립적이라는 가정 위반되면 오류

