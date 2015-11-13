//
//  PaddedButton.swift
//  BouncyPresent
//
//  Created by WJ on 15/11/13.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

@IBDesignable
class PaddedButton: UIButton {
    
    @IBInspectable
    var verticalPadding : CGFloat = 10.0
    
    @IBInspectable
    var  horizontalPadding :CGFloat = 30.0
    
    override func intrinsicContentSize() -> CGSize {
        var size = super.intrinsicContentSize()
        size.height += verticalPadding
        size.width  += horizontalPadding
        return size
    }
}
