//
//  CarouselViewCell.swift
//  Swift卡片式轮播组件
//
//  Created by 廖佩志 on 2019/9/9.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {

    var imageView : UIImageView

    var currentImage: UIImage{
        didSet{
            imageView.image = currentImage
        }
    }

    override init(frame: CGRect) {
        self.imageView = UIImageView()
        self.currentImage = UIImage(named: "插图1")!
        super.init(frame: frame)
        addSubview(imageView)
    }

//    init() {
//        setupUI()
//    }

    func setupUI() {

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        imageView.frame = self.bounds
    }

}
