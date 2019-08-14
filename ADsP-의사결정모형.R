
# 3. 의사결정나무 모형 **

 # 큰 장점은 분석 과정이 직관적이고 이해하기 쉬움.
 # 의사 결정 규칙을 나무 구조로 나타내어, 전체 자료를 몇개의 소집단으로 분류 / 예측함

 #iris 자료 의사결정나무 분석 (rpart 패키지)

colnames<-tolower(colnames(iris))
install.packages("rpart")
library(rpart)
k<-rpart(Species~.,data=iris)
k

# 결과해석
# 
# n= 150  150개의 데이터가 있음
# 
# node), split, n, loss, yval, (yprob)
# * denotes terminal node

# 결과의 들여쓰기는 가지가 갈아지는 모양. *은 잎사귀 노드, 각 노드에서 괄호안에 표시된 숫자는 species별 비율

# 1) root 150 100 setosa (0.33333333 0.33333333 0.33333333)  
#   2) Petal.Length< 2.45 50   0 setosa (1.00000000 0.00000000 0.00000000) *

    # 뿌리노드에서 좌측 가지 밑에 위치한 노드. <2.45 기준 만족하는 경우 setosa,50개 데이터

#   3) Petal.Length>=2.45 100  50 versicolor (0.00000000 0.50000000 0.50000000)  
#     6) Petal.Width< 1.75 54   5 versicolor (0.00000000 0.90740741 0.09259259) *
#     7) Petal.Width>=1.75 46   1 virginica (0.00000000 0.02173913 0.97826087) *
 
plot(k,compress=T,margin=.3)
text(k,cex=1.0)

#rpart.plot() 함수를 통한 시각화.

install.packages("rpart.plot")
library(rpart.plot)
prp(k,type=4,extra=2,digits=3) #type=4 : 모든 노드에 레이블, extra=2 : 관측값과 각 노드에서 올바르게 예측된 데이터 비율
 #Petal.Length<2.45인 경우 붓꽃의 종이 setosa로 예측. 50개 모두 실제 setosa로 예측됨

#rpart()를 사용한 예측 predit() 수행, 정확성 평가 (ConfusionMatrix)

head(predict(k,newdata=iris,type="class"))
#printcp(k) : error 제일 낮은 부분 찾기
printcp(k)
#nsplit 3이 가장 error가 낮다
plotcp(k)

install.packages("caret")
library(caret)
install.packages("e1071")
library(e1071)
install.packages("Rcpp")
library(Rcpp)
install.packages("rlang")
library(rlang)
install.packages("tidyselect")
library(tidyselect)
#깔아도 일부 작동이 안되다보니, package들을 설치했다.

rpartpred<-predict(k,iris,type='class')

caret::confusionMatrix(rpartpred, iris$Species)
 #iris 셋의 species 예측한 후, 모델 정확성 평가

#정확도 96%

