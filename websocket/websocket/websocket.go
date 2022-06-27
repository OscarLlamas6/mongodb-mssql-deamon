package websocket

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"os"
	"time"
	"websocket/configs"

	"github.com/gorilla/websocket"
	"github.com/joho/godotenv"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
}

func Upgrade(w http.ResponseWriter, r *http.Request) (*websocket.Conn, error) {
	upgrader.CheckOrigin = func(r *http.Request) bool {
		return true
	}

	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		fmt.Println(err)
		return ws, err
	}

	return ws, nil
}

func Writer(conn *websocket.Conn) {

	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	mongoNAME := os.Getenv("MONGODB_NAME")
	mongoCOLL := os.Getenv("MONGODB_COLL")

	for {
		ticker := time.NewTicker(6 * time.Second)

		for t := range ticker.C {
			fmt.Printf("Netflix records: #%v\n", t)
			ctx, cancel := context.WithTimeout(context.Background(), 30*time.Second)
			defer cancel()

			// Obtenemos la coleccion en MongoDB
			var netflixCollection *mongo.Collection = configs.GetCollection(configs.DB, mongoNAME, mongoCOLL)

			// Hacemos un query FindAll para obtener los registros
			myCursor, err := netflixCollection.Find(ctx, bson.M{})
			if err != nil {
				fmt.Println(err)
			}

			// Arreglo para almacenar los resultados
			var myStudents []bson.M

			if err = myCursor.All(ctx, &myStudents); err != nil {
				fmt.Println(err)
			}

			// Convertimos el arreglo a formato json
			resultJson, err := json.Marshal(myStudents)
			if err != nil {
				fmt.Println(err)
			}

			// Enviamos el resultado
			err = conn.WriteMessage(websocket.TextMessage, []byte(resultJson))
			if err != nil {
				fmt.Println(err)
				return
			}

			//fmt.Println(myStudents)

		}
	}
}
