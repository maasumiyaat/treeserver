.PHONY: build run test

build:
	go build -o bin/treeserver ./cmd/server

run: build
	./bin/treeserver

test:
	go test ./... -v
