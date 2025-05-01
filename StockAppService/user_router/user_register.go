package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
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
		c.JSON(http.StatusInternalServerError, gin.H{ "message": "Failed to connect to database" })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ "message": "Invalid request body" })
		return
	}

	insert, err := db.Prepare("INSERT INTO `user-info` (username, password, firstname, lastname, email, phone_number, access_token) VALUES (?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ "message": "Failed to prepare insert statement" })
		return
	}
	defer insert.Close()

	err = db.QueryRow("SELECT username FROM `user-info` WHERE username = ?", request.Username).Scan(&existingUsername)
	if err != nil && err != sql.ErrNoRows {
		c.JSON(http.StatusInternalServerError, gin.H{ "message": "Register Fail." })
		return
	}

	if existingUsername != "" {
		c.JSON(http.StatusBadRequest, gin.H{ "message": "Username is existing." })
		return
	}

	if !strings.Contains(request.Email, "@") {
		c.JSON(http.StatusBadRequest, gin.H{ "message": "Email is wrong format." })
		return
	}

	result, err := insert.Exec(request.Username, request.Password, request.FirstName, request.LastName, request.Email, request.PhoneNumber, "")
	if err != nil {
		fmt.Println(err)
		c.JSON(http.StatusInternalServerError, gin.H{ "message": "Register Fail." })
		return
	}

	fmt.Println(result)

	response.Message = "Register Success."
	c.JSON(http.StatusOK, response)
}