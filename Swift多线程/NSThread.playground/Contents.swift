import UIKit
import Foundation

func test(){
    print("2")
}

//func start() {
//    let thred = Thread {
//        print("1")
//    }
//    thred.start()
//
//
//}

class Person: NSObject {

    override init() {
        super.init()
        let thread = Thread {
            print("1")
        }
        perform(#selector(test2), on: thread, with: nil, waitUntilDone: true)
    }

    @objc func test2() {
        print("2")
    }
}

Person()
