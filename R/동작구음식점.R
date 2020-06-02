setwd("C:/장동원/R")

library(readxl)
data <- readxl::read_excel(path = "서울상권.xlsx",
                   sheet = "Sheet4",
                   col_names = TRUE)
head(data)
df <- subset(data, data$시군구명 == "동작구")
df <- df[,c("상호명", "상권업종대분류명", "경도", "위도")]

sum(is.na(df))

register_google(key='AIzaSyCTjnIejF7fPHYfBK8jOxBwShRr-XRL5R8')
cen <- c(mean(df$경도),mean(df$위도))
map <- get_googlemap(center=cen,
                    maptype="roadmap",
                     size=c(640,640),
                     zoom=13)
gmap <- ggmap(map)  



ds.dongjak <- subset(df, df$상권업종대분류명== 
                        "음식")

gmap+geom_point(data = ds.dongjak, 
                aes(x=경도,y=위도), size=2, alpha=0.5, col="red") +
  labs(x = "Longitude", y = "Latitude",
       title="동작구 음식점" )
