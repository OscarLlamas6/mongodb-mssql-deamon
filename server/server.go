package main

import (
	"context"
	"fmt" // Imprimir en consola

	// Ayuda a escribir en la respuesta
	"log" //Loguear si algo sale mal
	// El paquete HTTP
	"database/sql"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
	"github.com/go-playground/validator/v10"
	"github.com/joho/godotenv"
	_ "github.com/microsoft/go-mssqldb"
)

type Database struct {
	SqlDb *sql.DB
}

var dbContext = context.Background()

var validate = validator.New()

type Response struct {
	Status  int                    `json:"status"`
	Message string                 `json:"message"`
	Data    map[string]interface{} `json:"data"`
}

type Movie struct {
	PrimaryName  string `json:"primaryName,omitempty" validate:"required"`
	OriginalName string `json:"originalName,omitempty" validate:"required"`
	IsAdult      *bool  `json:"isAdult,omitempty" validate:"required"`
	StartYear    int64  `json:"startYear,omitempty" validate:"required"`
	EndYear      int64  `json:"endYear,omitempty" validate:"required"`
	Runtime      int64  `json:"runtime,omitempty" validate:"required"`
}

func variables() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}
}

func CORSMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {

		c.Header("Access-Control-Allow-Origin", "*")
		c.Header("Access-Control-Allow-Credentials", "true")
		c.Header("Access-Control-Allow-Headers", "Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization, accept, origin, Cache-Control, X-Requested-With")
		c.Header("Access-Control-Allow-Methods", "POST, HEAD, PATCH, OPTIONS, GET, PUT")

		if c.Request.Method == "OPTIONS" {
			c.AbortWithStatus(204)
			return
		}

		c.Next()
	}
}

func CreateMovie(c *gin.Context) {

	server := os.Getenv("server")
	port := os.Getenv("port_database")
	user := os.Getenv("user")
	password := os.Getenv("password")
	database := os.Getenv("database")

	connString := fmt.Sprintf("server=%s;user id=%s;password=%s;port=%s;database=%s;",
		server, user, password, port, database)

	var err error
	var db Database
	// Create connection pool
	db.SqlDb, err = sql.Open("sqlserver", connString)
	if err != nil {
		log.Fatal("Error creating connection pool: ", err.Error())
	}
	ctx := context.Background()
	err = db.SqlDb.PingContext(ctx)
	if err != nil {
		log.Fatal(err.Error())
	}
	fmt.Printf("Connected!\n")

	var movie Movie

	//validate the request body
	if err := c.BindJSON(&movie); err != nil {
		defer db.SqlDb.Close()
		c.JSON(http.StatusBadRequest, Response{Status: http.StatusBadRequest, Message: "error", Data: map[string]interface{}{"data": err.Error()}})
		return
	}

	//use the validator library to validate required fields
	if validationErr := validate.Struct(&movie); validationErr != nil {
		defer db.SqlDb.Close()
		c.JSON(http.StatusBadRequest, Response{Status: http.StatusBadRequest, Message: "error", Data: map[string]interface{}{"data": validationErr.Error()}})
		return
	}

	// Check if database is alive.
	err = db.SqlDb.PingContext(ctx)
	if err != nil {
		c.JSON(http.StatusBadRequest, Response{Status: http.StatusBadRequest, Message: "error", Data: map[string]interface{}{"data": err.Error()}})
		return
	}

	tsql := `
      EXEC insertData @primaryName, @originalName, @isAdult, @startYear, @endYear, @runtime
    `

	stmt, err := db.SqlDb.Prepare(tsql)
	if err != nil {
		c.JSON(http.StatusBadRequest, Response{Status: http.StatusBadRequest, Message: "error", Data: map[string]interface{}{"data": err.Error()}})
		return
	}
	defer stmt.Close()

	row := stmt.QueryRowContext(
		ctx,
		sql.Named("primaryName", movie.PrimaryName),
		sql.Named("originalName", movie.OriginalName),
		sql.Named("isAdult", movie.IsAdult),
		sql.Named("startYear", movie.StartYear),
		sql.Named("endYear", movie.EndYear),
		sql.Named("runtime", movie.Runtime),
	)

	defer db.SqlDb.Close()
	c.JSON(http.StatusCreated, Response{Status: http.StatusCreated, Message: "success", Data: map[string]interface{}{"resultado": "Se ha ejecutado el SP satisfactoriamente", "id": row}})

}

func main() {

	variables()

	port := os.Getenv("PORT")
	direccion := fmt.Sprintf(`:%v`, port)

	// Se crea el servidor con GIN
	r := gin.Default()
	r.Use(CORSMiddleware())

	// Se aplican middlewares
	r.Use(gin.Logger())
	r.Use(gin.Recovery())

	//Rutas
	r.POST("/executeMovie", CreateMovie)

	//Se inicia el servidor en el puerto 9000
	r.Run(direccion)

}
