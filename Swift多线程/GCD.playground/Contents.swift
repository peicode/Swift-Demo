import UIKit

//系统性的写一下 多线程
/*
 先了解操作系统的相关知识 并发 并行
 并发指的宏观上在一段时间内能同时运行多个程序，而并行则是同一时刻运行多个指令。
 并行需要硬件支持，如l多流水线、多核处理器或者分布式计算系统。
 操作系统通过引入进程和线程，使得程序能够并发运行。
*/
/*
 GCD：多核编程，它是一个在线程池模式的基础上执行的并发任务。(在系统级运行的GCD可以更好地适应所有正在运行的应用程序的需要，以平衡的方式将它们与可用的系统资源进行匹配。)
 GCD: FIFO队列和任务
 **Synchronous and Asynchronous Execution
 同步执行（sync）：
     1. 同步添加任务到指定队列中，再添加任务执行结束之前，会一直等到队列里面的任务完成，之后再继续执行。
     2. 只有在当前线程中执行任务，不具备开启新线程的能力
 异步执行（async）:
     1. 异步添加任务到指定的队列中，他不会做任何等待，可以继续执行任务.
     2. 可以在新的线程中执行任务，具备开启新线程能力。
 **Serial and Concurrent Queues
 串行和并发队列：
 串行：任务在队列里面按照顺序执行
 并发：任务在队列里面按照任意顺序执行
 自定义任务，条件：A、B、C三个任务，一次进行
*/
//DispatchQueue(label: T##String, qos: T##DispatchQoS, attributes: T##DispatchQueue.Attributes, autoreleaseFrequency: T##DispatchQueue.AutoreleaseFrequency, target: T##DispatchQueue?)
let queue = DispatchQueue(label: "concurrent", qos: .default, attributes: .concurrent, autoreleaseFrequency: .workItem, target: nil)
// 如果传值initiallyInactive，需要手动激活activate()，串行执行; 如果是[.concurrent, .initiallyInactive]，则手动触发，并发执行。
queue.activate()
queue.async {
    print("dddddddddd")
    var i = 0
    while i<60 {
//        print("hhhhhh\(Thread.current)")
        i += 1
    }

    //    sleep(10)
    var j = 0
    while j<10 {
//        print("h1h11h1h\(Thread.current)")
        j += 1
    }

}

queue.async {
    print("ssssss\(Thread.current)")
    var j = 0
    while j<20 {
//        print("h1h11h1h\(Thread.current)")
        j += 1
    }
}

//queue.sync {
//
//    var i = 0
//    while i<30 {
//        print("hhhhhh\(Thread.current)")
//        i += 1
//    }
//
//    //    sleep(10)
//    var j = 0
//    while j<10 {
//        print("h1h11h1h\(Thread.current)")
//        j += 1
//    }
//}

queue.async {
    print("zzzzzz\(Thread.current)")
}
/*
 DispatchWorkItem
 DispatchWorkItem(qos: , flags: DispatchWorkItemFlags, block: T##() -> Void)
 DispatchWorkItemFlags:
*/
let workItem = DispatchWorkItem {
    // 执行任务
    print("我是workitem111")
}

//执行workitem闭包内容
let flag = false
if flag {
    workItem.wait()
    print("work wait")
} else {
    workItem.perform()
}

workItem.cancel()

if workItem.isCancelled {
    print("work is Cancel!!!")
} else {
    queue.async(execute: workItem)
}

//DispatchGroup
// 一个enter，对应一个leave
let group = DispatchGroup()
//let queueD = DispatchQueue(label: "serial")




//group.enter()
queue.sync {
    var i = 0
    while i < 10 {
//        print("分派组111\(Thread.current)")
        i += 1
    }
//    group.leave()
}

//group.enter()
queue.async {
    var i = 0
    while i<30 {
//        print("分派组122\(Thread.current)")
        i += 1
    }
    //    group.leave()
}

//group.wait()

//group.leave()
//
//group.enter()
//group.enter()
//queue.async {
//    print("分派组133")
//    group.leave()
//
//}
//group.notify(queue: queue) {
//    print("group任务完成了！")
//}


//DispatchSemaphore
//信号量可以控制多线程异步执行的任务顺序，进行资源控制
let semaphore = DispatchSemaphore(value: 0)

queue.async {
    var i = 0
    while i<30 {
        print("sema")
        i += 1
    }
    semaphore.signal()
}
semaphore.wait()
queue.async {
    print("sema222")
    semaphore.signal()
}
semaphore.wait()
print("ddddd")

//DispatchData()
let time = DispatchTime(uptimeNanoseconds: 12)
print(time.rawValue,time.uptimeNanoseconds)

print(DispatchTime.now().rawValue)

//DispatchPredicate()


