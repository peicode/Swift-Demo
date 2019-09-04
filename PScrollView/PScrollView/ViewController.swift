//
//  ViewController.swift
//  PScrollView
//
//  Created by 廖佩志 on 2019/1/24.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let scrV = PScrollView()
        scrV.frame = CGRect(x: 0, y: 300, width: view.bounds.width, height: 300)
        view.addSubview(scrV)
        // Do any additional setup after loading the view, typically from a nib.
    }


}

