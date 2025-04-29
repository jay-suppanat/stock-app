package main

import (
	"stock-app-service/user_router"
	"github.com/gin-gonic/gin"
  )

func main() {
	router := gin.Default()
	router.POST("/login_stock_app", user_router.LoginStockApp)
	router.Run()
}