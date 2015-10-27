//
//  File.swift
//  SpeedAverage
//
//  Created by WJ on 15/10/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation

public class NaiveMovingAverageCalculator:MovingAverageCalculator{
    public var windowSize:Int
    
    public init(){
        windowSize = 1
    }
    
    public  func calculateMovingAverage(data:[Double])->[Double]{
        var result = [Double]()
        
        if data.count < windowSize{
            return result
        }
        
        for i in 0...(data.count - windowSize){
            let slice = data[i..<(i+windowSize)]
            let partialSum = slice.reduce(0) { $0 + $1 }
            result.append(Double(partialSum) / Double(windowSize))
        }
        return result
    }
}
