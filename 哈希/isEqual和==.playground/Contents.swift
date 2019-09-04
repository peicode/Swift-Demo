import UIKit

//判等
//  在OC中，在 Objective-C 中 == 这个符号的意思是判断两个对象是否指向同一块内存地址。其实很多时候这并不是我们经常所期望的判等，我们更关心的往往还是对象的内容相同，而这种意义的相等即使两个对象引用的不是同一块内存地址时，也是可以做到的。Objective-C 中我们通常通过对 -isEqual: 进行重写，或者更进一步去实现类似 -isEqualToString: 这样的 -isEqualToClass: 的带有类型信息的方法来进行内容判等。如果我们没有在任意子类重写 -isEqual: 的话，在调用这个方法时会直接使用 NSObject 中的版本，去直接进行 Objective-C 的 == 判断。

//  在 Swift 中情况大不一样，Swift 里的 == 是一个操作符的声明，在 Equatable 里声明了这个操作符的接口方法。 在Swift中，=== 用来判断两个 AnyObject 是否是同一个引用。
/* 如果是不继承自NSObject的纯Swift类，默认是不遵循Equatable协议的，也就是根本不能用==进行判断。而如果是继承自NSObject，那么==的默认实现是调用isEqual(_object:Any?)，而这个方法的默认实现是比较实例的地址。字符串等基本类型是已经替换了默认实现，所以平常用的时候感觉不到有什么异常。
 */

//
var string = "string"
var string1 = "string"
String(format: "%p", string)
String(format: "%p", string1)


var a = [1,2,3,4]
var b = a
String(format: "%p", a)
String(format: "%p", b)

var dict = [1:2]
var dict2 = [1:2]
String(format: "%p", dict)
String(format: "%p", dict2)

struct struct111: Hashable {
    var a: String
    var b: String
    var c: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(a)
        hasher.combine(b)
        hasher.combine(c)
    }
}

var s = struct111(a: "a", b: "b", c: "c")
s.a.hashValue
var ss = struct111(a: "a", b: "b", c: "c")
ss.a.hashValue
print(s.hashValue)
print(ss.hashValue)

let str = String("adbcefg")
var str1 = String("adbcefg")



"22".hash
str.hash

str.hashValue
str1.hash
str1.hashValue
//print(s.a.hashValue)

//unsafeBitCast(s, to: String.self)
withUnsafePointer(to: &a) { (p) in
    print(String(format: "%p", p))
}

withUnsafePointer(to: &b) { (p) in
    print(String(format: "%p", p))
}

print(String(format: "%p", str))
print(String(format: "%p", str1))
str == str1
str.isEqual(str1)
//str === str1
//
//let dict = [1: "22"]
//let dict1 = [1: "22"]
//print(String(format: "%p", dict))
//print(String(format: "%p", dict1))
//dict.hash
//dict.hashValue
//dict1.hash
//dict1.hashValue
//dict == dict1


let color1: UIColor = UIColor(red: 0.1, green: 0.3, blue: 0.1, alpha: 1)
print(String(format: "%p", color1))
let color2: UIColor = UIColor(red: 0.1, green: 0.3, blue: 0.1, alpha: 1)
print(String(format: "%p", color2))
color1.hash
color2.hash
color1.hashValue
color2.hashValue
color1 == color2
color1.isEqual(color2)
color2 === color1


//NSObject
class Person2: NSObject{
    var name: String
    init(name: String) {
        self.name = name
    }
}

let b1 = Person2(name: "lpz")
print(String(format: "%p", b1))
let b2 = Person2(name: "lpz")
print(String(format: "%p", b2))
b1.hash
b2.hash
b1 == b2
b1.isEqual(b2)

//
class Person{
    var name: String
    init(name: String) {
        self.name = name
    }

}

extension Person: Equatable{
    static func == (lhs: Person, rhs: Person) -> Bool {
        return lhs.name == rhs.name
    }
}

let o1 = Person(name: "lpz")
let o2 = Person(name: "lpz")
//o1.hash
//o2.hash
o1 == o2
o1 === o2
//o1.isEqual(o2)

