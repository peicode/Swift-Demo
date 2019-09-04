//
//  ViewController.swift
//  MD5加密算法实践
//
//  Created by 廖佩志 on 2019/3/4.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        print(PSMD5Tool.md5(str: "lpz"))
    }


}

