package db_config

import (
	"database/sql"
	"sync"
	"log"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	"stock-app-service/support_file"
)

var (
	db   *sql.DB
	once sync.Once
	err  error
)

func InitDB() (*sql.DB, error) {
	once.Do(func() {
		connectionString := fmt.Sprintf("root:%s@tcp(localhost:3306)/sys", support_file.DBPassword)   
		db, err = sql.Open("mysql", connectionString)

		if err != nil {
			log.Printf("Error opening DB: %v", err)
			return
		}

		if pingErr := db.Ping(); pingErr != nil {
			log.Printf("Error connecting to DB: %v", pingErr)
			err = pingErr
		}
	})
	
	return db, err
}