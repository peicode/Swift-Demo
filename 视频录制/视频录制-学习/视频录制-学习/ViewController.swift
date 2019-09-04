//
//  ViewController.swift
//  视频录制-学习
//
//  Created by 廖佩志 on 2019/2/25.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import ReplayKit

class ViewController: UIViewController, RPPreviewViewControllerDelegate, ViewRecordDelegate {

    @IBOutlet weak var iconView: UIImageView!
    var vr: VideoRecord?
    var index = 1
    @IBAction func nextClick(_ sender: UIButton) {
        if index<3 {
            index += 1
        } else {
            index = 1
        }
        let imageName = "icon\(index)"
        iconView.image = UIImage(named: imageName)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        vr = VideoRecord(view: iconView)
        vr?.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func startRecord(_ sender: UIButton) {
        if !sender.isSelected {
            sender.isSelected = true
            vr?.config()
            vr?.startRecord()
        } else {
            sender.isSelected = false
            vr?.stopRecord()

        }
    }
    func recordFinished(url: URL) {
        let item = AVPlayerItem(url: url)
        let player = AVPlayer(playerItem: item)
        let layer = AVPlayerLayer(player: player)
        layer.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        view.layer.addSublayer(layer)
        player.play()
    }

    // MARK: RPPreviewViewControllerDelegate
    func previewControllerDidFinish(_ previewController: RPPreviewViewController) {

    }

    func previewController(_ previewController: RPPreviewViewController, didFinishWithActivityTypes activityTypes: Set<String>) {
        previewController.dismiss(animated: true, completion: nil)
    }
}

