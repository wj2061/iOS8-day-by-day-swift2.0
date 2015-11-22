//
//  LoadingOverlay.swift
//  CloudNodes
//
//  Created by wj on 15/11/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class LoadingOverlay: UIView {
    
    let loadingLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit(){
        loadingLabel.text = "Loading..."
        addSubview(loadingLabel)
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingLabel.textAlignment = .Center
        loadingLabel.font = UIFont(name: "HelveticaNeue-Thin", size: 42)
        let vCons = NSLayoutConstraint(item: loadingLabel, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0)
        let hCons = NSLayoutConstraint(item: loadingLabel, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0)
        NSLayoutConstraint.activateConstraints([vCons,hCons])
        
        backgroundColor = UIColor(white: 0.5, alpha: 0.3)
        
    }

}
