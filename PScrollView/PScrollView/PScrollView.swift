//
//  PScrollView.swift
//  PScrollView
//
//  Created by 廖佩志 on 2019/1/24.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class PScrollView: UIView, UIScrollViewDelegate {

    var scrView: UIScrollView?
    var leftImgV: UIImageView?
    var centerImgV: UIImageView?
    var rightImgV: UIImageView?

    var pageCtrl: UIPageControl?

    var currentIndex: Int = 0

    var imgArray: [String] {
        let a = ["img1", "img2", "img3"]
        return a
    }
    var imageCount = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageCount = imgArray.count
        scrView = UIScrollView()
        addSubview(scrView!)
        guard let scrV = scrView else {
            return
        }
        leftImgV = UIImageView()

        centerImgV = UIImageView()

        rightImgV = UIImageView()


        pageCtrl = UIPageControl()

        scrV.addSubview(leftImgV!)
        scrV.addSubview(centerImgV!)
        scrV.addSubview(rightImgV!)
        addSubview(pageCtrl!)

        leftImgV?.image = UIImage(named: imgArray[2])
        leftImgV?.contentMode = .scaleAspectFit
        centerImgV?.image = UIImage(named: imgArray[0])
        centerImgV?.contentMode = .scaleAspectFit
        rightImgV?.image = UIImage(named: imgArray[1])
        rightImgV?.contentMode = .scaleAspectFit
    }
    override func layoutSubviews() {
        scrView?.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        scrView?.delegate = self
        scrView?.contentSize = CGSize(width: CGFloat(imgArray.count) * self.bounds.width, height: self.bounds.height)
//        scrView?.setContentOffset(CGPoint(x: self.bounds.width, y: 0), animated: false)
        scrView?.contentOffset.x = self.bounds.width
        scrView?.isPagingEnabled = true

        scrView?.showsHorizontalScrollIndicator = false
        guard let scrV = scrView else {
            return
        }
        leftImgV?.frame = CGRect(x: 10, y: 0, width: scrV.bounds.width-20, height: scrV.bounds.height)
        centerImgV?.frame = CGRect(x: 10+scrV.bounds.width, y: 0, width: scrV.bounds.width-20, height: scrV.bounds.height)
        rightImgV?.frame = CGRect(x: 10+2 * scrV.bounds.width, y: 0, width: scrV.bounds.width-20, height: scrV.bounds.height)

        let size = pageCtrl?.size(forNumberOfPages: imgArray.count)
        pageCtrl?.frame = CGRect(x: 0, y: 0, width: (size?.width)!, height: (size?.height)!)
        currentIndex = 0
        pageCtrl?.center = CGPoint(x: self.bounds.width * 0.5, y: self.bounds.height-60)
        pageCtrl?.numberOfPages = imgArray.count
        pageCtrl?.currentPage = currentIndex
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func imageChange() {

        var leftIndex: Int = 0
        var rightIndex: Int = 0
        if (scrView?.contentOffset.x)! > bounds.width {//右滑
            currentIndex = (currentIndex + 1) % imageCount
        }else {
            currentIndex = (currentIndex + imageCount - 1) % imageCount
        }
        centerImgV?.image  = UIImage(named: String(format: "img%i", currentIndex))

        leftIndex = (currentIndex + imageCount - 1) % imageCount
        rightIndex = (currentIndex + 1) % imageCount
        leftImgV?.image  = UIImage(named: String(format: "img%i", leftIndex))
        rightImgV?.image  = UIImage(named: String(format: "img%i", rightIndex))
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        imageChange()
        scrollView.contentOffset.x = bounds.width
        pageCtrl?.currentPage = currentIndex
    }

}
