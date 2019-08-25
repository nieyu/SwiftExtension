//
//  UITextFieldExtension.swift
//  YouBank
//
//  Created by  on 2019/7/5.
//  Copyright © 2019 yunie. All rights reserved.
//

import UIKit

extension UITextField {
       public class func updateString(text: UnsafeMutablePointer<String>,
                                      range: NSRange,
                                      replacementString string: String) {
        if range.length == 1 {
            let endIndex = text.pointee.index(text.pointee.endIndex, offsetBy: -1)
            text.pointee.remove(at: endIndex)
        } else {
            text.pointee.insert(string.first!, at: text.pointee.endIndex)
        }
    }
}
