//
//  UserDefaultsExtension.swift
//  YouBank
//
//  Created by  on 2019/6/20.
//  Copyright © 2019 yunie. All rights reserved.
//

import Foundation

extension UserDefaults{
    struct LoginInfo: UserDefaultsSettable {
        enum DefaultKeys: String {
            case token
            case account
            case username
            case phoneNumber
            case realname
            case isSetPayPwd  //1为已设置交易密码，0为未设置
            case isProduction  
            case isShowGuidance  //1为已经展示，0还没展示
            case userPortraitURL
        }
    }
}

protocol UserDefaultsSettable {
    associatedtype DefaultKeys: RawRepresentable
}

extension UserDefaultsSettable where DefaultKeys.RawValue == String{
    static func setString(value: String?, forKey key: DefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func string(forKey key: DefaultKeys) -> String? {
        return UserDefaults.standard.string(forKey: key.rawValue)
    }
    static func setInt(value: Int?, forKey key: DefaultKeys){
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func int(forKey key: DefaultKeys)->Int?{
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    static func setBool(value: Bool?, forKey key: DefaultKeys) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    static func bool(forKey key: DefaultKeys)-> Bool? {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
}

