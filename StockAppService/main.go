package main

import (
	"stock-app-service/user_router"
	"github.com/gin-gonic/gin"
  )

func main() {
	router := gin.Default()
	router.POST("/login_stock_app", user_router.LoginStockApp)
	router.POST("/register_user", user_router.RegisterUser)
	router.POST("/delete_user", user_router.DeleteUser)
	router.GET("/get_user_info", user_router.GetUserInfo)
	router.Run()
}