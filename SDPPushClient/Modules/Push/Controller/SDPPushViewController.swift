//
//  SDPPushViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/21.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

class SDPPushViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate {

    /* 上一步的配置 */
    var config:SDPPushConfig?
    
    /* tableView */
    var tableView:UITableView = UITableView()
    
    /* placeholder数组 */
    let placeholderArray = [
        "请输入角标",
        "请输入静默通知标识",
        "请输入APNS环境"
    ]
    
    /* cell */
    var badgeCell:SDPTextFieldCell = SDPTextFieldCell()
    var silentCell:SDPTextFieldCell = SDPTextFieldCell()
    var apnsCell:SDPTextFieldCell = SDPTextFieldCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "推送"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(tapDone))
    }
    
    //MARK:点击确定按钮
    func tapDone() {
        // 获取参数
        guard let userId:Int = SDPAccountManager.defaultManager.account?.accountId else {
            return
        }
        
        guard let accessToken:String = SDPAccountManager.defaultManager.account?.accessToken else {
            return
        }
        
        guard let pushConfig:SDPPushConfig = config else {
            return
        }
        
        let appId:Int = pushConfig.appId
        
        let target:String = pushConfig.target
        
        let targetValue:String = pushConfig.targetValue
        
        let deviceType:String = pushConfig.deviceType
        
        let pushType:String = pushConfig.pushType
        
        let title:String = pushConfig.title
        
        let body:String = pushConfig.body
        
        let badge:String = badgeCell.tfInput.text!
        
        let silent:String = silentCell.tfInput.text!
        
        let apns:String = apnsCell.tfInput.text!
        
        if String.isNumberic(text: badge) {
            self.showHUD(title: "角标只能为数字", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        
    }
    
    //MARK:设置子视图
    func initSubviews() {
        tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
     //MARK:UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = String.init(format: "%d%d", indexPath.section, indexPath.row)
        
        var textFieldCell:SDPTextFieldCell
        
        if let cell:SDPTextFieldCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SDPTextFieldCell {
            textFieldCell = cell
        } else {
            textFieldCell = SDPTextFieldCell(style: .default, reuseIdentifier: identifier)
        }
        
        if (indexPath.section == 0) {
            badgeCell = textFieldCell
            badgeCell.tfInput.keyboardType = .numberPad
        }
        else if (indexPath.section == 1) {
            silentCell = textFieldCell
            silentCell.tfInput.text = "true"
        }
        else if (indexPath.section == 2) {
            apnsCell = textFieldCell
            apnsCell.tfInput.text = "DEV"
        }
        
        textFieldCell.tfInput.placeholder = placeholderArray[indexPath.section]
        
        return textFieldCell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
