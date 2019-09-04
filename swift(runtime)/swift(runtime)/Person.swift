//
//  Person.swift
//  swift(runtime)
//
//  Created by 廖佩志 on 2018/9/14.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit

class Person: NSObject {
    @objc dynamic var name: String!
    @objc dynamic var address: String!
    @objc dynamic func method1() {
        print("这是方法1")
    }
    @objc dynamic func method2() {
        print("这是方法2")
    }
//    override init() {
//        class_replaceMethod(self, meth, <#T##imp: IMP##IMP#>, <#T##types: UnsafePointer<Int8>?##UnsafePointer<Int8>?#>)
//    }
}
