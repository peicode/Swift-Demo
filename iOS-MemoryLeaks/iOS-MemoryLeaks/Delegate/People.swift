//
//  People.swift
//  iOS-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/27.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
protocol PeopleDelegate: NSObjectProtocol {
    func work()
    func addButton()
}

@objcMembers
class People: NSObject {
    /*
     若不用weak修饰, 在DelegateController声明一个People属性，通过delegate强引用。
     P->Delegate,VC->P,P.delegate->VC。形成闭环
    */
    weak var delegate: PeopleDelegate?
    var age: Int = 20
    override init() {

    }

    func jobName() {
        delegate?.work()
    }

    func addWight() {
        delegate?.addButton()
    }

}
//面向协议编程
extension PeopleDelegate {
    func work() {
        print("my job is Cali engineer!")
    }
}
