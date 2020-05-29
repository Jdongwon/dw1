
## k-평균 군집화(k-means)
# 군집의 중심점을 찾고, 다른 점들은 거리가 가장 가까운 중심점의
# 군집에 속하는 것으로 결정하는 것.

mydata <- iris[, 1:4] # 데이터 준비비
head(mydata)

fit <- kmeans(x=mydata, center=3) # kmeans() 함수를 이용하여 군집화 실행하고 fit에 저장

fit
# K-means clustering with 3 clusters of sizes 38, 62, 50
# 3개의 군집에 속한 데이터의 개수
# Clustering means: 3개의 군집의 중심 좌표값
# Clustering vector: 각 데이터에 대한 군집번호

fit$cluster # 각 데이터에 대한 군집 번호호
fit$centers # 각 군집의 중심점에 대한 좌표

library(cluster)
clusplot(mydata, fit$cluster, 
         color=TRUE, # 군집 원의 색깔을 군집별로 다르게 
         shade=TRUE, # 군집 원안에 음영(빗금) 표시
         labels=2,   # 군집화 대상 데이터셋에서 개별 관측값을 그래프상에 어떻게 나타낼지 지정, 1: 관측값을 동그라미, 세모, 더하기 같은 기호로 표시
         lines=0)    # 군집의 중심점과 중심점을 연결하는 선을 표시할지 여부, (0 : 표시X , 1 : 표시O)

# 데이터에서 3번째 군집의 데이터만 추출
subset(mydata, fit$cluster==3)

# 대상 데이터 표준화 후 군집화
# 표준화 함수
std <- function(x){
  return((x-min(x)) / (max(x)-min(x)))
}

mydata <- apply(iris[,-5], 2, std) # data, 1=행 2=열
head(mydata)

# 군집화
fit <- kmeans(x=mydata, center=3)
fit

clusplot(mydata, fit$cluster, 
         color=TRUE, 
         shade=TRUE, 
         labels=2,   
         lines=0) 

## 분류
# knn, k-fold

# knn
library(class) #knn()불러오기

# 훈련용 데이터와 테스트용 데이터 준비
tr.idx <- c(1:25, 51:75, 101:125)# 훈련용 데이터의 인덱스
ds.tr <- iris[tr.idx, 1:4] # 훈련용 데이터 셋
ds.ts <- iris[-tr.idx, 1:4] # 데트스용 데이터 셋
cl.tr <- factor(iris[tr.idx, 5]) # 훈련용 데이터 셋의 품종 정보
cl.ts <- factor(iris[-tr.idx, 5]) # 테스트용 데이터 셋의 품종 정보

pred <- knn(ds.tr, ds.ts, cl.tr, k=3, prob=TRUE)
# k=3 : 최근접 이웃의 개수
# prob=TRUE : 예측된 그룹에 대한 지지 확률을 표시할지 여부
pred

acc <- mean(pred == cl.ts)
acc

table(pred, cl.ts)


# k-fold 교차검증(cross validation)
library(cvTools) # cvFolds() 함수 지원

k <- 10
folds <- cvFolds(nrow(iris), K=k) # 폴드 생성

for(i in 1:k){
  ts.idx <- folds$which == i # 테스트용 데이터의 인덱스
  ds.tr <- iris[-ts.idx, 1:4] # 훈련용 데이터의 인덱스
  ds.ts <- iris[ts.idx, 1:4]  # 데스트용 데이터의 인덱스
  cl.tr <- factor(iris[-ts.idx, 5])   # 훈련용 데이터 셋
  cl.ts <- factor(iris[ts.idx, 5])    # 데스트용 데이터 셋
  
  pred <- knn(ds.tr, ds.ts, cl.tr, k = 5)
  acc[i] <- mean(pred == cl.ts)
}
acc
mean(acc)
