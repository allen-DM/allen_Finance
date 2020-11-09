addDao=function(){

  config <- config::get(file = "configs/config.yml")

  addStockCode=function(stockNmae,stockCode){
    tryCatch({
      con <-DBI::dbConnect(RMariaDB::MariaDB(),dbname=config$dbname,
                           host=config$host,
                           user = config$user,
                           password = config$password)
      addStockCodeSQL =paste0("INSERT INTO `financial`.`stockcode` (`stockName`, `stockCode`) VALUES ('",stockNmae,"','",stockCode,"');")
      rs <- dbSendQuery(con,addStockCodeSQL)
      #rs <-DBI::dbGetQuery(con,"show tables")
      #DBI::dbHasCompleted(rs)
      dbClearResult(rs)
      dbDisconnect(con) #關閉連結
      return("新增成功")
    },
    # 遇到 warning 時的自訂處理函數
    warning = function(msg) {
      message("addStockCode Original warning message:")
      message(paste0(msg,"\n"))
      return(NULL)
    },
    # 遇到 error 時的自訂處理函數
    error = function(msg) {
      message("addStockCode Original error message:")
      message(paste0(msg,"\n"))
      return(NA)
    }
    )
  }






  addDao=list(
    "addStockCode"=addStockCode
  )
  return(addDao)
}



