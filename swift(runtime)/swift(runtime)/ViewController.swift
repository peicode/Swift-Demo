//
//  ViewController.swift
//  swift(runtime)
//
//  Created by 廖佩志 on 2018/9/14.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var count: UInt32 = 0
    var count2: UInt32 = 0
    var disPlayLink: CADisplayLink?
    override func viewDidLoad() {
        super.viewDidLoad()
        var count :UInt32 = 0
        disPlayLink = CADisplayLink(target: self, selector: #selector(calculateFPS))
        disPlayLink?.add(to: RunLoop.main, forMode: .UITrackingRunLoopMode)
//        let methList = class_copyMethodList(class_getName(Person.self), &(count!))
//        print(methList)
//        changMethod()
//        UnsafePointer<Any>
//        objc_getClass(TestRuntime)
        let class1 = TestRuntime()
        let proList = class_copyPropertyList(object_getClass(class1), &count)
        let methodList = class_copyMethodList(object_getClass(class1), &count2)

        for i in 0..<numericCast(count) {
            let property = property_getName((proList![i]))
            print("属性成员变量\( String(utf8String: property) ?? "没有找到")")
        }

        for i in 0..<count2 {
            let methodName = method_getName(methodList![Int(i)])
            print(methodName)
        }
    }
    func changMethod(){
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        disPlayLink?.invalidate()
        RunLoop()
    }
    @objc func calculateFPS() {

    }

}
@objcMembers
class TestRuntime{
    var aBool: Bool = true
    var aInt: Int = 0
    func factory1() {
        print("This is factory1!")
    }

    func factory2() {
        print("This is factory2!")
    }
}
