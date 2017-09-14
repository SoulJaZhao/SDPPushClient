//
//  SDPHttpsClient.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/14.
//  Copyright © 2017年 soulja. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import HandyJSON

/* 网络请求返回结果 */
struct SDPHttpsRespnse: HandyJSON {
    /* 错误码 */
    var errorCode:Int!
    /* 错误信息 */
    var errorMsg:String!
    /* 数据 */
    var data:Any!
}

#if DEBUG
let SDPBaseUrlString:String = "http://10.241.90.241/SDPPushServer/public/api/"
#else
let SDPBaseUrlString:String = "http://10.241.90.241/SDPPushServer/public/api/"
#endif

class SDPHttpsClient: NSObject {
    //MARK:POST方法
    public static func POST(urlString:String,parameteters:[String:Any]?, headers:[String:String]?,success:@escaping (SDPHttpsRespnse)->(), failure:@escaping (SDPHttpsRespnse)->()) {
        //url
        guard let url:URL = URL(string: SDPBaseUrlString.appending(urlString)) else {
            return
        }
        Alamofire.request(url, method: .post, parameters: parameteters, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON { (response) in
            //返回成功数据
            if response.result.isSuccess {
                guard let responseStruct = SDPHttpsRespnse.deserialize(from: response.result.value?.rawString()) else {
                    return
                }
                // 返回成功
                if responseStruct.errorCode == 0 {
                    success(responseStruct)
                } else {
                    failure(responseStruct)
                }
            } else {
                let failureResponse = SDPHttpsRespnse(errorCode: 404, errorMsg: "您的网络不太好哟~", data: nil)
                failure(failureResponse)
            }
        }
    }
}
