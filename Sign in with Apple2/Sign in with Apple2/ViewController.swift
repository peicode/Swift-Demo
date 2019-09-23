//
//  ViewController.swift
//  Sign in with Apple2
//
//  Created by 廖佩志 on 2019/11/5.
//  Copyright © 2019 廖佩志. All rights reserved.
//

import UIKit
import AuthenticationServices

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        //添加通知监听变化
        NotificationCenter.default.addObserver(self, selector: #selector(handleStateChange(noti:)), name: ASAuthorizationAppleIDProvider.credentialRevokedNotification, object: nil)

        //setupUI
        let stackView = UIStackView()
        stackView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.axis = .vertical
        view.addSubview(stackView)
        //各种sign in with apple 样式
        let signButton = ASAuthorizationAppleIDButton(type: .default, style: .whiteOutline)
        signButton.addTarget(self, action: #selector(handleAuthorizationAppleIDButtonPress), for: .touchUpInside)
        stackView.addArrangedSubview(signButton)
        //sign in
        let signButton2 = ASAuthorizationAppleIDButton(type: .signIn, style: .black)
        stackView.addArrangedSubview(signButton2)
        //countinue
        let signButton4 = ASAuthorizationAppleIDButton(type: .continue, style: .black)
        stackView.addArrangedSubview(signButton4)
        //iOS 13.2 sign up
        if #available(iOS 13.2, *) {
            let signButton3 = ASAuthorizationAppleIDButton(type: .signUp, style: .black)
            stackView.addArrangedSubview(signButton3)
        } else {}

        stackView.frame = CGRect(x: 0, y: 0, width: 300, height: 74 * (stackView.arrangedSubviews.count - 1) + 64)
        stackView.center = view.center
    }

    @objc func handleAuthorizationAppleIDButtonPress() {
        let provider = ASAuthorizationAppleIDProvider()
        let request = provider.createRequest()
        request.requestedScopes = [.fullName, .email]

        let controller = ASAuthorizationController.init(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }

    @objc func handleStateChange(noti: Any) {
        print("💔AppleID 授权失败")
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    @IBAction func changeBGColor(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            view.backgroundColor = .white
        default:
            view.backgroundColor = .black
        }

    }
    
}

extension ViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    //告诉代理应该在哪个window显示内容给用户
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    //MARK: - ASAuthorizationControllerPresentationContextProviding
    //授权成功
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        print("💛授权成功：\(authorization)")
        let creadential = authorization.credential
        //        <ASAuthorizationAppleIDCredential: 0x2809d32a0 { userIdentifier: 001882.8f7859ab95a34fc1858c9e7f985de2b2.0631, authorizedScopes: (
        //        ) }>
        print(creadential)

        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {
            return
        }


        print("💪appleIDCredential: \(appleIDCredential)")
    //只要用户与发出请求的客户端连接，标识符就将保持稳定。用户断开身份提供者的连接后，该值可能会更改。
        let userID = appleIDCredential.user
        print("📱userID: \(userID)")

        let fullName = appleIDCredential.fullName
        print("👉fullName: \(String(describing: fullName))")

        let email = appleIDCredential.email
        print("📠email: \(email ?? "无")")
        //传给服务端的token，用于后台向苹果验证
        let token = appleIDCredential.identityToken


        let ztoken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
        let arr = ztoken!.components(separatedBy: ".")
        let header = arr[0]
        let payload = arr[1]
        print("👨‍💻‍token: \(String(describing: token))----ztoken:\(ztoken!)----header: \(header)----payload:\(payload)")

        let headerData = NSData(base64Encoded: header)
        let headerData1 = Data(base64Encoded: header)
        let decodeHeader = String(data: headerData! as Data, encoding: .utf8)

//        let payloadData = NSData(base64Encoded: payload)
        let payloadData = Data(base64Encoded: payload)
        let decodePayload = String(data: payloadData! as Data  , encoding: .utf8)

        print("✨decodeHeader: \(decodeHeader);decodePayload:\(decodePayload)")


        //authorizationCodeString 给后台向苹果服务器验证使用 这个有时效性 五分钟之内有效
        let code = appleIDCredential.authorizationCode
        print("code: \(String(describing: code))")
        //用户状态，分为三种
        let status = appleIDCredential.realUserStatus.rawValue
        print("🙂userStatus: \(status)")

    }

    //授权失败
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("💙授权失败:\(error.localizedDescription)")
    }

}
