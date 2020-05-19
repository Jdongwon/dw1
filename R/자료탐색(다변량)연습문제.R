# [자료탐색(다변량)연습문제]

# 1. R에서 제공하는 cars데이터셋을 이용하여 속도(speed)와 제동거리(dist)에 대한 산점도을 작성하고, 두 변수 간의 상관관계를 설명하시오.
# (x축:speed, y축:dist)
cars
plot(dist~speed, data=cars,
     main = "Speed(속도)-Dist(제동거리)",
     xlab = "Speed",
     ylab = "Dist",
     col = "red",
     pch = 19)
cor(cars)

# 2. R에서 제공하는 pressure 데이터셋을 이용하여 온도(temperature)와 기압(pressure)에 대한 산점도를 작성하고, 두 변수간의 상관 관계를 설명하시오.(x축:temperature, y축:pressure)
pressure
plot(pressure~temperature, data=pressure,
     main = "temperaure(온도)-pressure(기압)",
     xlab = "temperature",
     ylab = "pressure",
     col = "red",
     pch = 19)
cor(pressure)


# 3. R에서 제공하는 trees 데이터셋에 대해 다음 문제를 해결하기 위한 R코드를 작성하시오.
trees

# 1) 나무의 지름(Girth)과 높이(Height)에 대해 산점도와 상관계수를 보이시오.
plot(Height~Girth, data=trees,
     main = "Girth(지름)-Height(높이)",
     xlab = "Girth",
     ylab = "Height",
     col = "red",
     pch = 19)
cor(trees$Girth, trees$Height)

# 2) trees 데이터셋에 존재하는 3개 변수 간의 산점도와 상관계수를 보이시오.
pairs(trees)
cor(trees)

# 4. R에서 제공하는 AirPassengers 데이터셋은 1949년~1960년 사이의 항공승객수를 월별로 나타낸 것이다.
# AirPassengers 데이터셋에서 1949, 1955, 1960년의 월별 승객수를 선그래프로 작성하는데, 3개년도의 선의 색을 다르게 하시오.
# (현재는 AirPassengers 데이터셋에서 직접 데이터를 추출할 수 없으니 AirPassengers 데이터셋을 보고 필요한 자료를 입력하여 사용한다.)
AirPassengers
AP <- matrix(c(112, 118, 132, 129, 121, 135, 148, 148, 136, 119, 104, 118,
       242, 233, 267, 269, 270, 315, 364, 347, 312, 274, 237, 278,
       417, 391, 419, 461, 472, 535, 622, 606, 508, 461, 390, 432),
       nrow = 12, ncol = 3)
rownames(AP) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
colnames(AP) <- c(1949, 1955, 1960)
AP <- data.frame(AP)

month <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
X1949 <- c(112, 118, 132, 129, 121, 135, 148, 148, 136, 119, 104, 118)
x1955 <- c(242, 233, 267, 269, 270, 315, 364, 347, 312, 274, 237, 278)
x1960 <- c(417, 391, 419, 461, 472, 535, 622, 606, 508, 461, 390, 432)

plot(X1949,
     main = "AirPassengers",
     type = "b",
     col = "red",
     xlab = "Month",
     ylab = "Count",
     ylim = c(0, 800))

lines(x1955, type = "b", col = "blue")
lines(x1960, type = "b", col = "green")

# 5. R에서 제공하는 USAccDeaths 데이터셋은 1973년~1978년 사이의 사고 사망자 숫자를 월별로 나타낸 것이다.
# USAccDeaths 데이터셋에서 1973, 1975, 1977년의 월별 사망자 숫자를 선그래프로 작성하는데,
# 3개년도의 선의 색을 다르게 하시오.

X1973 <- c(9007,  8106,  8928,  9137, 10017, 10826, 11317, 10744,  9713,  9938,  9161,  8927)
X1975 <- c(8162,  7306,  8124,  7870,  9387,  9556, 10093,  9620,  8285,  8466,  8160,  8034)
X1977 <- c(7792,  6957,  7726,  8106,  8890,  9299, 10625,  9302,  8314,  8850,  8265,  8796)
plot(X1973,
     main = "USAccDeaths",
     type = "b",
     col = "red",
     xlab = "Month",
     ylab = "Deaths",
     ylim = c(0, 12000))

lines(X1975, type = "b", col = "blue")
lines(X1977, type = "b", col = "green")
