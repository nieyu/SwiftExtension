//
//  CGSizeExtension.swift
//  YouBank
//
//  Created by  on 2019/6/22.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

extension CGSize {
    public enum Device {
        case iPhone4
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhoneX
        case iPhoneXR
        case iPhoneXS
        case iPhoneXSMax
        
        public func size() -> CGSize {
            switch self {
            case .iPhone4:      return CGSize.init(width:  640, height:  960)
            case .iPhone5:      return CGSize.init(width:  640, height: 1136)
            case .iPhone6:      return CGSize.init(width:  750, height: 1334)
            case .iPhone6Plus:  return CGSize.init(width: 1242, height: 2208)
            case .iPhoneX:      return CGSize.init(width: 1125, height: 2436)
            case .iPhoneXR:     return CGSize.init(width:  828, height: 1792)
            case .iPhoneXS:     return CGSize.init(width: 1125, height: 2436)
            case .iPhoneXSMax:  return CGSize.init(width: 1242, height: 2688)
            }
        }
    }
    
}
