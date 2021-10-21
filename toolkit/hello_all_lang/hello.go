/*
@name: hello.go
@date: 2021-11-4
@author: keefe
@cmd: 
 $go run hello.go       // run=compile+run
 $go build hello.go & ./hello   //build=compile
@note
第一行代码 package main 定义了包名。你必须在源文件中非注释的第一行指明这个文件属于哪个包，如：package main。package main表示一个可独立执行的程序，每个 Go 应用程序都包含一个名为 main 的包。
*/

package main

import "fmt"

func main() {  // {不能单独一行
    // this is my first go program 
    fmt.Println("Hello, World!")
}
