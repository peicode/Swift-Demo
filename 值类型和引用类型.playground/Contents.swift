import UIKit

//var numbers = [1, 2, 3, 4, 5]
//var firstCopy = numbers
//var secondCopy = numbers
//
//// The storage for 'numbers' is copied here
//String(format: "%p, %p, %p", numbers,firstCopy,secondCopy)
//numbers[0] = 100
//numbers[1] = 200
//numbers[2] = 300
//print(numbers,firstCopy,secondCopy)
//String(format: "%p, %p, %p", numbers,firstCopy,secondCopy)
//打印内存地址
func address(of object: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: object)
    return String(format: "%p", addr)
}

//Int类型
var a = 10
var b = a
var c = a
a = 12
print(address(of: &a), address(of: &b), address(of: &c))
print(Unmanaged.passUnretained(a as AnyObject).toOpaque())
print(Unmanaged.passUnretained(b as AnyObject).toOpaque())
String(format: "%p, %p, %p", a,b,c)
withUnsafePointer(to: &a) { (p) in
    print(String(format: "%p", p))
}

withUnsafePointer(to: &b) { (p) in
    print(String(format: "%p", p))
}
withUnsafePointer(to: &c) { (p) in
    print(String(format: "%p", p))
}

//String

var str = "str"
var str1 = "str1"
String(format: "%p, %p", str, str1)//0xdc72ceaa25ccc21f, 0xdc72cea935ccc218
//从上面可以看出，内存地址从高到低，"str", "str1"应该是在栈中
withUnsafePointer(to: &str) { (p) in
    print(String(format: "%p", p))
    //0x1170592b8
}
withUnsafePointer(to: &str1) { (p) in
    print(String(format: "%p", p))
    //0x1170592c8
}
//而变量str和str1存在堆中，指向对应栈中字符串的地址

///struct
struct People {
    var x, y: Double
    func work() {
    }
}

let peo1 = People(x: 0, y: 0) //进行peo1初始化，开辟栈内存
var peo2 = peo1//初始化peo2，拷贝peo1的内容，开辟新内存
peo2.x = 5 //对peo2的操作不会影响peo1
print(peo1.x)

/// Array
print("array-引用类型-----start")
var numbers = [1, 2, 3, 4, 5]{
    didSet{
        print("numbers-array-change")
    }
}
var firstCopy = numbers {
    didSet{
        print("firstCopy-array-change")
    }
}
/*
 * 数组复制时，不会拷贝，都指向同一份内存地址；
 * 只有当数组的值发生改变时，才会发生了拷贝
 */
print(address(of: &numbers), address(of: firstCopy))
//numbers[0] = 100
firstCopy[0] = 123
//numbers[1] = 200
print(address(of: &numbers), address(of: firstCopy))
print("array-引用类型-----end")
///class
print("class-引用类型-----start")
class Person {
    var name: String {
        didSet{
            print("name change!!!")
        }
    }
    init(name: String) {
        self.name = name
    }
}

var ocArray: NSMutableArray = [1,2,3,4] {
    didSet {
        print("ocArray--change")
    }
}

ocArray[0] = 12
var p = Person(name: "11")
var p1 = p
var p2 = p

print(address(of: &p), address(of: &p1), address(of: &p2))
print("class-引用类型-----change")
p2.name = "lpz"
print(p.name, p1.name)
print(address(of: &p), address(of: &p1), address(of: &p2))
print("class-引用类型-----end")
