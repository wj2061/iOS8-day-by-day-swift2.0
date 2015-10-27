//
//  MovingAverageCalculator.swift
//  SpeedAverage
//
//  Created by WJ on 15/10/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation

public protocol MovingAverageCalculator{
    var windowSize:Int{ get set}
    
    func calculateMovingAverage(data:[Double])->[Double]
    
}