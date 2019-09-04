import UIKit

var str = "Hello, playground"

class Solution: NSObject, NSMutableCopying {
    func mutableCopy(with zone: NSZone? = nil) -> Any {
        let a = Solution()
        a.name = self.name
        return a
    }
    private override init() {

    }
    //单例
    var name = "lpz"

    static let shared = Solution()

    static func sharedInstance() -> Solution{
        return shared
    }
    func doWork() {

    }
}

class Solution2: NSObject {
    private static var shared: Solution2?

    private override init() {

    }

    class func getSharedInstance() -> Solution2 {
        guard let _instance = shared else {
            shared = Solution2()
            return shared!
        }
        return _instance
    }

    class func destroy() {
        shared = nil
    }
}


let s = Solution2.getSharedInstance()
Solution2.destroy()
let s1 = Solution2.getSharedInstance()

let s2 = Solution2.getSharedInstance()

let a = Solution.shared
a.name = "hhhh"

let b = Solution.shared
b.name = "ssss"
// copy() Returns a new instance that’s a copy of the receiver.

let c = Solution.mutableCopy()

let d = Solution.sharedInstance()

print(a.name)
print(b.name)
//print(c.name)

print(a,b,c,d)

UIApplication.shared

