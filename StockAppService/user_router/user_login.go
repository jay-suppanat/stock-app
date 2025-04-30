package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
	"net/http"
	"crypto/rand"
	"encoding/hex"
)

// MARK: UserLoginResponse

type UserLoginResponse struct {
	TokenType string `json:"token_type"`
	Token     string `json:"access_token"`
	UserName  string `json:"username"`
	UserInfo  UserInfo `json:"user_info"`
}

type UserInfo struct {
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

// MARK: UserLoginQuery

type UserLoginQuery struct {
	UserName  string `json:"username"`
	Password  string `json:"password"`
	FirstName string `json:"first_name"`
	LastName  string `json:"last_name"`
}

// MARK: UserLoginBody

type UserLoginBody struct {
	UserName  string `json:"username"`
	Password  string `json:"password"`
}

// MARK: Service

func LoginStockApp(c *gin.Context) {
	var response UserLoginResponse
	var query UserLoginQuery
	var request UserLoginBody

	db, err := db_config.InitDB()

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ "error": "Failed to connect to database" })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ "error": "Invalid request body" })
		return
	}

	row := db.QueryRow(
		"SELECT username, password, firstname, lastname FROM `user-info` LIMIT 1",
	)

	if err := row.Scan(&query.UserName, &query.Password, &query.FirstName, &query.LastName); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ "error": "Failed to scan user data" })
		return
	}

	if request.UserName != query.UserName || request.Password != query.Password {
		c.JSON(http.StatusUnauthorized, gin.H{ "error": "Username or Password is incorrect." })
		return
	}

	token, _ := generateRandomToken(100)

	response = UserLoginResponse{
		TokenType: "Bearer",
		Token: token,
		UserName: query.UserName,
		UserInfo: UserInfo{
			FirstName: query.FirstName,
			LastName: query.LastName,
		},
	}


	c.JSON(http.StatusOK, response)
}

func generateRandomToken(length int) (string, error) {
	bytes := make([]byte, length)

	if _, err := rand.Read(bytes); err != nil {
		return "", err
	}

	return hex.EncodeToString(bytes), nil
}