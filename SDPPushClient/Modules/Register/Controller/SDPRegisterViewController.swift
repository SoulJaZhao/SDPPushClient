//
//  SDPRegisterViewController.swift
//  SDPPushClient
//
//  Created by SoulJa on 2017/9/14.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

class SDPRegisterViewController: SDPBaseViewController {
    /* 账号 */
    let tfAccount:UITextField = UITextField()
    /* 密码 */
    let tfPassword:UITextField = UITextField()
    /* 确认密码 */
    let tfRePassword:UITextField = UITextField()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "注册"

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(tapDoneBtn))
    }
    
    //MARK:点击确认按钮
    func tapDoneBtn() {
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
        
        // 重复密码为空
        if String.isBlank(text: tfRePassword.text) {
            self.showHUD(title: "请输入密码", afterDelay: kSDPHUDHideAfterDelay)
            return
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
        
        // 确认密码tf
        tfRePassword.isSecureTextEntry = true
        tfRePassword.borderStyle = .roundedRect
        tfRePassword.clearButtonMode = .whileEditing
        tfRePassword.placeholder = "请输入密码"
        self.view.addSubview(tfRePassword)
        tfRePassword.snp.makeConstraints { (make) in
            make.top.equalTo(tfPassword.snp.bottom).offset(kSDPPadding)
            make.leading.equalTo(tfAccount.snp.leading)
            make.trailing.equalTo(tfAccount.snp.trailing)
            make.height.equalTo(40)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
