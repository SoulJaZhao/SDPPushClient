//
//  SJStringExtension.swift
//  SDPPushClient
//
//  Created by SDPMobile on 2017/9/14.
//  Copyright © 2017年 soulja. All rights reserved.
//  字符串扩展

import Foundation

extension String {
    //MARK:判断字符串是否为nil或者""
    public static func isBlank(text:String?)->Bool {
        if let str = text {
            if (str == "") {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }
    
    //MARK:去除字符串中的空格
    public static func trimWhiteSpace(text:String)->String {
        //去除左右两边的空格
        var str:String = text.trimmingCharacters(in: CharacterSet.whitespaces)
        //去除中间的空格
        str = str.replacingOccurrences(of: " ", with: "")
        return str
    }
    
    //MARK:判断字符串是否是整数
    public static func isNumberic(text:String)->Bool {
        let scan:Scanner = Scanner(string: text)
        
        var val:Int = 0
        
        return scan.scanInt(&val) && scan.isAtEnd
    }
}
