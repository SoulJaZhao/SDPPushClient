//
//  SDPTabBarController.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/15.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit

class SDPTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.isTranslucent = false
        
        // 应用
        let appVC:SDPAppListViewController = SDPAppListViewController()
        let appNav:SDPNavigationController = SDPNavigationController(rootViewController: appVC)
        appNav.tabBarItem = UITabBarItem(title: "应用", image: nil, selectedImage: nil)
        
        // 推送记录
        let pushVC:SDPPushListViewController = SDPPushListViewController()
        let pushNav:SDPNavigationController = SDPNavigationController(rootViewController: pushVC)
        pushNav.tabBarItem = UITabBarItem(title: "推送记录", image: nil, selectedImage: nil)
        
        // 设置
        let settingVC:SDPSettingViewController = SDPSettingViewController()
        let settingNav:SDPNavigationController = SDPNavigationController(rootViewController: settingVC)
        settingNav.tabBarItem = UITabBarItem(title: "设置", image: nil, selectedImage: nil)
        
        self.viewControllers = [appNav, pushNav, settingNav]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //判断是否登录
        if SDPAccountManager.defaultManager.account == nil {
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
