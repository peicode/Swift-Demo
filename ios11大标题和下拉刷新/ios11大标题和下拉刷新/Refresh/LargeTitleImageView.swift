//
//  LargeTitleImageView.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/10/30.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
struct NavigationConst {
    /// NavigationBarHeight
    static let NavBarHeightSmallState: CGFloat = 44
    static let NavBarHeightLargeState: CGFloat = 96.0
    /// imageHeight
    static let ImageSizeForSmallState: CGFloat = 24
    static let ImageSizeForLargeState: CGFloat = 30
    /// imageMarginBottom
    static let ImageBottomMarginForSmallState: CGFloat = 13
    static let ImageBottomMarginForLargeState: CGFloat = 12

    static let ImageRightMargin: CGFloat = 16

}

public protocol LargeTitleImageViewDelegate: class {
    func clickLargeImageView()
}

public class LargeTitleImageView: UIImageView {

    weak public var delegate: LargeTitleImageViewDelegate?

    override public init(image: UIImage?) {
        super.init(image: image)
        let tap = UITapGestureRecognizer(target: self, action: #selector(clickImageView))
        self.bounds.size = CGSize(width: 30, height: 30)
        layer.cornerRadius = NavigationConst.ImageSizeForLargeState / 2
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        isUserInteractionEnabled = true
        addGestureRecognizer(tap)
    }

    @objc func clickImageView() {
        delegate?.clickLargeImageView()
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func moveAndResizeImageForPortrait(navHeight: CGFloat) {
        let coeff: CGFloat = {
            let delta = navHeight - NavigationConst.NavBarHeightSmallState
            let heightDifferenceBetweenStates = (NavigationConst.NavBarHeightLargeState - NavigationConst.NavBarHeightSmallState)
            return delta / heightDifferenceBetweenStates
        }()

        let factor = NavigationConst.ImageSizeForSmallState / NavigationConst.ImageSizeForLargeState

        let scale: CGFloat = {
            let sizeAddendumFactor = coeff * (1.0 - factor)
            return min(1.0, sizeAddendumFactor + factor)
        }()

        // Value of difference between icons for large and small states
        let sizeDiff = NavigationConst.ImageSizeForLargeState * (1.0 - factor) // 8.0

        let yTranslation: CGFloat = {
            /// This value = 14. It equals to difference of 12 and 6 (bottom margin for large and small states). Also it adds 8.0 (size difference when the image gets smaller size)
            let maxYTranslation = NavigationConst.ImageBottomMarginForLargeState - NavigationConst.ImageBottomMarginForSmallState + sizeDiff
            return max(0, min(maxYTranslation, (maxYTranslation - coeff * (NavigationConst.ImageBottomMarginForSmallState + sizeDiff))))
        }()

        let xTranslation = max(0, sizeDiff - coeff * sizeDiff)

        self.transform = CGAffineTransform.identity
            .scaledBy(x: scale, y: scale)
            .translatedBy(x: xTranslation, y: yTranslation)
    }

    public func layoutLargeTitleImage(navigationBar: UINavigationBar) {
        NSLayoutConstraint.activate([
            self.rightAnchor.constraint(equalTo: navigationBar.rightAnchor,
                                             constant: -NavigationConst.ImageRightMargin),
            self.bottomAnchor.constraint(equalTo: navigationBar.bottomAnchor,
                                              constant: -NavigationConst.ImageBottomMarginForLargeState),
            self.heightAnchor.constraint(equalToConstant: NavigationConst.ImageSizeForLargeState),
            self.widthAnchor.constraint(equalTo: self.heightAnchor)
            ])
    }

    public func show(_ bool: Bool) {
        UIView.animate(withDuration: 0.1) {
            self.alpha = bool ? 1.0 : 0
        }
    }
}
