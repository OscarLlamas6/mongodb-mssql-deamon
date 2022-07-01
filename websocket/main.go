// First Go program
package main

import (
	"fmt"
	"log"
	"net/http"
	"websocket/configs"
	"websocket/websocket"

	"github.com/gorilla/mux"
)

func SetupResponse(next http.HandlerFunc) http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		w.Header().Set("Access-Control-Allow-Origin", "*")
		w.Header().Set("Access-Control-ALlow-Methods", "POST, GET, OPTIONS, PUT, DELETE")
		w.Header().Set("Access-Control-Allow-Header", "Accept, Content-Type, Content-Length, Accept-Encoding, X-CSRF-Token, Authorization")
		next(w, r)
	}
}

func RunSocket(w http.ResponseWriter, r *http.Request) {
	fmt.Println("Starting Go-Socket... :D")
	ws, err := websocket.Upgrade(w, r)
	if err != nil {
		fmt.Println(err)
	}
	go websocket.Writer(ws)
}

// Main function
func main() {
	configs.ConnectDB()
	fmt.Println("!... Mongo connected :D ...!")

	router := mux.NewRouter()

	// IMPORTANT: you must specify an OPTIONS method matcher for the middleware to set CORS headers
	router.HandleFunc("/socket", SetupResponse(RunSocket)).Methods(http.MethodGet, http.MethodOptions)
	router.Use(mux.CORSMethodMiddleware(router))
	fmt.Println("!... Starting server on port 8080 ...!")
	log.Fatal(http.ListenAndServe(":9001", router))
}
