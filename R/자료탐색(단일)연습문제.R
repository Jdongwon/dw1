
# * R에서 제공하는 mtcars 데이터섹에 대해 다음 문제를 해결하기 위한 R코드를 작성하시오.

mtcars

# 1) 중량(wt)의 평균값, 중앙값, 절사평균값(절사범위: 15%), 표준편차를 각각 구하시오.
wt <- mtcars[,6]
wt

mean(wt)
median(wt)
mean(wt, trim = 0.15)
sd(wt)
# 2) 중량(wt)에 대해 summary() 함수의 적용 결과를 출력하시오.
summary(wt)
# 3) 실린더수(cyl)에 대해 summary()함수의 적용 결과를 출력하시오.
cyl <- mtcars[,2]
cyl
cyl2 <- summary(cyl)
# 4) 앞에서 구한 도수분포표를 막대그래프로 출력하시오.
barplot(c(cyl2), main = 'cyl summary')
# 5) 중량(wt)의 히스토그램을 출력하시오.
hist(wt)
hist(wt, #data(자료)
     main = "wt", # 제목
     xlab = "wt", # x축 레이블
     ylab = "빈도수", # Y축 레이블
     border = "blue", # 막대의 데투리 색깔
     col = "green", # 막대 색깔
     las = 2, # x축 글씨 방향(0 ~ 3)
     breaks = 5) # 막대 개수 조절절
# 6) 중량(wt)에 대한 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는 정보를 함께 출력하시오.)
boxplot(wt)
boxplot.stats(wt)
summary(wt)
# 7) 배기량(disp)에 대한 상자그림을 출력하시오.(단, 상자그림으로부터 관찰할 수 있는 정보를 함께 출력하시오.)
disp <- mtcars[,3]
disp
boxplot(disp)
boxplot.stats(disp)
# 8) 기어수(gear)를 그룹 정보로 하여 연비(mpg)자료에 대해 상자그림을 작성하고, 각 그룹의 상자그림을 비교하여 관찰할 수 있는 것이 무엇인지 나타내시오
boxplot(mpg~gear, data=mtcars, main="기어수별 연비자료")
boxplot.stats(mtcars$mpg)

              