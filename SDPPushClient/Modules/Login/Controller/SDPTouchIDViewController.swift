//
//  SDPTouchIDViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import LocalAuthentication
import AVFoundation

class SDPTouchIDViewController: SDPBaseViewController {
    
    let speechSynthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer();

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "指纹登录"
        
        // 指纹识别上下文
        let context:LAContext = LAContext()
        var error:NSError?
        
        // 设备不支持指纹识别
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) == false) {
            UserDefaults.standard.set(SDPTouchIDSupportType.NoSupported.rawValue, forKey: kSDPTouchIDSupportType)
            UserDefaults.standard.synchronize()
            self.showHUD(title: "设备不支持TouchID", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
        // 支持指纹识别
        else {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "指纹登录", reply: { (isSuccess, error) in
                // 指纹识别成功
                if (isSuccess == true) {
                    // 切换到主线程
                    DispatchQueue.main.async {
                        //判断Keychain
                        guard let account = self.getKeychain().0 else {
                            self.showHUD(title: "Keychain为保存数据,请使用账号密码登陆", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                                self.navigationController?.popToRootViewController(animated: true)
                            })
                            return
                        }
                        
                        guard let password = self.getKeychain().1 else {
                            self.showHUD(title: "Keychain为保存数据,请使用账号密码登陆", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                                self.navigationController?.popToRootViewController(animated: true)
                            })
                            return
                        }
                        
                        // 登陆操作
                        self.loginService(account: account, password: password)
                    }
                }
                // 指纹识别失败
                else {
                    UserDefaults.standard.set(SDPTouchIDSupportType.NoSupported.rawValue, forKey: kSDPTouchIDSupportType)
                    UserDefaults.standard.synchronize()
                    DispatchQueue.main.async {
                        self.showHUD(title: "TouchID认证失败", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
                            self.navigationController?.popToRootViewController(animated: true)
                        })
                    }
                }
            })
        }
    }
    
    //MARK:登陆操作
    func loginService(account:String, password:String) {
        //url地址
        let urlString:String = "login/index"
        //参数
        let parameters = [
            "account"   :   account,
            "password"  :   password
        ]
        
        self.postService(urlString: urlString, parameters: parameters, headers: nil, success: { (success) in
            guard let model = Account.deserialize(from: success.data as? NSDictionary) else {
                return
            }
            
            // 赋值给单例
            SDPAccountManager.defaultManager.account = model
            
            //记录登陆状态
            UserDefaults.standard.set(SDPTouchIDSupportType.Supported.rawValue, forKey: kSDPTouchIDSupportType)
            UserDefaults.standard.synchronize()
            
            self.dismiss(animated: true, completion: { 
                self.performSelector(inBackground: #selector(self.playVoice), with: nil)
            })
            
        }) { (failure) in
            self.showHUD(title: "登陆失败，请尝试账号密码登陆", afterDelay: kSDPHUDHideAfterDelay, completeHandler: { 
                self.navigationController?.popToRootViewController(animated: true)
            })
        }
    }
    
    //MARK:播放语音
    func playVoice() {
        let str:String = "文君,文君,你造么,龙龙最可爱了"
        
        var utterance:AVSpeechUtterance
        if #available(iOS 10.0, *) {
            utterance = AVSpeechUtterance(attributedString: NSAttributedString.init(string: str))
        } else {
            // Fallback on earlier versions
            utterance = AVSpeechUtterance(string: str)
        }
        //语音类型
        let voiceType:AVSpeechSynthesisVoice = AVSpeechSynthesisVoice.init(language: "zh-CN")!
        
        utterance.voice = voiceType
        
        //设置语速
        utterance.rate = 0.4
        //设置音量
        utterance.volume = 0.8
        
        //播报语音
        speechSynthesizer.speak(utterance)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
