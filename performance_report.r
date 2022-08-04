setwd("C:/Users/Alexander.Persidskiy/Desktop/DF/performance")

library(readxl)

df_bananas <- read_excel("bananas_2107-0108.xlsx", 
                                col_types = c("skip", "date", "text", 
                                              "numeric", "text", "text", "numeric", 
                                              "date", "date", "text", "text", "numeric"), 
                                skip = 1)
df_bananas$РЦ <- "ФРОВ"

df_drunk <- read_excel("drunk_2107-0108.xlsx", 
                         col_types = c("skip", "date", "text", 
                                       "numeric", "text", "text", "numeric", 
                                       "date", "date", "text", "text", "numeric"), 
                         skip = 1)

df_drunk$РЦ <- "Софьино"


df_dry <- read_excel("dry_2107-0108.xlsx", 
                         col_types = c("skip", "date", "text", 
                                       "numeric", "text", "text", "numeric", 
                                       "date", "date", "text", "text", "numeric"), 
                         skip = 1)

df_dry$РЦ <- "Софьино"

df_frov <- read_excel("FROV_2107-0108.xlsx", 
                         col_types = c("skip", "date", "text", 
                                       "numeric", "text", "text", "numeric", 
                                       "date", "date", "text", "text", "numeric"), 
                         skip = 1)


df_frov$РЦ <- "ФРОВ"

df_kk <- read_excel("FROV_KK_2107-0108.xlsx", 
                                col_types = c("date", "text", "text", 
                                              "numeric", "text", "numeric", "text", 
                                              "numeric", "numeric", "numeric", 
                                              "numeric", "numeric"), skip = 2)
df_kk$РЦ <- "ФРОВ"

library(tidyverse)
library(plyr)
df_all <- rbind.fill(df_bananas, df_drunk, df_dry, df_frov)

df_hours <- read_excel("hours2107-0108.xlsx", 
                       skip = 4)

df_hours$`Начало периода` <- as.Date.character(df_hours$`Начало периода`, '%d/%m/%Y')

rm(df_bananas, df_drunk, df_dry, df_frov)



code_oper <- read_excel("code_oper.xlsx")

df_all <- left_join(df_all, code_oper[,c(1,3)], by = c("CODE" = "CODE"))

# Вот тут у нас не решаемая проблема с преобразованием chr в дату

df_all$`BEGIN DATE` <-format(as.POSIXct(df_all$`BEGIN DATE`,format='%m/%d/%Y %H:%M:%S'),format='%d/%m/%Y')

# N - аутстафф, y - собственный

#a <- unique(df_all$IS_STAFF)

# Алгоритм - удаляем из юзер ки br*, dt*, st*, ns* + удаляем у кого юзернейм НА

#df_all2 <- subset(df_all, df_all[is.na(df_all$USR_NAME),]) # удаляем лишнее

df_pivot <- aggregate(cbind(`QTY`) ~ `Должность`+ `BEGIN DATE` + `РЦ`, df_all, sum)

# Что нужно сделать:
#   
#   В датафрейме с часами что-то придумать с датой
#   Убрать юзер ки
#   Трансформировать табель ак через tydir
    # Далее делаем пивот видимо через суммарайзе (агрегейт не подходит)


# И дальше смотрим
