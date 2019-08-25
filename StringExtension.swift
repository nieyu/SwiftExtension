//
//  StringExtension.swift
//  YouBank
//
//  Created by  on 2019/6/24.
//  Copyright © 2019 yunie. All rights reserved.
//

import Foundation

extension String {
    
    /// 去掉首尾空格
    ///
    /// - Returns: 去掉后的值
    func trim() -> String {
        return trimmingCharacters(in: CharacterSet.whitespaces)
    }
}

extension String {
    func toCGFloat() -> CGFloat {
        let cgfloat: CGFloat = 0
        if let doubleValue = Double(self) {
            return CGFloat(doubleValue)
        }
        return cgfloat
    }
}

public enum RegularType {
    case Number
    case Phone
    case Password
    case PayPassword
    case Email
    case NickName
    
    var pattern: String {
        switch self {
        case .Number:       return ""
        case .Phone:        return "^1(3[0-9]|5[0-35-9]|8[0-25-9])\\d{8}$"
        case .Password:     return "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$" //6到18位密码
        case .PayPassword:  return "[0-9]{6}"
        case .Email:        return "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        case .NickName:     return "[\u{4e00}-\u{9fa5}]*[a-z]*[A-Z]*\\d*-*_*\\s*"
        }
    }
    var invalidateText: String {
        switch self {
        case .Number:       return "请输入有效数字"
        case .Phone:        return "请输入11位手机号码"
        case .Password:     return "请输入6到18位密码，密码不能以数字开头" //6到18位密码
        case .PayPassword:  return "请输入6位数字"
        case .Email:        return "请输入有效邮箱"
        case .NickName:     return "请输入合法昵称"
        }
    }
}

//验证字符串有效性
extension String {
    public func evaluate(type: RegularType) -> Bool {
        let regex = NSPredicate.init(format: "SELF MATCHES %@", type.pattern)
        return regex.evaluate(with: self)
    }
}

