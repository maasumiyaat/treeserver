package main

import (
    "log"
    "net/http"

    "github.com/yourusername/treeserver/internal/db"
    "github.com/yourusername/treeserver/pkg/api"
)

func main() {
    if err := db.InitFromEnv(); err != nil {
        log.Fatalf("db init: %v", err)
    }

    mux := http.NewServeMux()
    api.RegisterHandlers(mux)

    log.Println("server listening :8080")
    log.Fatal(http.ListenAndServe(":8080", mux))
}
