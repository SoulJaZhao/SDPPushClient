//
//  File.swift
//  SDPPushClient
//
//  Created by SoulJa on 2017/9/19.
//  Copyright © 2017年 soulja. All rights reserved.
//

import Foundation
import HandyJSON

struct SDPAppList : HandyJSON {
    var appList:[SDPApp]!
}

struct SDPApp : HandyJSON{
    var id:Int!
    var appname:String!
    var access_key_id:String!
    var access_key_secret:String!
    var appkey:String!
    var user_id:Int!
    var createtime:Int!
    var account:String!
}
