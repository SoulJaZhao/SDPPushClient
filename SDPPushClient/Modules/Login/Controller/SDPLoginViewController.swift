//
//  SDPLoginViewController.swift
//  SDPPushClient
//
//  Created by SoulJa on 2017/9/13.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import SnapKit
import LocalAuthentication
import KeychainAccess

class SDPLoginViewController: SDPBaseViewController,UIAlertViewDelegate {
    /* 账户TF */
    fileprivate let tfAccount:UITextField = UITextField()
    
    /* 密码TF */
    fileprivate let tfPassword:UITextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
        
        // 设置了TouchID登陆
        if let isSetTouchID = UserDefaults.standard.value(forKey: kSDPTouchIDSupportType) as? Int {
            if (isSetTouchID == SDPTouchIDSupportType.Supported.rawValue) {
                self.navigationController?.pushViewController(SDPTouchIDViewController(), animated: false)
            } else {
                return
            }
        }
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "登录"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "注册", style: .done, target: self, action: #selector(tapRegiterBtn))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "登录", style: .done, target: self, action: #selector(tapLoginBtn))
    }
    
    //MARK:点击注册按钮
    func tapRegiterBtn() {
        self.view.endEditing(true)
        let vc = SDPRegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:点击登录按钮
    func tapLoginBtn() {
        self.view.endEditing(true)
        //账号为空
        if String.isBlank(text: tfAccount.text) {
            self.showHUD(title: "请输入账号", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        //密码为空
        if String.isBlank(text: tfPassword.text) {
            self.showHUD(title: "请输入密码", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        //发送网络请求
        self.loginService()
    }
    
    //MARK:登录的网络请求
    func loginService() {
        //url地址
        let urlString:String = "login/index"
        //参数
        let parameters = [
            "account"   :   String.trimWhiteSpace(text: tfAccount.text!),
            "password"  :   String.trimWhiteSpace(text: tfPassword.text!)
        ]
        
        self.postService(urlString: urlString, parameters: parameters, headers: nil, success: { (success) in
            guard let model = Account.deserialize(from: success.data as? NSDictionary) else {
                return
            }
            
            // 赋值给单例
            SDPAccountManager.defaultManager.account = model
            
            // 设置keychain
            self.saveKeychain(account: String.trimWhiteSpace(text: self.tfAccount.text!), password: String.trimWhiteSpace(text: self.tfPassword.text!))
            
            // 判断是否设置过指纹登录
            //设备不支持TouchID 直接登陆
            if (self.isSupportTouchID() == false) {
                self.navigationController?.dismiss(animated: true, completion: nil)
                return
            }
            //设备支持TouchID
            let isSetTouchID:Int? = UserDefaults.standard.value(forKey: kSDPTouchIDSupportType) as? Int
            
            if (isSetTouchID == nil) {
                let alertView = UIAlertView(title: "警告", message: "设置指纹登陆", delegate: self, cancelButtonTitle: "取消", otherButtonTitles: "确定")
                alertView.show()
            } else if (isSetTouchID == SDPTouchIDSupportType.NoSupported.rawValue) {
                self.dismiss(animated: true, completion: nil)
            } else {
                self.navigationController?.pushViewController(SDPTouchIDViewController(), animated: true)
            }
            
            
        }) { (failure) in
            self.showHUD(title: failure.errorMsg, afterDelay: kSDPHUDHideAfterDelay)
        }
    }
    
    //MARK:设置子视图
    func initSubviews() {
        // 账号tf
        tfAccount.isSecureTextEntry = false
        tfAccount.borderStyle = .roundedRect
        tfAccount.clearButtonMode = .whileEditing
        tfAccount.placeholder = "请输入账号"
        self.view.addSubview(tfAccount)
        tfAccount.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(kSDPPadding)
            make.leading.equalToSuperview().offset(kSDPPadding)
            make.trailing.equalToSuperview().offset(-kSDPPadding)
            make.height.equalTo(40)
        }
        
        // 密码tf
        tfPassword.isSecureTextEntry = true
        tfPassword.borderStyle = .roundedRect
        tfPassword.clearButtonMode = .whileEditing
        tfPassword.placeholder = "请输入密码"
        self.view.addSubview(tfPassword)
        tfPassword.snp.makeConstraints { (make) in
            make.top.equalTo(tfAccount.snp.bottom).offset(kSDPPadding)
            make.leading.equalTo(tfAccount.snp.leading)
            make.trailing.equalTo(tfAccount.snp.trailing)
            make.height.equalTo(40)
        }
        // 填充账号密码
        let accountInfo:(String?, String?) = self.getKeychain()
        if let account = accountInfo.0 {
            tfAccount.text = account
        }
        
        if let password = accountInfo.1 {
            tfPassword.text = password
        }
    }
    
    //MARK:判断是否支持指纹识别
    func isSupportTouchID()->Bool {
        let context:LAContext = LAContext()
        var error:NSError?
        let isSupport:Bool = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isSupport
    }
    //MARK:UIAlertViewDelegate
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        // 点击取消
        if buttonIndex == 0 {
            UserDefaults.standard.set(SDPTouchIDSupportType.NoSupported.rawValue, forKey: kSDPTouchIDSupportType)
            UserDefaults.standard.synchronize()
            self.dismiss(animated: true, completion: nil)
        }
        //点击确定
        else {
            self.navigationController?.pushViewController(SDPTouchIDViewController(), animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
