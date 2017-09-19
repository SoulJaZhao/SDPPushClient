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
    var appname:String!
    var access_key_secret:String!
}
