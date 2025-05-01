package user_router

import (
	"net/http"
	"stock-app-service/config"
	"stock-app-service/support_file"
	"strconv"
	"strings"
	"github.com/gin-gonic/gin"
)

type GetUserInfoResponse struct {
	UserName  string `json:"username"`
	UserInfo  GetUserInfoItem `json:"user_info"`
}

type GetUserInfoItem struct {
	FirstName string `json:"first_name"`
	LastName string `json:"last_name"`
	Email string `json:"email_name"`
	PhoneNumber string `json:"phone_number"`
}

func GetUserInfo(c* gin.Context) {
	var response GetUserInfoResponse
	var responseItem GetUserInfoItem
	var storedToken string

	db, err := db_config.InitDB()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.InternalError })
		return
	}

	userID, _ := strconv.Atoi(c.GetHeader("id"))
	accessToken := c.GetHeader("access_token")

	if strings.Contains(accessToken, support_file.Bearer) {
		accessToken = strings.TrimPrefix(accessToken, support_file.Bearer)
	}

	if accessToken == "" {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.NotMatchToken })
		return
	} else if userID <= 0 {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.InternalError })
		return
	}

	err = db.QueryRow("SELECT access_token FROM `user-info` WHERE id = ?", userID).Scan(&storedToken)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: "asdsdasd" })
		return
	}

	row := db.QueryRow("SELECT username, first_name, last_name, email, phone_number FROM `user-info` WHERE id = ?", userID)
	err = row.Scan(
		&response.UserName,
		&responseItem.FirstName,
		&responseItem.LastName,
		&responseItem.Email,
		&responseItem.PhoneNumber,
	)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.InternalError })
		return
	}

	if storedToken != accessToken {
		c.JSON(http.StatusUnauthorized, gin.H{ support_file.Message: support_file.NotMatchToken })
		return
	}

	response.UserInfo = responseItem
	c.JSON(http.StatusOK, response)
}