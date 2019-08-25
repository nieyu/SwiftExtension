//
//  CALayerExtension.swift
//  YouBank
//
//  Created by  on 2019/6/21.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setBorderColorWithUIColor(color: UIColor) {
        self.borderColor = color.cgColor
    }
    
//view.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.28].CGColor;
    
    func setShadowColorWithUIColor(color: UIColor) {
        self.shadowColor = color.cgColor
    }
    
    
    /// 设置layerying 阴影
    ///
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 阴影偏移量
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影圆角
    func setShadow(_ color: UIColor = UIColor.black,
                   _ offset: CGSize = CGSize.init(width: 0, height: 4),
                   _ opacity: CGFloat = 0.92,
                   _ radius: CGFloat = 6.5) {
        self.shadowColor = color.cgColor
        self.shadowOffset = offset
        self.shadowOpacity = Float(opacity)
        self.shadowRadius = radius
    }
    
}
