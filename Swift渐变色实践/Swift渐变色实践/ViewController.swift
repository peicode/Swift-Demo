//
//  ViewController.swift
//  Swift渐变色实践
//
//  Created by 廖佩志 on 2019/9/4.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let gradientBtn = GradientButton(frame: CGRect(x: view.center.x - 50, y: 200, width: 100, height: 100))
        gradientBtn.setTitle("axial", for: .normal)
        gradientBtn.setTitleColor(.black, for: .normal)
        gradientBtn.gradientLayer(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor], type: .axial)

        view.addSubview(gradientBtn)

        let gradientBtn2 = GradientButton(frame: CGRect(x: view.center.x - 50, y: 310, width: 100, height: 100))
        gradientBtn2.setTitle("conic", for: .normal)
        gradientBtn2.setTitleColor(.black, for: .normal)
        gradientBtn2.gradientLayer(colors: [UIColor.red.cgColor,  UIColor.yellow.cgColor], type: .conic)

        view.addSubview(gradientBtn2)

        let gradientBtn3 = GradientButton(frame: CGRect(x: view.center.x - 50, y: 420, width: 100, height: 100))
        gradientBtn3.setTitle("radial", for: .normal)
        gradientBtn3.setTitleColor(.black, for: .normal)
        gradientBtn3.gradientLayer(colors: [UIColor.red.cgColor, UIColor.yellow.cgColor], type: .radial)

        view.addSubview(gradientBtn3)



    }


}

