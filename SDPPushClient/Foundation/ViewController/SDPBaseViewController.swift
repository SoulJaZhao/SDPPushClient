//
//  SDPBaseViewController.swift
//  SDPPushClient
//
//  Created by SoulJa on 2017/9/13.
//  Copyright © 2017年 soulja. All rights reserved.
//  基础视图

import UIKit
import ChameleonFramework
import MBProgressHUD

class SDPBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置statusbar
        UIApplication.shared.isStatusBarHidden = false
        // 设置背景色
        self.view.backgroundColor = UIColor.flatWhite
        
    }
    
    //MARK:显示loading
    func showHUD() {
        if let navigation = self.navigationController {
            MBProgressHUD.showAdded(to: navigation.view, animated: true)
        } else {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    //MARK:隐藏loading
    func hideHUD() {
        if let navigation = self.navigationController {
            MBProgressHUD.hide(for: navigation.view, animated: true)
        } else {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    /*
     *  延迟消失的loading
     *  @param  afterDelay  延迟时间
     *  @param  completeHandler  完成之后的block
     */
    func showHUD(afterDelay:TimeInterval,completeHandler:@escaping ()->Void) {
        self.showHUD()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + afterDelay) {
            self.hideHUD()
            completeHandler()
        }
    }
    
    /*
     *  延迟消失的loading
     *  @param  afterDelay  延迟时间
     *  @param  title  标题
     */
    func showHUD(title:String, afterDelay:TimeInterval) {
        var hud = MBProgressHUD()
        
        if let navigation = self.navigationController {
            hud = MBProgressHUD.showAdded(to: navigation.view, animated: true)
        } else {
            hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        }
        hud.mode = .text
        hud.label.text = title
        hud.hide(animated: true, afterDelay: afterDelay)
    }
    
    /*
     *  延迟消失的loading
     *  @param  afterDelay  延迟时间
     *  @param  title  标题
     *  @param  completeHandler 处理完成block
     */
    func showHUD(title:String, afterDelay:TimeInterval, completeHandler:@escaping ()->Void) {
        self.showHUD(title: title, afterDelay: afterDelay)
        completeHandler()
    }
    
    //MARK:发送POST请求
    func postService(urlString:String, parameters:[String: Any]?, headers:[String: String]?, success:@escaping (SDPHttpsRespnse) -> (), failure:@escaping (SDPHttpsRespnse)->()) {
        // 显示HUD
        self.showHUD()
        SDPHttpsClient.POST(urlString: urlString, parameteters: parameters, headers: headers, success: { (successResponse) in
            //隐藏HUD
            self.hideHUD()
            success(successResponse)
        }) { (failureResponse) in
            //隐藏HUD
            self.hideHUD()
            failure(failureResponse)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
