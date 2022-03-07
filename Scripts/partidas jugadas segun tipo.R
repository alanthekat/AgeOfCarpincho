library(tidyverse)
options(scipen=999)
library(dplyr)
require("httr")
require("jsonlite")
library(plotly)
library(htmlwidgets)

setwd(dir = "C:/Users/Tostado Admin/Documents/AgeOfCarpincho/assets/charts")
alan <- paste("https://aoe2.net/api/player/matches?game=aoe2de&steam_id=76561198153797281&count=1000")
alanhr <- GET(alan)
alanhr_text <- content(alanhr, "text")
alanhr_json <- fromJSON(alanhr_text, flatten = TRUE)
alandf <- as.data.frame(alanhr_json)
alandf <-cbind(alandf, player='alanthekat')

alan2 <- paste("https://aoe2.net/api/player/matches?game=aoe2de&steam_id=76561199207580572&count=1000")
alanhr2 <- GET(alan2)
alanhr_text2 <- content(alanhr2, "text")
alanhr_json2 <- fromJSON(alanhr_text2, flatten = TRUE)
alandf2 <- as.data.frame(alanhr_json2)
alandf2 <-cbind(alandf2, player='alanthekat')


dicopato <- paste("https://aoe2.net/api/player/matches?game=aoe2de&leaderboard_id=3&steam_id=76561198118459931&count=1000")
dicopatohr <- GET(dicopato)
dicopatohr_text <- content(dicopatohr, "text")
dicopatohr_json <- fromJSON(dicopatohr_text, flatten = TRUE)
dicodf <- as.data.frame(dicopatohr_json)
dicodf <-cbind(dicodf, player='dicopato')

dicopato2 <- paste("https://aoe2.net/api/player/matches?game=aoe2de&leaderboard_id=3&steam_id=76561199195740571&count=1000")
dicopatohr2 <- GET(dicopato2)
dicopatohr_text2 <- content(dicopatohr2, "text")
dicopatohr_json2 <- fromJSON(dicopatohr_text2, flatten = TRUE)
dicodf2 <- as.data.frame(dicopatohr_json2)
dicodf2 <-cbind(dicodf2, player='dicopato')


nanox <- paste("https://aoe2.net/api/player/matches?game=aoe2de&steam_id=76561198191637438&count=1000")
nanoxhr <- GET(nanox)
nanoxhr_text <- content(nanoxhr, "text")
nanoxhr_json <- fromJSON(nanoxhr_text, flatten = TRUE)
nanoxdf <- as.data.frame(nanoxhr_json)
nanoxdf <-cbind(nanoxdf, player='nanox')

nanox2 <- paste("https://aoe2.net/api/player/matches?game=aoe2de&leaderboard_id=3&start=1000&steam_id=76561198191637438&count=1000")
nanoxhr2 <- GET(nanox2)
nanoxhr_text2 <- content(nanoxhr2, "text")
nanoxhr_json2 <- fromJSON(nanoxhr_text2, flatten = TRUE)
nanoxdf2 <- as.data.frame(nanoxhr_json2)
nanoxdf2 <-cbind(nanoxdf2, player='nanox')

monillo <- paste("https://aoe2.net/api/player/matches?game=aoe2de&leaderboard_id=3&steam_id=76561198163778606&count=1000")
monillohr <- GET(monillo)
monillohr_text <- content(monillohr, "text")
monillohr_json <- fromJSON(monillohr_text, flatten = TRUE)
monillodf <- as.data.frame(monillohr_json)
monillodf <-cbind(monillodf, player='monillo')

monillo2 <-paste("https://aoe2.net/api/player/matches?game=aoe2de&leaderboard_id=3&start=1000&steam_id=76561198163778606&count=1000")
monillohr2 <- GET(monillo2)
monillohr_text2 <- content(monillohr2, "text")
monillohr_json2 <- fromJSON(monillohr_text2, flatten = TRUE)
monillodf2 <- as.data.frame(monillohr_json2)
monillodf2 <-cbind(monillodf2, player='monillo')

todos <- rbind (alandf, alandf2, dicodf, dicodf2, monillodf, nanoxdf, nanoxdf2, monillodf2)
todos2 <- select (todos, player, leaderboard_id)
todos2$leaderboard_id <- as.character(as.character(todos2$leaderboard_id))

todos2[is.na(todos2)] <- 444
todos2 <- mutate (todos2, type = case_when(todos2$leaderboard_id == "0" ~ "Unranked", 
                                           todos2$leaderboard_id == "1" ~ "Deathmatch 1v1",
                                           todos2$leaderboard_id == "2" ~ "TG Deathmatch",
                                           todos2$leaderboard_id == "3" ~ "Ranked 1v1",
                                           todos2$leaderboard_id == "4" ~ "Ranked TG",
                                           todos2$leaderboard_id == "444" ~ "Other"))

fig <- plot_ly(todos2, y = ~player, type = 'histogram', name = ~type, color = ~type)
fig <- fig %>% layout(barmode = 'stack', type = 'aggregate')
fig
saveWidget(fig, "partidas_tipo.html", selfcontained = F, libdir = "lib")


