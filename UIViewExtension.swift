//
//  UIViewExtension.swift
//  YouBank
//
//  Created by  on 2019/7/3.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

extension UIView {
    
    public var halfHeight: CGFloat {
        return bounds.size.height * 0.5
    }
    
    public func setCorner(_ radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    public func addCorner(_ radius: CGFloat,
                          byRoundingCorners corners: UIRectCorner = [UIRectCorner.allCorners]) {
        layer.mask = nil
        let shapeLayer = CAShapeLayer()
        let _bounds = bounds
        let bezierPath = UIBezierPath(roundedRect: _bounds,
                                      byRoundingCorners: corners,
                                      cornerRadii: CGSize(width: radius, height: radius))
        shapeLayer.path = bezierPath.cgPath
        layer.mask = shapeLayer
    }
}


var indicatoryKey: String = "indicatoryKey"
extension UIView {
    
    public var activityIndicatorView: UIActivityIndicatorView? {
        set {
            objc_setAssociatedObject(self, &indicatoryKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _indicator = objc_getAssociatedObject(self, &indicatoryKey) as? UIActivityIndicatorView {
                return _indicator
            }
            return nil
        }
    }
    
    public func addIndicatorView() {
        activityIndicatorView = UIActivityIndicatorView.init()
        
        addSubview(activityIndicatorView!)
        activityIndicatorView?.snp.makeConstraints({ (maker) in
            maker.center.equalToSuperview()
        })
        activityIndicatorView?.startAnimating()
    }
    
    public func removeIndicatorView() {
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.removeFromSuperview()
    }
}


var kGradientLayer: String = "kGradientLayer"
var kShadowLayer: String = "shadowLayer"
extension UIView {
    
    public var gradientLayer: CAGradientLayer? {
        set {
            objc_setAssociatedObject(self, &kGradientLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _gradientLayer = objc_getAssociatedObject(self, &kGradientLayer) as? CAGradientLayer {
                return _gradientLayer
            }
            return nil
        }
    }
    
    public var shadowLayer: CALayer? {
        set {
            objc_setAssociatedObject(self, &kShadowLayer, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
        get {
            if let _shadowLayer = objc_getAssociatedObject(self, &kShadowLayer) as? CALayer {
                return _shadowLayer
            }
            return nil
        }
    }
    
    // MARK: 添加渐变色图层
    public func gradientColor(_ startPoint: CGPoint, _ endPoint: CGPoint, _ colors: [Any]) {
        guard startPoint.x >= 0, startPoint.x <= 1,
            startPoint.y >= 0, startPoint.y <= 1,
            endPoint.x >= 0, endPoint.x <= 1,
            endPoint.y >= 0, endPoint.y <= 1 else {
            return
        }
        // 外界如果改变了self的大小，需要先刷新
        layoutIfNeeded()
        removeGradientLayer()
        gradientLayer = CAGradientLayer()
        gradientLayer?.frame = self.layer.bounds
        gradientLayer?.startPoint = startPoint
        gradientLayer?.endPoint = endPoint
//        gradientLayer.locations = [0, 1]
        gradientLayer?.colors = colors
        gradientLayer?.cornerRadius = self.layer.cornerRadius
        gradientLayer?.masksToBounds = true
        // 渐变图层插入到最底层，避免在uibutton上遮盖文字图片
        self.layer.insertSublayer(gradientLayer!, at: 0)
        self.backgroundColor = UIColor.blue
        // self如果是UILabel，masksToBounds设为true会导致文字消失
        self.layer.masksToBounds = false
    }
    
    
    
    // MARK: 移除渐变图层
    // （当希望只使用backgroundColor的颜色时，需要先移除之前加过的渐变图层）
    public func removeGradientLayer() {
        gradientLayer?.removeFromSuperlayer()
//        if let sl = self.layer.sublayers {
//            for layer in sl {
//                if layer.isKind(of: CAGradientLayer.self) {
//                    layer.removeFromSuperlayer()
//                }
//            }
//        }
    }
    
    
    /// 设置layerying 阴影
    ///
    /// - Parameters:
    ///   - color: 阴影颜色
    ///   - offset: 阴影偏移量
    ///   - opacity: 阴影透明度
    ///   - radius: 阴影圆角
    
//    UIColor(hex: 0x00000088),
//    CGSize.init(width: -4, height: 8),
//    0.2,
//    10
    
    func setShadow(_ color: UIColor = UIColor(hex: 0x00000071),
                   _ offset: CGSize = CGSize.init(width: 0, height: 4),
                   _ opacity: CGFloat = 0.28,
                   _ radius: CGFloat = 10) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        
        if shadowLayer != nil {
            shadowLayer?.removeFromSuperlayer()
        }
        
        
        shadowLayer = CALayer()
        shadowLayer?.frame = frame
        shadowLayer?.cornerRadius = radius
        shadowLayer?.backgroundColor = color.cgColor
        shadowLayer?.shadowColor = color.cgColor
        shadowLayer?.shadowOffset = offset
        shadowLayer?.shadowRadius = radius
        shadowLayer?.shadowOpacity = 0.28
        superview?.layer.insertSublayer(shadowLayer!, below: layer)
    }
    
    
    func addRoundedOrShadow(radius:CGFloat, shadowOpacity:CGFloat, shadowColor:UIColor)  {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        
        if shadowLayer != nil {
            shadowLayer?.removeFromSuperlayer()
        }
        
        let fixframe = self.frame
//        let newFrame = CGRect(x: fixframe.minX-(375-UIScreen.main.bounds.size.width)/2, y: fixframe.minY, width: fixframe.width, height: fixframe.height) // 修正偏差
        shadowLayer = CALayer()
        shadowLayer?.frame = fixframe
        shadowLayer?.cornerRadius = radius
        shadowLayer?.backgroundColor = UIColor.white.cgColor
        shadowLayer?.masksToBounds = false
        shadowLayer?.shadowColor = shadowColor.cgColor // 阴影颜色
        shadowLayer?.shadowOffset = CGSize(width: 0, height: 0) // 阴影偏移,width:向右偏移3，height:向下偏移2，默认(0, -3),这个跟shadowRadius配合使用
        shadowLayer?.shadowOpacity = Float(shadowOpacity) //阴影透明度
        shadowLayer?.shadowRadius = 5;//阴影半径，默认3
        self.superview?.layer.insertSublayer(shadowLayer!, below: self.layer)
    }
}
