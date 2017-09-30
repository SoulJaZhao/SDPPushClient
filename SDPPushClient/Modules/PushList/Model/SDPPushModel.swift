//
//  SDPPushList.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/30.
//  Copyright © 2017年 soulja. All rights reserved.
//

import Foundation
import HandyJSON

struct SDPPushList : HandyJSON {
    var pushList:[SDPPushRecord]!
}

struct SDPPushRecord : HandyJSON {
    var appname:String!
    var target:String!
    var target_value:String!
    var devicetype:String!
    var pushtype:String!
    var title:String!
    var body:String!
    var badge:String!
    var silent:String!
    var apns:String!
    var pushtime:Int!
}
