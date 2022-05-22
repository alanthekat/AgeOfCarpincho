library(tidyverse)
require("httr")
require("jsonlite")
require("anytime")
require("plotly")
library(plotly)
library(htmlwidgets)

setwd(dir = "C:/Users/Alan/Documents/GitHub/AgeOfCarpincho/assets/charts")
alan <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561199207580572&count=1000")
alanhr <- GET(alan)
alanhr_text <- content(alanhr, "text")
alanhr_json <- fromJSON(alanhr_text, flatten = TRUE)
alandf <- as.data.frame(alanhr_json)
alandf <-cbind(alandf, player='alanthekat')

dicopato <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561199195740571&count=1000")
dicopatohr <- GET(dicopato)
dicopatohr_text <- content(dicopatohr, "text")
dicopatohr_json <- fromJSON(dicopatohr_text, flatten = TRUE)
dicodf <- as.data.frame(dicopatohr_json)
dicodf <-cbind(dicodf, player='dicopato')

nano <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561198191637438&count=1000")
nanohr <- GET(nano)
nanohr_text <- content(nanohr, "text")
nanohr_json <- fromJSON(nanohr_text, flatten = TRUE)
nanodf <- as.data.frame(nanohr_json)
nanodf <-cbind(nanodf, player='Nanox')

mono <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561198163778606&count=1000")
monohr <- GET(mono)
monohr_text <- content(monohr, "text")
monohr_json <- fromJSON(monohr_text, flatten = TRUE)
monodf <- as.data.frame(monohr_json)
monodf <-cbind(monodf, player='Monillo')

kato <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561198153797281&count=1000")
katohr <- GET(kato)
katohr_text <- content(katohr, "text")
katohr_json <- fromJSON(katohr_text, flatten = TRUE)
katodf <- as.data.frame(katohr_json)
katodf <-cbind(katodf, player='alanthekat')

parkopato <- paste("https://aoe2.net/api/player/ratinghistory?game=aoe2de&leaderboard_id=4&steam_id=76561198118459931&count=1000")
parkopatohr <- GET(parkopato)
parkopatohr_text <- content(parkopatohr, "text")
parkopatohr_json <- fromJSON(parkopatohr_text, flatten = TRUE)
parkodf <- as.data.frame(parkopatohr_json)
parkodf <-cbind(parkodf, player='dicopato')

todos <- rbind (alandf, dicodf, nanodf, monodf, parkodf, katodf)
todos <- mutate(todos, Date = anydate(timestamp))
todos <- select(todos, !timestamp)
todos <- arrange(todos, Date)

fig <- plot_ly(data = todos, x = ~Date, y = ~rating, color = ~player, mode = 'lines+markers')
widget_file_size <- function(fig) {
  d <- tempdir()
  withr::with_dir(d, htmlwidgets::saveWidget(fig, "index.html"))
  f <- file.path(d, "index.html")
  mb <- round(file.info(f)$size / 1e6, 3)
  message("File is: ", mb," MB")
 }
fig
saveWidget(fig, "Elo_Chart.html", selfcontained = F, libdir = "lib")


figQty <- plot_ly(todos, y = ~player, type = 'histogram')

figQty
saveWidget(figQty, "partidas_tipo.html", selfcontained = F, libdir = "lib")
