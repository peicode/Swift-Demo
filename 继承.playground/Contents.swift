import UIKit

var str = "Hello, playground"
class Father: NSObject {
    var work = "bank"
    let money = 120
    var _salary = 0
    var salary: Int {
        set{
            _salary = newValue
        }
        get{
            return _salary
        }
    }
    fileprivate let dog = "zz"
    private let cat = "cat"

}

class Son: Father {

}
let p = Father()

let s = Son()
p.setValue(12, forKeyPath: "salary")
s.work
s.dog
//s.cat
