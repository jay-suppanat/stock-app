package user_router

import (
	"crypto/rand"
	"encoding/hex"
	"fmt"
	"net/http"
	"stock-app-service/config"
	"stock-app-service/support_file"

	"github.com/gin-gonic/gin"
)

// MARK: UserLoginResponse

type UserLoginResponse struct {
	Status bool `json:"status"`
	Message string `json:"message"`
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
	ID int `json:"id"`
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
		c.JSON(http.StatusInternalServerError, gin.H{ 
			support_file.Status: false,
			support_file.Message: support_file.AuthorizationFail,
		 })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ 
			support_file.Status: false,
			support_file.Message: support_file.InvalidRequestBody,
		 })
		return
	}

	row := db.QueryRow(
		"SELECT id, username, password, first_name, last_name FROM `user-info` LIMIT 1",
	)

	if err := row.Scan(&query.ID, &query.UserName, &query.Password, &query.FirstName, &query.LastName); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ 
			support_file.Status: false,
			support_file.Message: support_file.AuthorizationFail,
		 })
		return
	}

	if request.UserName != query.UserName || request.Password != query.Password {
		c.JSON(http.StatusUnauthorized, gin.H{ 
			support_file.Status: false,
			support_file.Message: support_file.IncorrectUsernameAndPassword,
		 })
		return
	}

	token, _ := generateRandomToken(100)

	fmt.Println(query.ID)

	result, err := db.Exec("UPDATE `user-info` SET `access_token` = ? WHERE `id` = ?", token, query.ID)
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusUnauthorized, gin.H{ 
			support_file.Status: false,
			support_file.Message: support_file.AuthorizationFail,
		})
		return
	}

	fmt.Println(result)

	response = UserLoginResponse{
		Message: support_file.Success,
		Status: true,
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