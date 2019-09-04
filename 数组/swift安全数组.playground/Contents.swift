import UIKit



//var array = Array<Int>(repeating: 0, count: 1001)
var array = [Int]()
//malloc: *** error for object 0x7fd2e380ea00: pointer being freed was not allocated
//"-=-=-=-=-=-=-==<NSThread: 0x600002328ec0>{number = 48, name = (null)}"
//MyPlayground(37044,0x700010342000) malloc: *** set a breakpoint in malloc_error_break to debug
let queue = DispatchQueue(label: "", qos: .default, attributes: .concurrent)
for i in 0...1000 {
    queue.async {
        array.append(i)
        debugPrint("\(i)-=-=-=-=-=-=-==\(Thread.current)")
    }
}
//这样会发生概率崩溃的问题


//解决方案
/*
1.添加栅栏函数
2.扩容
*/
