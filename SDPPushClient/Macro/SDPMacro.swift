//
//  SDPMacro.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/14.
//  Copyright © 2017年 soulja. All rights reserved.
//

import Foundation

/* 默认边距padding */
let kSDPPadding:Int = 30

/* HUD延迟隐藏时间 */
let kSDPHUDHideAfterDelay = 2.0

/* 设置TouchID的KEY */
let kSDPTouchIDSupportType = "SDPTouchIDSupportType"

enum SDPTouchIDSupportType:Int {
    /* 不支持TouchID */
    case NoSupported = 0
    /* 支持TouchID */
    case Supported = 1
}
