//
//  SDPPushConfigViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/21.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import HandyJSON

class SDPPushConfigViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate {
    /* APP信息 */
    var app:SDPApp = SDPApp()
    
    /* tableView */
    var tableView:UITableView = UITableView()
    
    /* placeholder数组 */
    let placeholderArray = [
        "请输入推送目标",
        "请输入目标值",
        "请输入设备类型",
        "请输入消息类型",
        "请输入消息的标题",
        "请输入消息的内容"
        ]
    
    /* cell */
    var targetCell:SDPTextFieldCell = SDPTextFieldCell()
    var targetValueCell:SDPTextFieldCell = SDPTextFieldCell()
    var deviceTypeCell:SDPTextFieldCell = SDPTextFieldCell()
    var pushTypeCell:SDPTextFieldCell = SDPTextFieldCell()
    var bodyCell:SDPTextFieldCell = SDPTextFieldCell()
    var titleCell:SDPTextFieldCell = SDPTextFieldCell()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "推送设置"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "下一步", style: .done, target: self, action: #selector(tapNextStep))
    }
    
    //MARK:点击下一步
    func tapNextStep() {
        self.view.endEditing(true)
        
        // 参数校验
        let target:String = targetCell.tfInput.text!
        let targetValue:String = targetValueCell.tfInput.text!
        let pushType:String = pushTypeCell.tfInput.text!
        let deviceType:String = deviceTypeCell.tfInput.text!
        let title:String = titleCell.tfInput.text!
        let body:String = bodyCell.tfInput.text!
        
        if String.isBlank(text: target) {
            self.showHUD(title: "请输入推送目标", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        if String.isBlank(text: targetValue) {
            self.showHUD(title: "请输入目标值", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        if String.isBlank(text: deviceType) {
            self.showHUD(title: "请输入设备类型", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        if String.isBlank(text: pushType) {
            self.showHUD(title: "请输入推送类型", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        if String.isBlank(text: title) {
            self.showHUD(title: "请输入推送标题", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        if String.isBlank(text: body) {
            self.showHUD(title: "请输入推送内容", afterDelay: kSDPHUDHideAfterDelay)
            return
        }
        
        let configDict = [
            "appId"         :           app.id,
            "target"        :           target,
            "targetValue"   :           targetValue,
            "deviceType"    :           deviceType,
            "pushType"      :           pushType,
            "title"         :           title,
            "body"          :           body
        ] as [String : Any]
        
        guard let config:SDPPushConfig = SDPPushConfig.deserialize(from: configDict as NSDictionary) else {
            return
        }
        
        let vc = SDPPushViewController()
        vc.config = config
        self.navigationController?.pushViewController(vc, animated: true)
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
        return 6
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
            targetCell = textFieldCell
            targetCell.tfInput.text = "ACCOUNT"
        } else if (indexPath.section == 1) {
            targetValueCell = textFieldCell
            targetValueCell.tfInput.text = "AA002761"
        } else if (indexPath.section == 2) {
            deviceTypeCell = textFieldCell
            deviceTypeCell.tfInput.text = "iOS"
        } else if (indexPath.section == 3) {
            pushTypeCell = textFieldCell
            pushTypeCell.tfInput.text = "NOTICE"
        } else if (indexPath.section == 4) {
            titleCell = textFieldCell
        } else if (indexPath.section == 5) {
            bodyCell = textFieldCell
        }
        
        textFieldCell.tfInput.placeholder = placeholderArray[indexPath.section]
        
        return textFieldCell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
