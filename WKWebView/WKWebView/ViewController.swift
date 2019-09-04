//
//  ViewController.swift
//  WKWebView
//
//  Created by 廖佩志 on 2019/4/8.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate {
    var wkWebView: WKWebView?
    var imageVC: UIImagePickerController?
    override func viewDidLoad() {
        super.viewDidLoad()
        let config = WKWebViewConfiguration()
        wkWebView = WKWebView(frame: view.frame, configuration: config)
//        let request = URLRequest(url: URL(string: "https://m.benlai.com/huanan/zt/1231cherry")!)
//        wkWebView?.load(request)
        let filePath = Bundle.main.path(forResource: "index", ofType: "html")
        let htmlString = try! String(contentsOfFile: filePath!, encoding: .utf8)
        wkWebView?.loadHTMLString(htmlString, baseURL: nil)

        view.addSubview(wkWebView!)
        wkWebView?.navigationDelegate = self
        wkWebView?.uiDelegate = self

        let userCC = config.userContentController
        userCC.add(self, name: "nativeMethod")
//        userCC.addUserScript(WKUserScript)


        ////
        let btn = UIButton(frame: CGRect(x: 150, y: 600, width: 100, height: 40))
        btn.setTitle("哈哈哈", for: .normal)
        btn.backgroundColor = .black
        wkWebView?.addSubview(btn)
    }
    // 在页面加载完成时，注入JS代码,要不然还没加载完时就可以点击了,就不能调用我们的代码了!
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        let path = Bundle.main.path(forResource: "data.txt", ofType: nil)
        let str = try? String(contentsOfFile: path!, encoding: .utf8)
        //iOS调用js的方法，response代表回传的数据
        wkWebView?.evaluateJavaScript(str ?? "", completionHandler: { (response, error) in
//            print(response, error)
        })
    }
    //log(&quot;product&quot;, &quot;initcarturl_oversea&quot;, &quot;4343838&quot;)
    // 接收JS端发过来的消息，并处理相应的业务逻辑，此处不加入购物车，直接弹出产品ID即可
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "nativeMethod" {
            switch message.body as! String
            {
            case "拍照":
                print("打开相机")
                show(message: "打开相机")
//                openCamera()
            case "相册":
                openAlbum()
            case "图片浏览器":
                show(message: "打开图片浏览器")
            default:
                print("未知操作")
                show(message: "未知操作")
            }
        }
    }
    //此方法作为js的alert方法接口的实现，默认弹出窗口应该只有提示信息及一个确认按钮，当然可以添加更多按钮以及其他内容，但是并不会起到什么作用
    //点击确认按钮的相应事件需要执行completionHandler，这样js才能继续执行
    ////参数 message为  js 方法 alert(<message>) 中的<message>
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        completionHandler()
        show(message: message)

    }
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        completionHandler(true)
        show(message: message)
    }
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        completionHandler("")
        show(message: defaultText ?? "")
    }
    
    /// alert
    func show(message: String) {
        let alertVC = UIAlertController(title: "功能描述", message: message, preferredStyle: .alert)
        let sure = UIAlertAction(title: "确认", style: .cancel, handler: nil)
        alertVC.addAction(sure)
        self.present(alertVC, animated: true, completion: nil)
    }

    ///打开相机
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imageVC = UIImagePickerController()
            imageVC?.sourceType = .camera
            imageVC?.delegate = self
            self.present(imageVC!, animated: true, completion: nil)
        }
    }
    ///打开相册
    func openAlbum() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            imageVC = UIImagePickerController()
            imageVC?.sourceType = .photoLibrary
            imageVC?.delegate = self
            self.present(imageVC!, animated: true, completion: nil)
        }
    }
    deinit {
        wkWebView?.configuration.userContentController.removeScriptMessageHandler(forName: "nativeMethod")
    }
}
// ViewController必须实现 UIImagePickerControllerDelegate & UINavigationControllerDelegate
extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print(info)
        let type = info[.mediaType]

//        switch type {
//        case UIImagePickerController.InfoKey.imageURL :
//            <#code#>
//        default:
//            <#code#>
//        }
//        wkWebView?.loadFileURL(imageUrl as! URL, allowingReadAccessTo: imageUrl as! URL)
//let imageString = String()
//        NSData(contentsOfFile: )
//        wkWebView?.load(Data, mimeType: <#T##String#>, characterEncodingName: <#T##String#>, baseURL: <#T##URL#>)
//        self.wkWebView?.load(image, mimeType: .image, characterEncodingName: <#T##String#>, baseURL: <#T##URL#>)
        self.dismiss(animated: true, completion: {
            //拿到图片，其实需要根据info[.mediaType]来判断资源是什么类型，这里已知是图片

//            let image = info[.originalImage] as? UIImage
            let imageUrl = info[.imageURL] as! URL

            //imgStr    String    "file:///Users/liaopeizhi/Library/Developer/CoreSimulator/Devices/1A5C7CAD-DD5C-443A-B5F9-12DB810905A4/data/Containers/Data/Application/A4AE7FD3-CB92-46F1-8613-947F1BC86201/tmp/C89B33BD-FB2A-4CB1-9E72-0EFBF245D6BB.jpeg"    
//            let imgStr = imageUrl.absoluteString
//            let script = "loadImage('\(imageUrl)')"
            self.wkWebView?.loadFileURL(imageUrl, allowingReadAccessTo: imageUrl)
//            self.wkWebView?.evaluateJavaScript(script, completionHandler: nil)
        })
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
}

