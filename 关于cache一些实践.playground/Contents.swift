import UIKit
import Foundation
/*
 先了解 NSCache本身
 再阅读 SDWebimage缓存实现，再看浏览器，系统自带缓存等
 */
class Colution {
    var cache: NSCache<AnyObject, AnyObject>?
    var paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.allDomainsMask, false)
    var name: String?
    var address: String?
    var number: Int?
    init() {
        self.name = "我是初始化"
        self.address = "混沌之地"
        self.number = 000001
    }

    func store() {
        cache?.name = "com.lpz"
        cache?.setObject(self.name as AnyObject, forKey: "name" as AnyObject)
        cache?.setObject(self.address as AnyObject, forKey: "address" as AnyObject)
        let path = paths[0] + "lpz"

        if FileManager.default.fileExists(atPath: path) {
            FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
        }

    }



}
