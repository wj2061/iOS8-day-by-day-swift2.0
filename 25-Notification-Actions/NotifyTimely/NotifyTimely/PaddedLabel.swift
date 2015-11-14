//
//  PaddedLabel.swift
//  NotifyTimely
//
//  Created by wj on 15/11/14.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit


@IBDesignable
class PaddedLabel: UILabel {
    
    @IBInspectable
    var verticalPadding :CGFloat = 20.0
    
    @IBInspectable
    var  horizontalPadding:CGFloat = 20.0
    
    override func intrinsicContentSize()->CGSize{
        var size = super.intrinsicContentSize()
        size.height += verticalPadding
        size.width  += horizontalPadding
        return size
    }


}
