import UIKit

var str = "Hello, playground"

let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "哈啊哈哈哈"])

let error2 = NSError(domain: "", code: 0, userInfo: ["error": "s哈哈哈"])

print(error.localizedDescription)

print(error2.localizedDescription)
