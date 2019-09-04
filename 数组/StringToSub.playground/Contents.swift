import UIKit

var str = "Hello, playground"
let index = String.Index(encodedOffset: -1)
let end = String.Index(encodedOffset: 5)
let str2 = str.count > 100 ? str[index..<end] : "dqqdq"

let str3 = str[end..<index]

