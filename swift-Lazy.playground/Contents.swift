import UIKit
// 关于lazy的一些思考，lazy只会被调用一次
// 懒加载本质上是一个 闭包
// 懒加载会在第一次访问的时候执行, 闭包执行结束后, 会把结果保存在 属性 中
// 后续调用, 直接返回 属性 的内容
// 懒加载的属性会分配空间, 存储值
// 只要调用过一次, 懒加载后面的闭包再也不会执行了
var str = "Hello, playground"
class LazyClass{
    lazy var a: [String : String]? = {
        print("aaaa我就调用一次")
        return ["name": "hahha","name2": "hahha"]
    }()

    var b: Int{
        print("bbb我调用了几次")
        return 123
    }

    var c: Int = {
        print("ccc调用了")
        return 123
    }()

    init() {
        print(a!)
        print(b)
        print(c)
        a?.removeValue(forKey: "name")
        a = nil
        print(a ?? [:])
        print(b)
        print(c)
    }
}
// 注意: 一旦 a 被设置为 nil, 懒加载也不会再次执行
// 懒加载的代码只会在第一次调用的时候, 执行闭包, 然后将闭包的结果保存在 label 的属性中
let lazyC = LazyClass()
