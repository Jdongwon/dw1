# [군집화와분류 연습문제]

# 1. mlbench 패키지에서 제공하는 Sonar 데이터셋에 대해 k-평균 
# 군집화를 실시하고 결과를 그래프로 출력하세요.

library(mlbench)
data(Sonar)

data <- Sonar[,-61]
fit <- kmeans(x=data, center=3)
fit

library(cluster)
clusplot(data, fit$cluster, color=TRUE, shade=FALSE, labels = 2,lines=0)

#2. R에서 제공하는 rock 데이터셋에 대해 k-평균 군집화를 
# 실시하고 결과를 그래프로 출력하세요.
#  - 군집의 수는 3으로 한다.

head(rock)

fit <- kmeans(x=rock, center=3)
fit

library(cluster)
clusplot(rock, fit$cluster, color=TRUE, shade=FALSE, labels = 2,lines=0)


#3. mlbench 패키지에서 제공하는 BreastCancer 데이터셋에 대해
# k-최근접 이웃 알고리즘을 이용하여 모델을 만들고 예측 정확도를 측정하세요.

library(mlbench)
data("BreastCancer") 

#  BreastCancer 데이터셋에서 마지막에 있는 Class 열이 그룹 정보이다.
#  k-최근접 이웃에서 k는 5로 한다.


sum(is.na(BreastCancer))

mydata <- na.omit(BreastCancer)
nrow(mydata)

tr.idx <- c(1:50, 101:150, 201:250, 301:350, 401:450, 501:550, 601:641)# 훈련용 데이터의 인덱스
ds.tr <- mydata[tr.idx, -c(1,11)] # 훈련용 데이터 셋
ds.ts <- mydata[-tr.idx, -c(1,11)] # 데트스용 데이터 셋
cl.tr <- factor(mydata[tr.idx, 11]) # 훈련용 데이터 셋의 품종 정보
cl.ts <- factor(mydata[-tr.idx, 11]) # 테스트용 데이터 셋의 품종 정보


pred <- knn(ds.tr, ds.ts, cl.tr, k=5, prob=TRUE)

acc <- mean(pred == cl.ts)
acc

table(pred, cl.ts)

#  10-fold 교차 검증 방법으로 예측 정확도를 측정한다.

library(cvTools)

folds <- cvFolds(nrow(iris), K=10)

for(i in 1:k){
  ts.idx <- folds$which == i 
  ds.tr <- iris[-ts.idx, 1:4] 
  ds.ts <- iris[ts.idx, 1:4]
  cl.tr <- factor(iris[-ts.idx, 5]) 
  cl.ts <- factor(iris[ts.idx, 5])
  
  pred <- knn(ds.tr, ds.ts, cl.tr, k = 5)
  acc[i] <- mean(pred == cl.ts)}

acc
mean(acc)
