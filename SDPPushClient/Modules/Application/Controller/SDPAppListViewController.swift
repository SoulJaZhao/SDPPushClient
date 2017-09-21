//
//  SDPAppListViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

class SDPAppListViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    /* tableView */
    var tableView:UITableView = UITableView()
    let cellId = "cellId"
    
    /* APP应用数据 */
    var appListData:[SDPApp]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 获取app列表信息
        self.getAppListService()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "应用列表"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加应用", style: .done, target: self, action: #selector(tapAddApp))
    }
    
    //MARK:点击添加应用
    func tapAddApp() {
        let vc = SDPAddAppViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:设置子视图
    func initSubviews() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        self.view.addSubview(tableView)
    }
    
    //MARK:获取app列表信息
    func getAppListService() {
        let urlString:String = "app/index"
        
        guard let accessToken:String = SDPAccountManager.defaultManager.account?.accessToken else {
            return
        }
        
        let parameters = [
            "accessToken"   :   accessToken
        ]
        
        self.postService(urlString: urlString, parameters: parameters, headers: nil, success: { (success) in
            guard let appList:SDPAppList = SDPAppList.deserialize(from: success.data as? NSDictionary) else {
                return
            }
            self.appListData = appList.appList
            self.tableView.reloadData()
            
        }) { (failure) in
            self.showHUD(title: failure.errorMsg, afterDelay: kSDPHUDHideAfterDelay)
        }
    }
    
    //MARK:UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let list = appListData else {
            return 0
        }
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        let app:SDPApp = appListData![indexPath.row]
        cell.textLabel?.text = app.appname
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let app:SDPApp = appListData?[indexPath.row] else {
            return
        }
        
        let vc = SDPPushConfigViewController()
        vc.app = app
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
