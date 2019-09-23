//
//  IndicatorAnimationView.swift
//  ios11大标题和下拉刷新
//
//  Created by 廖佩志 on 2019/9/6.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import CoreGraphics

class IndicatorAnimationView: UIView {

    override func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.addLine(to: CGPoint(x: 0,y: 0))
    }
}
