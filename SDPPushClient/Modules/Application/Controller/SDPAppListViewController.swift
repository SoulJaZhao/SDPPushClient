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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置Nav
        self.initNav()
        // 设置子视图
        self.initSubviews()
    }
    
    //MARK:设置Nav
    func initNav() {
        self.title = "应用列表"
    }
    
    //MARK:设置子视图
    func initSubviews() {
        tableView = UITableView(frame: self.view.bounds, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: cellId)
        self.view.addSubview(tableView)
    }
    
    //MARK:UITableViewDataSource, UITableViewDelegate
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: cellId) else {
            return UITableViewCell()
        }
        cell.textLabel?.text = "haha"
        return cell
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
