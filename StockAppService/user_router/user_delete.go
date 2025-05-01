package user_router

import (
	"github.com/gin-gonic/gin"
	"stock-app-service/config"
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
		c.JSON(http.StatusInternalServerError, gin.H{ "error": "Failed to connect to database." })
		return
	}

	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{ "error": "Invalid request body." })
		return
	}

	_, err = db.Exec("DELETE FROM `sys`.`user-info` WHERE `username` = ?", request.Username)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{ "message": "Fail to delete user." })
	}

	response.Message = "Delete user success."
	response.Status = true
	c.JSON(http.StatusOK, response)
}