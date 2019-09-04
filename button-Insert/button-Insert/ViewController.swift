//
//  ViewController.swift
//  button-Insert
//
//  Created by 廖佩志 on 2018/10/19.
//  Copyright © 2018 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func click(_ sender: UIButton) {
        print(1)
    }
    @IBOutlet weak var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

