import UIKit

let queue = OperationQueue()
queue.maxConcurrentOperationCount = 3

let op1 = BlockOperation {
    //执行任务1
    print("task111")
}
//如果不想用queue，直接调用start()
//op.start()

let op2 = BlockOperation {
    print("task222")
}
//添加队列优先级
op2.queuePriority = .veryHigh

let op3 = BlockOperation {
    sleep(2)
    print("task333")
}
op3.queuePriority = .veryLow
//添加依赖关系，依赖级别高于队列优先级
op2.addDependency(op3)
queue.addOperation(op1)
/*
waitUntilFinished: Blocks execution of the current thread until the operation object finishes its task.
 true：直到operation对象执行完所有的任务  false: 继续执行，不等所有任务完成。
*/
queue.addOperations([op2,op3], waitUntilFinished: false)

let op4 = BlockOperation {
    print("task444")
}

op4.start()
