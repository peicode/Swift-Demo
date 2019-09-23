//
//  XSLNavigationBar.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/18.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit


public protocol XSLNavigationBarDelehate: class {
    func customRightImageClick()
}

private struct Const {
    /// NavigationBarHeight
    static let NavBarHeightSmallState: CGFloat = 44
    static let NavBarHeightLargeState: CGFloat = 96.0
    /// imageHeight
    static let ImageSizeForSmallState: CGFloat = 24
    static let ImageSizeForLargeState: CGFloat = 30
    /// imageMarginBottom
    static let ImageBottomMarginForSmallState: CGFloat = 12
    static let ImageBottomMarginForLargeState: CGFloat = 8

    static let ImageRightMargin: CGFloat = 16

}


open class XSLNavigationBar: UINavigationBar, UINavigationBarDelegate {

    public var customRightImage: UIImage?
    public var imageView: UIImageView
    open weak var customDelegate: XSLNavigationBarDelehate?
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override open func draw(_ rect: CGRect) {
        // Drawing code
    }

    public init(viewController: UINavigationController, customRightImage: UIImage?) {
        self.customRightImage = customRightImage
        self.imageView = UIImageView(image: customRightImage)
        super.init(frame: viewController.navigationBar.frame)
        delegate = self

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(clickSearch))
        imageView.contentMode = .scaleAspectFit
        imageView.addGestureRecognizer(tapGesture)


        self.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 18) ?? (Any).self]

        if #available(iOS 11.0, *) {

            self.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "PingFangSC-Medium", size: 24) ?? (Any).self]
            self.addSubview(imageView)
            imageView.layer.cornerRadius = Const.ImageSizeForLargeState / 2
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.center = self.center
            imageView.isUserInteractionEnabled = true
            NSLayoutConstraint.activate([
                imageView.rightAnchor.constraint(equalTo: self.rightAnchor,
                                                 constant: -Const.ImageRightMargin),
                imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                  constant: -Const.ImageBottomMarginForLargeState),
                imageView.heightAnchor.constraint(equalToConstant: Const.ImageSizeForLargeState),
                imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
                ])
            print(imageView)
        } else {
            // addrightBarbuttonitem

//            let rightBarButtonItem = UIBarButtonItem(customView: imageView)
//            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        }


    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc public func clickSearch() {
        print("custom-nav")
    }

    //UINavigationBarDelegate
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPush item: UINavigationItem) -> Bool {
        if #available(iOS 11.0, *) {
            item.largeTitleDisplayMode = .never
        }

        return true
    }

}
