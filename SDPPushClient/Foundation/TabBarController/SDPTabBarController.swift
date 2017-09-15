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
