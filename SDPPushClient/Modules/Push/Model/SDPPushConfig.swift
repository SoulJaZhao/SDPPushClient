//
//  SDPPushConfig.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/21.
//  Copyright © 2017年 soulja. All rights reserved.
//

import Foundation
import HandyJSON

struct SDPPushConfig : HandyJSON{
    var appId:Int!
    var target:String!
    var targetValue:String!
    var deviceType:String!
    var pushType:String!
    var title:String!
    var body:String!
}
