updateService <- function() {

  updateStockinfo_day=function(stockcode){
    tryCatch({
      tmp_stock=getSymbols(paste0(stockcode), auto.assign = FALSE)
      tmp_stock=as.data.frame(tmp_stock)
      tmp_stock=cbind(rownames(tmp_stock),tmp_stock)
      colnames( tmp_stock ) = c("date","open","high","low","close","volum","adjusted")
      stockCode=paste0(stockcode)
      tmp_stock=cbind(stockCode,tmp_stock)


      return("新增成功")
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


}


RFinance::updateDao()
