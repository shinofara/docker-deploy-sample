#!/bin/sh
GOOS=linux GOARCH=amd64 go build -o docker-web main.go
