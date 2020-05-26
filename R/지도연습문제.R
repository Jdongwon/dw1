# [지도 연습문제]

# 1. R을 이용하여 서울시 한강 이남의 구청들의 위치에 
# 마커와 구청 이름을 지도 위에 표시하시오.
names <- c("강서구청", "양천구청", "구로구청", "영등포구청",
  "금천구청", "동작구청", "관악구청", "서초구청",
  "강남구청", "송파구청", "강동구청")
addr <- c("서울 강서구 화곡로 302", "서울 양천구 목동동로 105", "서울 구로구 가마산로 245", "서울 영등포구 당산로 123", "서울 금천구 시흥대로73길 70", "서울 동작구 장승배기로 161", "서울 관악구 관악로 145", "서울 서초구 남부순환로 2584", "서울 강남구 학동로 426", "서울특별시 송파구 올림픽로 326", "서울 강동구 성내로 25")
gc <- geocode(enc2utf8(addr))
df <- data.frame(name=names,
                 lon=gc$lon,
                 lat=gc$lat)
df

cen <- c(mean(df$lon), mean(df$lat)) # 지도의 중심점점
map <- get_googlemap(center=cen,
                     maptype = "roadmap",
                     zoom=10,
                     size=c(640,640),
                     markers = gc)
ggmap(map)

gmap <- ggmap(map)
gmap+geom_text(data=df,
               aes(x=lon, y=lat),
               size=5,
               label=df$name)

# 2. '2018년도 시국구별 월별 교통사고 자료'로부터 서울시의 각 구별 1년 
# 교통사고 발생건수를 지도상에 원의 크기로 나타내시오.
# - Sonar 원의 위치는 구의 위치로 하시오.
# - 원의 색은 red로 하고 투명도를 .05로 하시오.
# - 자료에는 월별로 데이터가 기록되어 있는데 
# 1년 데이터를 합산하여 이용하시오.
# - 서울 지역이 모두 지도에 나도오록 하시오.
# * 데이터출처: 공동데이터포털(https://www.data.go.kr)에서 
# '교통사고통계' 검색 후 
# '도로교통공단_시도_시군구별_교통사고_통계(2019)'를 다운받아 사용한다.

data <- read.csv("C:/장동원/R/도로교통공단_시도_시군구별_교통사고_통계(2018)/도로교통공단_시도_시군구별_월별_교통사고(2018).csv")
head(data)
data1 <- data[,c(1,2,4)]
head(data1)
data2 <- subset(data1, data1$시도 == "서울")
head(data2)
# data3 <- tapply(data2$발생건수, data2$시군구, sum)
# data3 <- data.frame(data3)
data3 <- aggregate(data2$발생건수, list(data2$시군구), sum)
head(data3)
data4 <- geocode(enc2utf8(data3$Group.1))


cen <- c(mean(data4$lon), mean(data4$lat))
gc <- data.frame(lon=data4$lon, lat=data4$lat)

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 11,
                     markers = gc)
ggmap(map)

gmap <- ggmap(map)
gmap+geom_point(data = data3,
                aes(x=gc$lon, y=gc$lat, size=x),
                alpha=0.5,
                col="red")+
  scale_size_continuous(range = c(1, 14))

# 3. 2번과 동일한 자료를 이용하여 광역시도별 1년 사망자수를 지도상에 원의 크기로 나타내시오.
# - 세종시는 데이터에서 삭제하시오.
# - 원의 색은 black으로 하고 투명도를 .05로 하시오.
# - 남한 지역이 모두 지도에 나오도록 하시오.
data1 <- data[,c(1,4)]
head(data1)
data2 <- aggregate(data1$발생건수, list(data1$시도), sum)
data3 <- subset(data2, data2$Group.1 != "세종")
head(data3)
data4 <- geocode(enc2utf8(data3$Group.1))
head(data4)

cen <- c(mean(data4$lon), mean(data4$lat))
gc <- data.frame(lon=data4$lon, lat=data4$lat)

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 7,
                     markers = gc)
ggmap(map)

gmap <- ggmap(map)
gmap+geom_point(data = data3,
                aes(x=gc$lon, y=gc$lat, size=x),
                alpha=0.5,
                col="black")+
  scale_size_continuous(range = c(1, 14))
# 4. 2.번과 동일한 자료를 이용하여 광역시도별 7, 8월 부상자수를 지도상에 원의 크기로 나타내시오.
# - 세종시는 데이터에서 삭제하시오.
# - 원의 색은 black으로 하고 투명도를 .05로 하시오.
# - 남한 지역이 모두 지도에 나오도록 하시오.
data1 <- data[,c(1,3,4)]
head(data1)
data2 <- subset(data1, data1$월 == "07월" | data1$월 == "08월") 
head(data2)
data3 <- aggregate(data1$발생건수, list(data1$시도), sum)
data4 <- subset(data3, data3$Group.1 != "세종")
head(data4)
data5 <- geocode(enc2utf8(data4$Group.1))
head(data5)

cen <- c(mean(data5$lon), mean(data5$lat))
gc <- data.frame(lon=data5$lon, lat=data5$lat)

map <- get_googlemap(center = cen,
                     maptype = "roadmap",
                     zoom = 7,
                     markers = gc)
ggmap(map)

gmap <- ggmap(map)
gmap+geom_point(data = data4,
                aes(x=gc$lon, y=gc$lat, size=x),
                alpha=0.5,
                col="black")+
  scale_size_continuous(range = c(1, 14))
