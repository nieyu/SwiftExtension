//
//  File.swift
//  YouBank
//
//  Created by  on 2019/6/18.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

public extension UIColor {
    
    /// 16进制颜色构造方法
    ///
    /// - Parameter hex: 16进制数
    /// 如 0xFF0000FF 表示红色
    convenience init(hex: UInt32) {
        let r: CGFloat = CGFloat((hex & 0xFF000000) >> 24) / 255.0
        let g: CGFloat = CGFloat((hex & 0x00FF0000) >> 16) / 255.0
        let b: CGFloat = CGFloat((hex & 0x0000FF00) >> 08) / 255.0
        let a: CGFloat = CGFloat( hex & 0x000000FF) / 255.0
        self.init(red: r, green: g, blue: b, alpha: a)
    }
    
    convenience init(_ red255: UInt8, _ green255: UInt8, _ blue255: UInt8, _ alpha1_0: CGFloat = 1.0) {
        self.init(red: CGFloat(red255)/255, green: CGFloat(green255)/255, blue: CGFloat(blue255)/255, alpha: alpha1_0)
    }
    
    /// 工厂方法添加hex颜色
    ///
    /// - Parameter hex: 16进制数
    /// - Returns: UICollor
    class func jhHexString(_ hex: String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substring(from: 1)
        }
        let rString = (cString as NSString).substring(to: 2)
        let gString = ((cString as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bString = ((cString as NSString).substring(from: 4) as NSString).substring(to: 2)
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    convenience init(r : CGFloat, g : CGFloat, b : CGFloat, alpha : CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)),
                       g: CGFloat(arc4random_uniform(256)),
                       b: CGFloat(arc4random_uniform(256)))
    }
}

