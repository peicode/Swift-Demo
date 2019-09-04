import UIKit

var str = "Hello, playground"
// inout
var x = 10
func test(a: inout Int) {
    a += 1
    print(a)
}
test(a: &x)

// defer

func testDefer() {
    print("start")
    defer{
        print("执行defer1")
    }
    print("函数结束")
//    defer {
//        //'defer' statement before end of scope always executes immediately; replace with 'do' statement to silence this warning
//        //范围结束前，defer语句总是最先执行，会优先执行defer2
    // print("defer2")

//    }
}

testDefer()

func testDefer2() {
    let queue = DispatchQueue.init(label: "queue1")
    queue.async {
        defer {
            print("hhhh")
        }
        print("end")
    }
    let queue2 = DispatchQueue.init(label: "queue2", qos: .default, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
    queue2.async {
        defer {
            print("end2")
        }
        print("async2")
    }
    queue2.async {
        print("22222")
    }
//    DispatchQueue.async(DispatchQueue)
}
testDefer2()


//throws

enum MyError: Error {
    case error1
    case error2
    case error3
}
//throws的使用很简单，只需要在可能出现异常的函数或者方法后面添加throws。经过这个关键字修饰的函数，在调用的时候，需要程序员加上do-catch来调用。对于错误类型开发者来说，只需要使用Throws进行修饰，就保证了以后的调用者必然需要对相应的错误进行处理（当然也可以不处理，但无论如何，错误被throw携带出来了，以后的维护和优化不需要重新做错误处理的设计，直接加上错误处理的逻辑即可）。

func throwError(type: MyError)throws -> String{
    switch type {
    case .error1:
        throw MyError.error1
    case .error2:
        throw MyError.error2
    case .error3:
        throw MyError.error3
    }
}

do {
    try throwError(type: .error1)
} catch let err as MyError {
    print(err)
}

//
