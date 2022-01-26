/*
@file: goruntime.go
@cmd: go run goruntime.go
*/
package main

import (
        "fmt"
        "time"
)

func say(s string) {
        for i := 0; i < 5; i++ {
                time.Sleep(100 * time.Millisecond)
                fmt.Println(s)
        }
}

func main() {
        go say("world")  // go关键字 make a goruntime thread
        say("hello")
}
