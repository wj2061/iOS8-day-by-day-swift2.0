//
//  MarginConfigView.swift
//  Margina
//
//  Created by wj on 15/11/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

@IBDesignable
class MarginConfigView: UIView {
    @IBInspectable
    var margin:CGFloat = 16 {
        didSet{
            self.layoutMargins = UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
        }
    }


    override init(frame: CGRect) {
        super.init(frame: frame)
        preservesSuperviewLayoutMargins = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        preservesSuperviewLayoutMargins = true
    }
}
