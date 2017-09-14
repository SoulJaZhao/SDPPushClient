//
//  SDPLoginViewController.swift
//  SDPPushClient
//
//  Created by SoulJa on 2017/9/13.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import SnapKit

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
        if String.isBlank(text: tfAccount.text) {
            self.showHUD(title: "请输入密码", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        //发送网络请求
        
    }
    
    //MARK:登录的网络请求
    func loginService() {
        //url地址
        let urlString:String = "login"
        
        SDPHttpsClient.POST(urlString: urlString, parameteters: nil, headers: nil, success: { (success) in
            
        }) { (failture) in
            
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
}
