//
//  GradientButton.swift
//  Swift渐变色实践
//
//  Created by 廖佩志 on 2019/9/4.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit

class GradientButton: UIButton {

    func gradient(colors: [CGColor], type: CAGradientLayerType?) -> CAGradientLayer {
        let graLayer = CAGradientLayer()

        graLayer.colors = colors
        graLayer.startPoint = CGPoint(x: 0, y: 0)
        graLayer.endPoint = CGPoint(x: self.bounds.width, y: bounds.height)
        return graLayer
    }

    func gradientLayer(colors: [CGColor], type: CAGradientLayerType?) {
        let graLayer = CAGradientLayer()
        graLayer.frame = self.bounds
        graLayer.colors = colors
        graLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        graLayer.type = type ?? CAGradientLayerType.axial
        self.layer.addSublayer(graLayer)
    }

}
