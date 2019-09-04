import UIKit
func print(address o: UnsafeRawPointer) {
    print(String(format: "%p", Int(bitPattern: 0)))
}
///String
print("String")
var str = "123"
var str1 = "123"
print(String(format: "%p", str))
print(String(format: "%p", str1))
///Int
var i = 12
var j = 10
print(String(format: "%p", i))
print(String(format: "%p", j))
///Array
print("Array")
let array = [1,2,3]
let array1 = [1,2,3]

print(String(format: "%p", array))
print(String(format: "%p", array1))



var array3: [Int] = [0, 1, 2, 3]
var array4 = array1

//Print with just assign
print(address: array3)
print(address: array4)
print(String(format: "%p", array3))
print(String(format: "%p", array4))

///dict
print("dict")
let dict = ["name": "lpz"]
let dict1 = ["name": "lpz"]

print(String(format: "%p", dict))
print(String(format: "%p", dict1))
dict1 == dict

///
struct S<T> {
    var x: T
    @_specialize(where T == Int, U == Float)
    mutating func exchangeSecond<U>(_ u: U, _ t: T) -> (U, T) {
        x = t
        return (u, x)
    }
}

