//
//  SDPPushListViewController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import HandyJSON

class SDPPushListViewController: SDPBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    /* tableView */
    var tableView:UITableView = UITableView()
    /* Model */
    var pushListData:[SDPPushRecord]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 请求推送数据
        self.serviceRequestPushRecords()
    }
    //MARK:请求推送数据
    func serviceRequestPushRecords() {
        // 请求地址
        let urlString:String = "push/getRecords"
        
        guard let accessToken = SDPAccountManager.defaultManager.account?.accessToken else {
            return
        }
        
        //请求参数
        let parameters = [
            "accessToken"   :       accessToken,
            ] as [String : Any]
        
        self.postService(urlString: urlString, parameters: parameters, headers: nil, success: { (success) in
            guard let pushList:SDPPushList = SDPPushList.deserialize(from: success.data as? NSDictionary) else {
                return
            }
            self.pushListData = pushList.pushList
            self.tableView.reloadData()
        }) { (failure) in
            self.showHUD(title: failure.errorMsg, afterDelay: kSDPHUDHideAfterDelay)
        }
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "推送记录"
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
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let push = self.pushListData {
            return push.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "cellId"
        
        var cell:UITableViewCell
        
        if let tempCell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier) {
            cell = tempCell
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: identifier)
        }
        
        let model:SDPPushRecord = self.pushListData![indexPath.row]
        
        cell.textLabel?.text = model.appname
        cell.detailTextLabel?.text = model.title
        
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
