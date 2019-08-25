//
//  UIButtonExtension.swift
//  YouBank
//
//  Created by  on 2019/6/18.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

public typealias ControlBlock = (UIControl)->()

public extension UIControl {
    private struct AssociatedKeys {
        static var actionKey = "actionKey"
    }
    private var action: ControlBlock? {
        set {
            objc_setAssociatedObject(self,
                                     &AssociatedKeys.actionKey,
                                     newValue,
                                     objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            if let _action = objc_getAssociatedObject(self, &AssociatedKeys.actionKey) {
                return _action as? ControlBlock
            }
            return nil
        }
    }
    
    /// 为Button按下添加block事件
    ///
    /// - Parameters:
    ///   - action:
    ///   - event: 事件
    func addBlock(action: @escaping ControlBlock, for event: UIControl.Event) {
        self.action = action
        self.addTarget(self, action: #selector(blockMethod), for: event)
    }


    /// 为Button按下添加block事件,默认touchUpInside
    ///
    /// - Parameter action:
    func addBlock(action: @escaping ControlBlock) {
        self.action = action
        self.addTarget(self, action: #selector(blockMethod), for: UIControl.Event.touchUpInside)
    }
    
    @objc private func blockMethod() {
        if let _action = self.action {
            _action(self)
        }
    }
}

