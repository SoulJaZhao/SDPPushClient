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

class SDPLoginViewController: SDPBaseViewController {
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
            
            // 判断是否设置过指纹登录
            guard let isSetTouchID = UserDefaults.standard.object(forKey: kSDPTouchIDSupportType) else {
                if (self.isSupportTouchID() == false) {
                    self.navigationController?.dismiss(animated: true, completion: nil)
                } else {
                    self.navigationController?.pushViewController(SDPTouchIDViewController(), animated: true)
                }
                return
            }
            //TODO:优化指纹登录的思路
            
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
    }
    
    //MARK:判断是否支持指纹识别
    func isSupportTouchID()->Bool {
        let context:LAContext = LAContext()
        var error:NSError?
        let isSupport:Bool = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        return isSupport
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
