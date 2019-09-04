//
//  ViewController.swift
//  ScrollView嵌套
//
//  Created by 廖佩志 on 2018/9/5.
//  Copyright © 2018年 廖佩志. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {
    var scrollView: UIScrollView?
    var imageView: UIScrollView?
    var beginFrame: CGRect?
    override func viewDidLoad() {
        super.viewDidLoad()
        let scroll = UIScrollView()
//        UIScrollViewDelegate
        scroll.frame = view.frame
        scroll.contentSize = CGSize(width: view.frame.size.width, height: 1000)
        scroll.delegate = self as! UIScrollViewDelegate;
//        scroll.backgroundColor = UIColor.red
        view.addSubview(scroll)
        scrollView = scroll
        //
        let headView = UIScrollView()
        headView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 300)
        headView.backgroundColor = UIColor.black
        scroll.addSubview(headView)
        beginFrame = headView.frame
        imageView = headView
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:-UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        let offSetY = scrollView.contentOffset.y
        
//        if offSetY > 10 {
//            let scale = offSetY/beginFrame?.size.height
            let scale = min(1.0, max(0.3, 1 - offSetY/(beginFrame?.size.height)!))
            let width = (beginFrame?.size.width)! * scale
            let height = (beginFrame?.size.height)! * scale
//            let y = offSetY - (beginFrame?.size.height)!
            let y = (beginFrame?.size.height)! - offSetY
            let x = offSetY
            imageView?.frame = CGRect(x: x, y: y, width: width, height: height)
            imageView?.alpha = scale * scale
//        }
    }
}

