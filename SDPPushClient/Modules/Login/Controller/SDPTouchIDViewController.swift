//
//  SDPTouchIDViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import LocalAuthentication

class SDPTouchIDViewController: SDPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "指纹登录"
        
        // 指纹识别上下文
        let context:LAContext = LAContext()
        var error:NSError?
        
        // 支持指纹识别
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) == true) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "指纹登录", reply: { (isSuccess, error) in
                if (isSuccess == true) {
                    print("认证成功")
                } else {
                    DispatchQueue.main.async {
                        self.showHUD(title: "TouchID认证失败", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                    }
                }
            })
        }
        // 不支持指纹识别
        else {
            self.showHUD(title: "设备不支持TouchID", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
