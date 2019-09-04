//
//  DelegateController.swift
//  iOS-MemoryLeaks
//
//  Created by 廖佩志 on 2019/3/27.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class DelegateController: UIViewController {

    var p: People?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        p = People()
        p!.delegate = self
        p!.jobName()
        p!.addWight()
    }

    deinit {
        print("DelegateController-has-been-deinited!!!")
    }
}
extension DelegateController: PeopleDelegate {

    func work() {
        print("my job is iOS engineer!")
    }

    func addButton() {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 100, height: 30))
        label.text = "Leaks"
        view.addSubview(label)
    }
}
