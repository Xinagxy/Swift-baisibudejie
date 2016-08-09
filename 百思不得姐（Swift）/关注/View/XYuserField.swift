//
//  XYuserField.swift
//  百思不得姐（Swift）
//
//  Created by 尧的mac on 16/8/4.
//  Copyright © 2016年 sagacityidea.icom. All rights reserved.
//

import UIKit

class XYuserField: UITextField {

    override func becomeFirstResponder() -> Bool {
//  方法一  let attrs = [NSForegroundColorAttributeName:textColor as! AnyObject]
//         let placeholder = NSAttributedString.init(string: self.placeholder!, attributes: attrs)
//         attributedPlaceholder = placeholder
        setValue(UIColor.redColor(), forKeyPath:"_placeholderLabel.textColor")
        
        return super.becomeFirstResponder()
    }

    override func resignFirstResponder() -> Bool {
       
        setValue(UIColor.darkGrayColor(), forKeyPath:"_placeholderLabel.textColor")
        
        return super.resignFirstResponder()
    }
}
