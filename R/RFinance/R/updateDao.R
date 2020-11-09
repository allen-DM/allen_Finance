
updateDao = function() {
  config <- config::get(file = "configs/config.yml")

  updateStockinfo_day=function(stockcode){
    tryCatch({
      con <-DBI::dbConnect(RMariaDB::MariaDB(),
                           dbname=config$dbname,
                           host=config$host,
                           user = config$user,
                           password = config$password)


      updateStockinfo_SQL1 <- paste0("INSERT INTO `financial`.`stockprice_day` (`stockCode`,`date`,`open`,`high`,`low`,`close`,`volum`,`adjusted`) VALUES")
      updateStockinfo_SQL2 <- paste(sprintf("('%s','%s', %s, %s, %s, %s, %s, %s)",
                                      stockcode$stockCode,
                                      stockcode$date,
                                      stockcode$open,
                                      stockcode$high,
                                      stockcode$low,
                                      stockcode$close,
                                      stockcode$volum,
                                      stockcode$adjusted), collapse=', ')

      updateStockinfo_SQL3 <-paste0('on duplicate key update open = values(open),',
                                    "high = values(high),",
                                    "low = values(low),",
                                    "close = values(close),",
                                    "volum = values(volum),",
                                    "adjusted = values(adjusted)")
      updateStockinfo_SQL <- paste(updateStockinfo_SQL1,updateStockinfo_SQL2,updateStockinfo_SQL3,sep = ' ')

      rs <- dbSendQuery(con,updateStockinfo_SQL)
      dbClearResult(rs)
      dbDisconnect(con) #關閉連結
      return("成功新增每日資料")
    },
    # 遇到 warning 時的自訂處理函數
    warning = function(msg) {
      message("updateStockinfo_day Original warning message:")
      message(paste0(msg,"\n"))
      return(NULL)
    },
    # 遇到 error 時的自訂處理函數
    error = function(msg) {
      message("updateStockinfo_day Original error message:")
      message(paste0(msg,"\n"))
      return(NA)
    }
    )
  }
  updateDao=list(
    "updateStockinfo_day"=updateStockinfo_day
  )
  return(updateDao)
  }
