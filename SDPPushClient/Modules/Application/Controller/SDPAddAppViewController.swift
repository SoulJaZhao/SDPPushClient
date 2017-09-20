//
//  SDPAddAppViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/20.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

class SDPAddAppViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate, SDPTextFieldCellDelegate {
    
    /* tableView */
    var tableView:UITableView = UITableView()
    let cellId = "cellId"
    
    /* placeholder数组 */
    let placeholderArray = [
        "请输入应用名称",
        "请输入access_key_id",
        "请输入access_key_secret",
        "请输入appkey",
    ]
    
    /* cell */
    var appnameTfCell:SDPTextFieldCell = SDPTextFieldCell()
    var accessKeyIdTfCell:SDPTextFieldCell = SDPTextFieldCell()
    var accessKeySecretTfCell:SDPTextFieldCell = SDPTextFieldCell()
    var appkeyTfCell:SDPTextFieldCell = SDPTextFieldCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "添加应用"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "确定", style: .done, target: self, action: #selector(tapDone))
    }
    
    //MARK:点击确定
    func tapDone() {
        
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
        return placeholderArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier:String = String(format: "%d%d", indexPath.section,indexPath.row)
        var cell:SDPTextFieldCell!
        if let cellIdentifier:SDPTextFieldCell = tableView.dequeueReusableCell(withIdentifier: identifier) as? SDPTextFieldCell {
            cell = cellIdentifier
        } else {
            cell = SDPTextFieldCell(style: .default, reuseIdentifier: cellId)
        }

        if indexPath.section == 0 {
            cell = appnameTfCell
        } else if indexPath.section == 1 {
            cell = accessKeyIdTfCell
        } else if indexPath.section == 2 {
            cell = accessKeySecretTfCell
        } else if indexPath.section == 3 {
            cell = appkeyTfCell
        }
        
        cell.tfInput.placeholder = placeholderArray[indexPath.section]
        
        cell.delegate = self
        
        return cell
    }
    
    //MARK:SDPTextFieldCellDelegate
    func textFieldCellEndEdit(textFieldCell: SDPTextFieldCell, text: String) {
        if textFieldCell == appnameTfCell {
            appnameTfCell.tfInput.text = text
        } else if textFieldCell == accessKeyIdTfCell {
            accessKeyIdTfCell.tfInput.text = text
        } else if textFieldCell == accessKeySecretTfCell {
            accessKeySecretTfCell.tfInput.text = text
        } else if textFieldCell == appkeyTfCell {
            appkeyTfCell.tfInput.text = text
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
