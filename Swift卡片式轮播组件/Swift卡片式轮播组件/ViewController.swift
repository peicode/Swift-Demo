//
//  ViewController.swift
//  Swift卡片式轮播组件
//
//  Created by 廖佩志 on 2019/9/6.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        let carouselView = CarouselView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
        carouselView.center = view.center
        carouselView.images = ["插图1.png","插图2.png","插图3.png"]
        view.addSubview(carouselView)
    }
     

}

