//
//  UIDeviceExtension.swift
//  YouBank
//
//  Created by  on 2019/6/22.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit



extension UIDevice {
    public class func isIPhone4() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhone4.size())
    }
    public class func isIPhone5() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhone5.size())
    }
    public class func isIPhone6() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhone6.size())
    }
    public class func isPhone6Plus() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhone6Plus.size())
    }
    public class func isIPhoneX() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhoneX.size())
    }
    public class func isIPhoneXR() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhoneXR.size())
    }
    public class func isIPhoneXS() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhoneXS.size())
    }
    public class func isIPhoneXSMax() -> Bool {
        return UIScreen.main.currentMode!.size.equalTo(CGSize.Device.iPhoneXSMax.size())
    }
}
