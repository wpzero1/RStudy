# https://studymaps.tistory.com/2?category=762998

# 변수값 할당

x <- c(1,2,3)
mean(x)

# 데이터 형식

#숫자
a <- 3
b <- 4.5
c <- a+b
print(c)

#NA 값(Not Available) : 데이터 값이 없음. 결측치.

one <- 80
two <- 90
three <- 75
four <- NA

is.na(four) #변수에 NA 값이 저장되어있는지 확인하는 함수

#NULL : 변수가 초기화 되지 않았을 때. 미정 
x <- NULL
is.null(x)

#문자열 : 따로 한개 문자에 대한 데이터 타입 char가 없다
a <- "hello"
print(a)



#자료형 확인 함수
mode(1)
mode("nu")
typeof(1L) #L부호는 정수형으로 저장하도록 하는 것
mode(TRUE)
mode(3+4i) #복소수형
typeof(2.1) #실수



#-------------------------#
#자료 구조
# 1) 원자 벡터(atomic vector)
# 가장 기본이 되는 자료 구조로, 다양한 자료형을 요소로 갖는 집합
#한 벡터 내의 타입은 항상 같아야 한다
#가장 간단한 방법은 c() 함수
#숫자형은 시작값:끝값  과 seq(from, to, by) 가능

x <- c(1,2,3)
x
x <- 1:10
x
seq(1,10,2) #1~10까지 2 간격으로
seq(5,8)

seq_along(c('a','b','c','d')) #주어진 인자데이터 길이만큼 벡터로 변환
seq_len(5) #주어진 인자값까지 1,2,3... 벡터로 변환
rep(1:3,5) #1:3형식을 5번 반복

#names()함수로 이름 부여
x <-c(1,3,5)
names(x) <- c("kim","lee","park")
x

#인덱스 활용
x[1]
x[c(1:3)] #1~3까지의 모든 인덱스 값 추출

#음수 인덱스는 해당 요소 제외하고 추출
x[-3]

#벡터의 길이
length(x)
NROW(x) #대문자 사용, 행렬에서 사용하는 함수 (N행 1열로 취급)

#%in%
'c' %in% c('a','b','c') #true


# 2) 배열(Array)
#벡터와 행렬의 값을 나타낸다. dim 은 차원(행,렬)을 의미, dim또는 array 사용

array(1:6) #1차원
array(1:20, dim=c(4,5)) #2차원
array(1:20, dim=c(4,4,3)) #3차원 구조도 가능
array(1:6, c(2:3))

arr <- c(1:24)
dim(arr) <- c(3,4,2) #dim() 함수 이용하여 3행 4열의 행렬 2개 생성
arr