package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
	"net/http"
)

type UserInfo struct {
	UserName  string `json:"username"`
	Password  string `json:"password"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

type UserInfoBody struct {
	UserName  string `json:"username"`
	Password  string `json:"password"`
}

func LoginStockApp(c *gin.Context) {
	var response UserInfo
	var request UserInfoBody

	db, err := db_config.InitDB()

	// Check DB connection
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Failed to connect to database",
		})
		return
	}

	// Check service request body
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{
			"error": "Invalid request body",
		})
		return
	}

	// Query data from DB
	row := db.QueryRow(
		"SELECT username, password, firstname, lastname FROM `user-info` LIMIT 1",
	)

	// Set data from DB to struct UserInfo
	if err := row.Scan(&response.UserName, &response.Password, &response.FirstName, &response.LastName); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{
			"error": "Failed to scan user data",
		})
		return
	}

	if request.UserName != response.UserName || request.Password != response.Password {
		c.JSON(http.StatusUnauthorized, gin.H{
			"error": "Username or Password is incorrect.",
		})
		return
	}


	c.JSON(http.StatusOK, response)
}