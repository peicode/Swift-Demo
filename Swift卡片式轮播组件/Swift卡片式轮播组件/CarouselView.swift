//
//  CarouselView.swift
//  Swift卡片式轮播组件
//
//  Created by 廖佩志 on 2019/9/6.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class CarouselView: UIView {

    public var images: [String] = []

    var pageIndex: Int = 0
    var pageSize: CGSize
    var padding: CGFloat = 10

    var height: CGFloat = 200

    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.bounds.width - 4 * padding, height: height)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = padding
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        return layout
    }

    lazy var collectionView: UICollectionView = {
        let collectionV = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionV.delegate = self
        collectionV.dataSource = self
//        collectionV.isPagingEnabled = true
        return collectionV
    }()

    override init(frame: CGRect) {
        self.pageSize = CGSize(width: frame.width - 4 * padding, height: height)
        super.init(frame: frame)
        addSubview(collectionView)
        collectionView.register(CarouselViewCell.self, forCellWithReuseIdentifier: "CarouselViewCell")
        collectionView.setContentOffset(CGPoint(x: -10, y: 0), animated: false)
//        pageSize = CGSize(width: self.bounds.width - 4 * padding, height: 200)
        collectionView.contentSize = CGSize(width: CGFloat(images.count) * (pageSize.width + padding) + padding, height: 200)
        print("sddd")
        print(CGFloat(images.count) * (pageSize.width + padding) + padding)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CarouselView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarouselViewCell", for: indexPath) as! CarouselViewCell
        cell.currentImage = UIImage(named: images[indexPath.row])!
                return cell
    }


    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        print("didendSSS")
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("didscroll")
        print(scrollView.contentSize)
        print(scrollView.contentOffset)
        print(scrollView.contentOffset.x / pageSize.width)
        pageIndex = scrollView.contentOffset.x / pageSize.width % pageIndex

        if (pageIndex > 0.5) {

        }
    }
}
