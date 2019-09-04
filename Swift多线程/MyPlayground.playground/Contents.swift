import UIKit

let queue = DispatchQueue(label: "", qos: .default, attributes: .concurrent)
let queue2 = DispatchQueue(label: "llll")
let semphore = DispatchSemaphore(value: 10)
///
for i in 0..<100 {
    print(i)
    semphore.wait(timeout: .distantFuture)
    queue.async {
        print("-=-=-=-=-=-=-==\(Thread.current)")
    }
}


for i in 0...1000 {
    queue2.async {
        semphore.wait(timeout: .distantFuture)

//        sleep(1)
//        debugPrint("-=-=-=-=-=-=-==\(Thread.current)")
//        semphore.signal()

        queue.async {
            print(i)
            //
            sleep(1)
            debugPrint("-=-=-=-=-=-=-==\(Thread.current)")
            semphore.signal()
        }
    }
}

///
//for i in 0...1000 {
//
//    queue.async {
//        print(i)
//        //
//        sleep(1)
//        debugPrint("-=-=-=-=-=-=-==\(Thread.current)")
//        semphore.signal()
//    }
//}



