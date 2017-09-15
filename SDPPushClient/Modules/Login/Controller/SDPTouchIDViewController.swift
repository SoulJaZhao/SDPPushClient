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
        
        // 支持指纹识别
        if (context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) == true) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "指纹登录", reply: { (isSuccess, error) in
                if (isSuccess == true) {
                    UserDefaults.standard.set(SDPTouchIDSupportType.Supported.rawValue, forKey: kSDPTouchIDSupportType)
                    UserDefaults.standard.synchronize()
                    self.dismiss(animated: true, completion: {
                        self.performSelector(inBackground: #selector(self.playVoice), with: nil)
                    })
                } else {
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
        // 不支持指纹识别
        else {
            UserDefaults.standard.set(SDPTouchIDSupportType.NoSupported.rawValue, forKey: kSDPTouchIDSupportType)
            UserDefaults.standard.synchronize()
            self.showHUD(title: "设备不支持TouchID", afterDelay: kSDPHUDHideAfterDelay, completeHandler: {
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
