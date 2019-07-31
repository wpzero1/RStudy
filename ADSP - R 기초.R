
#데이터 프레임 만들기

df <- data.frame( x=c(1:5), y=seq(2,10,2), z=c('a','b','c','d','e'))
df

df$x #칼럼명 참조


#########

# 6장 R기초와 데이터 마트

# 01. R의 기초 함수

 # 1) 수열 생성 (** 기출)
rep(1,3) #rep(해당 숫자, 반복 횟수)

rep(2:5, 3)

seq(1,3) #seq : 첫번째 인수부터 두번째 인수까지 1씩 증가하는 숫자 벡터

seq(1,11, by=2) #by=n n씩 증

seq(1,11, length=7) #length=m 옵션 : 전체 수열 개수가 m

# 2) 기초 행렬 계산

a <- 1:10
a
a+a
a-a
a/a

a<-c(2,7,3)
a
t(a) #전치행렬

z<-a%*%t(a) #행렬간 곱을 만드는 전치행렬 식
z

# *을 통한 스칼라 곱
A <- matrix(c(23,41,12,35,67,1,24,53,7), nrow=3)
A

5*A
solve(A) #역행렬

# 3) 기초 대표값 및 분산
c <- 1:10
mean(c) #평균

var(c) #분산

sd(c) #표준편차

# 4) 기초적인 변환 및 상관계수, 공분산 (*기출)
sum(c)
median(c)
log(c)

a <- 1:10
c<-log(c)
cov(a,c) #공분산
cor(a,c) #상관계수 

summary(a) #주어진 벡터에 대한 사분위수 통계값

# 5. R 데이터 핸들링 (객체지향 언어 활용)

#벡터형 변수 (** 기출)

b<- c("a","b","c")
b

b[2] #대괄호는 b벡터 내 n번째 원소 불러옴

b[-3] #- 붙이면 n번째 원소 빼고 불러옴

b[c(1,2)] #b벡터의 1,2번째 위치 값 선택 

# 1) 반복구문과 조건문 (* 기출)

 # (1) for 반복 구문

a<-c() # 아무런 값도 포함하지 않는 a 벡터
#괄호 안 조건 하에 i값 하나씩 증가시켜 중괄호 안 구문 반복실행

for(i in 1:9) {
   a[i]=i*i
}

a

# (2) while 반복 구문
# 괄호 안 조건 하에서 {} 안 구문 반복. 조건 만족할 때까지 구문 반복

x=1
while(x<5) {
  x = x+1
  print(x)
}

# (3) if~else 조건문
# Ifelse(조건문, true값, false값)

x<-1
ifelse(x>0, '양수','양수아님')

# 2) 사용자 정의 함수
 #Function 명령어를 이용해 직접 만든다.
 #인수 a를 이용해 i=1로부터 i=a 까지 반복하는 for 구문 사용해서 수열 생성, 모든 i값 더하는 함수 정의하기

foruse <- function(a){
  isum<-0
  for(i in 1:a){
    isum=isum+i
  }
  print(isum)
}

foruse(3)

 # 3) 기타 유용한 기능들 (** 기출)

# (1) paste : 입력받은 문자열들을 하나로 붙여준다

number <- 1:5
alphabet<-c("a","b","c")
paste(number,alphabet)

paste(number,alphabet,sep=" to the ") #sep 옵션을 통해 붙이고자 하는 문자열 삽입

# (2) substr ; 글자에서 구간 추출
country<-c("korea","japan")
substr(country,1,2)

# (3) 자료형 데이터 구조 변환
as.data.frame(x) #데이터프레임
as.list(x) #리스트
as.matrix(x) #행렬
as.vector(x) #벡터
as.factor(x) #factor형식

as.integer(3.14) #실수형 -> 정수형 벡터
as.numeric("foo") #foo 문자형 데이터를 수치형 데이터로 강제변환. but "foo"는 숫자형이 아니라 결측치인 NA 출력
as.numeric(FALSE) #True는 0, False는 1
as.logical(0.45)

# (4) 문자열을 날짜로 변환
as.Date("2019-07-31")

as.Date("07/31/2019",format="%m/%d/%Y")#기본 형식은 yyyy-mm-dd이기에, 다른 형식을 처리하려면 형식 지정

format(Sys.Date()) #현재날짜

format(Sys.Date(),format="%m/%d/%Y") #포맷 형식대로 출력

format(Sys.Date(),'%a') #요일
format(Sys.Date(), '%b') #월
format(Sys.Date(), '%Y') #네자리 숫자 연도
format(Sys.Date(), '%y') #두자리 숫자 연도

# 6. R 그래픽 기능

 # 1) 산점도 그래프 (** 기출)

   #산점도 패키지는 plot(x,y)

math<-c(95,65,80,92,60,75,88,100,75,68)
scie<-c(90,70,80,95,65,70,85,95,70,60)
plot(math, scie)

# 2) 산점도 행렬 (** 기출)
 #pairs 명령어로 범주(그룹)를 색깔로 구분
pairs(iris[1:4], main = "Anderson's Iris Data -- 3 species", pch=21, bg = c("red","green3","blue")[unclass(iris$species)])
#main은 제목표기,pch는 점의 모양, bg는 species에 따른 다른 색상 부여

# 3) 히스토그램과 상자그림 (*기출)

height <-c(182,160,165,170,163,160,181,166,159,145,175)
hist(height)
boxplot(height)

#다양한 옵션
hist(grade$grade, breaks=3) #계급구간의 수 설정
hist(grade$grade, probability=T) #상대도수 히스토그램
hist(grade$grade, probability=T, main="학생성적", ylim=c(0,0.04)) #그래프 제목, y축 설정

#활용
hist(height, breaks=3, probability=T, main = "키 도수분포표", ylim=c(0,0.04))

