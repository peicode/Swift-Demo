//
//  ViewController.swift
//  testForDidSet
//
//  Created by 廖佩志 on 2018/11/30.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var a: String = "" {
        didSet{
            a = "123"
            a = "456"
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        a = "1"
        print(a)
        let view1 = UIView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        view1.backgroundColor = .red
        view.addSubview(view1)
        let view2 = UIView(frame: CGRect(x: 200, y: 100, width: 100, height: 100))
        view2.backgroundColor = .green
        print(view2.bounds)
        view2.bounds = view2.bounds.insetBy(dx: -50, dy: -50)
        print(view2.bounds)
        view.addSubview(view2)


        // Do any additional setup after loading the view, typically from a nib.
    }



}

