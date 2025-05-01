package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
	"stock-app-service/support_file"
	"net/http"
	"fmt"
	"strings"
	"database/sql"
)

type RegisterResponse struct {
	Message string `json:"message"`
}

type RegisterRequest struct {
	Username string `json:"username"`
	Password string `json:"password"`
	ConfirmPassword string `json:"confirm_password"`
	FirstName string `json:"first_name"`
	LastName string `json:"last_name"`
	Email string `json:"email"`
	PhoneNumber string `json:"phone_number"`
}

type RegisterQuery struct {
	ID int `json:"id"`
}

func RegisterUser(c *gin.Context) {
	var response RegisterResponse
	var request RegisterRequest
	var existingUsername string

	db, err := db_config.InitDB()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.RegisterFail })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ support_file.Message: support_file.InvalidRequestBody })
		return
	}

	insert, err := db.Prepare("INSERT INTO `user-info` (username, password, first_name, last_name, email, phone_number, access_token) VALUES (?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.RegisterFail })
		return
	}
	defer insert.Close()

	err = db.QueryRow("SELECT username FROM `user-info` WHERE username = ?", request.Username).Scan(&existingUsername)
	if err != nil && err != sql.ErrNoRows {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.RegisterFail })
		return
	}

	if existingUsername != "" {
		c.JSON(http.StatusBadRequest, gin.H{ support_file.Message: support_file.UsernameExisting })
		return
	}

	if !strings.Contains(request.Email, "@") {
		c.JSON(http.StatusBadRequest, gin.H{ support_file.Message: support_file.IncorrectEmailFormat })
		return
	}

	result, err := insert.Exec(request.Username, request.Password, request.FirstName, request.LastName, request.Email, request.PhoneNumber, "")
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.RegisterFail })
		return
	}

	fmt.Println(result)

	response.Message = support_file.RegisterSuccess
	c.JSON(http.StatusOK, response)
}