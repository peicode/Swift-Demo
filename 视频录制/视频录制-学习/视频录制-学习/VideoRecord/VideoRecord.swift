//
//  VideoRecord.swift
//  视频录制-学习
//
//  Created by 廖佩志 on 2019/2/25.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import AVFoundation

protocol ViewRecordDelegate: NSObjectProtocol {
    func recordFinished(url: URL)
}
class VideoRecord: NSObject, AVCaptureFileOutputRecordingDelegate {
    var session: AVCaptureSession?
    var previewLayer: AVCaptureVideoPreviewLayer?
    var cameraInput: AVCaptureDevice?
    var videoInput: AVCaptureDeviceInput?
    var audioInput: AVCaptureDeviceInput?
    var fileOutput: AVCaptureMovieFileOutput?
    var vedioPath: String?
    var vedioUrl: URL?
    var currentView: UIView?
    var directoryPath: String = "\(NSTemporaryDirectory())Video"
    weak var delegate: ViewRecordDelegate?

    init(view: UIView) {
        super.init()
        currentView = view
        config()
    }

    func config() {
        setupVideo()
    }
    // 设置视频
    func setupVideo() {

        //初始化，并且设置比特率（bitrate）
        session = AVCaptureSession()
        if (session?.canSetSessionPreset(.hd1920x1080)) ?? false {
            session?.sessionPreset = .hd1920x1080
        }
        //vedio
        //
//        let allDevices = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInMicrophone, .builtInDualCamera], mediaType: .video, position: .back)
//        AVCaptureDevice.DiscoverySession(deviceTypes: <#T##[AVCaptureDevice.DeviceType]#>, mediaType: <#T##AVMediaType?#>, position: <#T##AVCaptureDevice.Position#>)
//        for d in allDevices.devices {
//            if d.hasMediaType(.video) {
//                videoInput = try? AVCaptureDeviceInput(device: d)
//            } else if d.hasMediaType(.audio) {
//                audioInput = try? AVCaptureDeviceInput(device: d)
//            }
//        }



        var vdevice: AVCaptureDevice?
//        let vdevice1 =  AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInDualCamera, for: .video, position: .front)
        let cameras = AVCaptureDevice.devices(for: .video)
        for camera in cameras {
            if camera.position == .front {
                vdevice = camera

                break
            }
        }
        //只支持后置摄像头
        if vdevice?.isAutoFocusRangeRestrictionSupported ?? false{
            vdevice?.setValue(1, forKey: "FocusMode")
        }

        videoInput = try? AVCaptureDeviceInput(device: vdevice!)



//        vedioDevice?.videoZoomFactor
//        vedioDevice?.activeVideoMinFrameDuration = CMTime(value: 1, timescale: 60)

        if session?.canAddInput(videoInput!) ?? false {
            session?.addInput(videoInput!)
        }

        //audio
        let device = AVCaptureDevice.default(AVCaptureDevice.DeviceType.builtInMicrophone, for: .audio, position: .unspecified)

        audioInput = try? AVCaptureDeviceInput(device: device!)

        if session?.canAddInput(audioInput!) ?? false {
            session?.addInput(audioInput!)
        }

        //
        fileOutput = AVCaptureMovieFileOutput()

        let connect = fileOutput?.connection(with: .video)

        //设置防抖
        if connect?.isVideoStabilizationSupported ?? false {
            connect?.preferredVideoStabilizationMode = .auto
        }
        //预览图层和视频图层方向一致
        connect?.videoOrientation = previewLayer?.connection?.videoOrientation ?? AVCaptureVideoOrientation.portrait
        //
        if session?.canAddOutput(fileOutput!) ?? false {
            session?.addOutput(fileOutput!)
        }
        //采集区
        previewLayer = AVCaptureVideoPreviewLayer(session: session!)
//        previewLayer?.videoGravity = .resizeAspect
//        previewLayer?.frame = (currentView?.bounds)!
        previewLayer?.frame = CGRect(x: 0, y: 0, width: 300, height: 400)
//        print(previewLayer?.frame)
//        print(currentView?.frame)
        currentView?.layer.addSublayer(previewLayer!)
        //
        session?.startRunning()

    }

    func startRecord() {
        let path = getFilePath()

        vedioUrl = URL(fileURLWithPath: path)
        print(vedioUrl!)
        fileOutput?.startRecording(to: vedioUrl!, recordingDelegate: self)

    }
    func getFilePath() -> String {
        let tempFileDirectory = directoryPath
        if !FileManager.default.fileExists(atPath: tempFileDirectory) {
            try? FileManager.default.createDirectory(atPath: tempFileDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        let fileName = "final\(UUID().uuidString).mp4"
        let filePath = "\(tempFileDirectory)/\(fileName)"

        if FileManager.default.fileExists(atPath: filePath) {
            do {
                try FileManager.default.removeItem(atPath: filePath)
                print("删除成功！")
            }
            catch {
                print("删除失败\(error)")
            }

        }

        return filePath
    }
    func stopRecord() {
        fileOutput?.stopRecording()
        session?.stopRunning()
        print("stopRecord")
    }
    //hasCameraAccess
    func hasCameraAccess() -> Bool {
        let state = AVCaptureDevice.authorizationStatus(for: .video)
        switch state {
        case .authorized:
            return true
        case .notDetermined:
            return false
        default:
            return false
        }
    }
    //
    func fileOutput(_ output: AVCaptureFileOutput, didFinishRecordingTo outputFileURL: URL, from connections: [AVCaptureConnection], error: Error?) {

        if (error != nil) {
            print("finsh--error:\(error!)")
        }
        print("finsh-----\(outputFileURL)")
        delegate?.recordFinished(url: outputFileURL)

        
    }


    //AVAssetWriter
    func useAVAssetWriter() {

    }
}


