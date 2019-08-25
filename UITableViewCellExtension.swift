//
//  UITableViewCellExtension.swift
//  YouBank
//
//  Created by  on 2019/7/2.
//  Copyright © 2019 yunie. All rights reserved.
//

import Foundation

extension UITableViewCell {
    
    public func addCornerRadius(_ cornerRadius: CGFloat, indexPath: IndexPath, dataCount: Int) {
        
        layer.mask = nil
        
        let shapeLayer = CAShapeLayer()
        if dataCount == 1 {//单行
            let bezierPath = UIBezierPath(roundedRect: bounds.insetBy(dx: 0.0, dy: 2.0),
                                          cornerRadius: cornerRadius)
            shapeLayer.path = bezierPath.cgPath
            layer.mask = shapeLayer
        } else {
            
            switch indexPath.row {
            case 0:
                let _bounds = bounds
//                _bounds.origin.y += 1.0  //这样每一组首行顶部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: _bounds,
                                              byRoundingCorners: [.topLeft,.topRight],
                                              cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                layer.mask = shapeLayer
            case dataCount - 1:
                var _bounds = bounds
                _bounds.origin.y += 1.0  //这样每一组底部分割线不显示
                let bezierPath = UIBezierPath(roundedRect: _bounds,
                                              byRoundingCorners: [.bottomRight, .bottomLeft],
                                              cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
                shapeLayer.path = bezierPath.cgPath
                layer.mask = shapeLayer
            default: print("不添加圆角")
            }
            
        }
    }
    
    
}
