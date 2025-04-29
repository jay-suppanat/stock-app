package db_config

import (
	"database/sql"
	"sync"
	"log"
	_ "github.com/go-sql-driver/mysql"
)

var (
	db   *sql.DB
	once sync.Once
	err  error
)

func InitDB() (*sql.DB, error) {
	once.Do(func() {
		connectionString := "root:mercideszz123@tcp(localhost:3306)/sys"
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