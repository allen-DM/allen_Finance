library(httr)
library(jsonlite)
url="https://mis.twse.com.tw/stock/data/mis_IDX.txt?_=1602430859230"

tmp=httr::GET(url)
heart_data_json=content(tmp,"text")
heart_data_list=fromJSON(heart_data_json,simplifyVector = T)

