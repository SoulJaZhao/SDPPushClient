//
//  SDPSettingViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//  设置

import UIKit

class SDPSettingViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "设置"
    }
    
    //MARK:设置子视图
    func initSubviews() {
        let tableView = UITableView(frame: self.view.bounds, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        self.view.addSubview(tableView)
    }
    
    //MARK:UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let kCellId = "cellId"
        
        var cell:UITableViewCell
        
        if let tempCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: kCellId) {
            cell = tempCell
        } else {
            cell = UITableViewCell(style: .default, reuseIdentifier: kCellId)
        }
        
        cell.textLabel?.text = "退出登录"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            
            self.tabBarController?.selectedIndex = 0
            
            UserDefaults.standard.removeObject(forKey: kSDPTouchIDSupportType)
            
            let loginVC = SDPLoginViewController()
            let nav:SDPNavigationController = SDPNavigationController(rootViewController: loginVC)
            self.present(nav, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
