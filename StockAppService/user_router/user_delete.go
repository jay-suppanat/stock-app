package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
	"stock-app-service/support_file"
	"net/http"
)

type UserDeleteResponse struct {
	Message string `json:"message"`
	Status bool `json:"status"`
}

type UserDeleteRequest struct {
	Username string `json:"username"`
}

func DeleteUser(c *gin.Context) {
	var response UserDeleteResponse
	var request UserDeleteRequest

	db, err := db_config.InitDB()

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.DeleteUserFail })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ support_file.Message: support_file.InvalidRequestBody })
		return
	}

	_, err = db.Exec("DELETE FROM `sys`.`user-info` WHERE `username` = ?", request.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ support_file.Message: support_file.DeleteUserFail })
	}

	response.Message = support_file.DeleteUserSuccess
	response.Status = true
	c.JSON(http.StatusOK, response)
}