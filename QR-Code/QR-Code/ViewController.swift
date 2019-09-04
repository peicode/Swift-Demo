//
//  ViewController.swift
//  QR-Code
//
//  Created by 廖佩志 on 2019/5/13.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import CoreImage
import CoreGraphics
import QuartzCore


class ViewController: UIViewController {
    let imageV = UIImageView()
    let filter = CIFilter(name: "CIQRCodeGenerator")
    override func viewDidLoad() {
        super.viewDidLoad()
        imageV.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageV.center = view.center
        view.addSubview(imageV)

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        imageV.image = creatQRCode()
    }
    func creatQRCode() -> UIImage{
//        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setDefaults()
        let str = "https://peicode.github.io"
        let data = str.data(using: .utf8)
        filter?.setValue(data, forKey: "inputMessage")

        let outputImage = filter?.outputImage
        return createHDUIImage(ciImage: outputImage!, size: 200)
    }
    /// 创建高清图片
    func createHDUIImage(ciImage: CIImage, size: CGFloat) -> UIImage{
        let extent = ciImage.extent.integral
        let scale = min(size/extent.width, size/extent.height)

        let width = extent.width * scale
        let height = extent.height * scale
        let cs = CGColorSpaceCreateDeviceGray()
        let bitmapRef = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: cs, bitmapInfo: CGImageAlphaInfo.none.rawValue)
        let context = CIContext(options: nil)
        let bitmapImage = context.createCGImage(ciImage, from: extent)
//        CGInterpolationQuality(rawValue: CGImageAlphaInfo.none)
        bitmapRef?.interpolationQuality = CGInterpolationQuality.none
        bitmapRef?.scaleBy(x: scale, y: scale)
        bitmapRef?.draw(bitmapImage!, in: extent)

        let scaleImage = bitmapRef?.makeImage()


        return UIImage(cgImage: scaleImage!)
    }
}

