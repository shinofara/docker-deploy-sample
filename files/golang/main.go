package main

import (
  "fmt"
  "os"
  "net/http"
)

func handler(w http.ResponseWriter, r *http.Request) {
  hostname, _ := os.Hostname()
  fmt.Fprintf(w, "Hello, World\nhostname: %s", hostname)
}

func main() {
  http.HandleFunc("/", handler) // ハンドラを登録してウェブページを表示させる
  http.ListenAndServe(":9000", nil)
}
