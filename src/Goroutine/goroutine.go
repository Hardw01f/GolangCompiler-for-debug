package main

import (
	"flag"
	"fmt"
	"os"
	"time"
)

func Sayhello() {
	fmt.Printf("%s\n", "Hello,")
}

func Sayname(name string) {
	fmt.Printf("%s\n", name)
}

func Welcome() {
	fmt.Printf("%s\n", "Welcome the Golang World!")
}

func main() {
	flag.Parse()

	if len(os.Args)-1 != 1 {
		fmt.Println("[usage] : go run goruotine [YOUR_NAME]\n ")
		os.Exit(1)
	}

	for i := 0; i < 5; i++ {
		go Sayhello()
		go Sayname(flag.Arg(0))
		go Welcome()
	}
	time.Sleep(2 * time.Second)
}
