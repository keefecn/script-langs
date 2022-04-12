/*
智能地址解析
@file: addr_parse.go
@cmd: go run addr_parse.go
@requirement: go get github.com/pupuk/addr
*/

package main

import (
    "fmt"
    "github.com/pupuk/addr"   //依赖模块
)

func main() {
    parse := addr.Smart("张三 13800138000 龙华区龙华街道1980科技文化产业园3栋308 身份证120113196808214821")

    // 输出解析结果
    fmt.Println(parse.Name)     // 张三
    fmt.Println(parse.IdNumber) // 120113196808214821
    fmt.Println(parse.Mobile)   // 13800138000
    fmt.Println(parse.PostCode) // 570100
    fmt.Println(parse.Province) // 广东省
    fmt.Println(parse.City)     // 深圳市
    fmt.Println(parse.Region)   // 龙华区
    fmt.Println(parse.Street)   // 龙华街道1980科技文化产业园3栋317
    fmt.Println(parse.Address)  // 深圳市龙华区龙华街道1980科技文化产业园3栋317
}
