package main

import (
	"fmt"
	"log"
	"net/http"

	"github.com/gorilla/websocket"
)

var upgrader = websocket.Upgrader{
	ReadBufferSize:  1024,
	WriteBufferSize: 1024,
}

var clients = make(map[*websocket.Conn]bool) // Map to store connected clients

func wsEndpoint(w http.ResponseWriter, r *http.Request) {
	upgrader.CheckOrigin = func(r *http.Request) bool { return true }

	ws, err := upgrader.Upgrade(w, r, nil)
	if err != nil {
		log.Println(err)
		return // Return and do not proceed further if an error occurs during upgrade
	}

	clients[ws] = true        // Add the new client to the clients map
	defer delete(clients, ws) // Remove the client from the clients map when the connection is closed

	log.Println("Client Connected")
	err = ws.WriteMessage(1, []byte("Hi Client!"))
	if err != nil {
		log.Println(err)
		return // Return if an error occurs during writing a message
	}

	reader(ws)
}

func reader(conn *websocket.Conn) {
	defer conn.Close()

	for {
		messageType, p, err := conn.ReadMessage()
		if err != nil {
			log.Println(err)
			return
		}

		log.Println("Received message:", string(p))

		// Send the received message to all connected clients
		broadcastMessage(messageType, p)
	}
}

func broadcastMessage(messageType int, message []byte) {
	for client := range clients {
		err := client.WriteMessage(messageType, message)
		if err != nil {
			log.Println(err)
			client.Close()
			delete(clients, client)
		}
	}
}

func homePage(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "Home Page")
}

func setupRoutes() {
	http.HandleFunc("/", homePage)
	http.HandleFunc("/ws", wsEndpoint)
}

func main() {
	setupRoutes()

	err := http.ListenAndServe(":8080", nil)
	if err != nil {
		log.Fatal("error")
	}
}
