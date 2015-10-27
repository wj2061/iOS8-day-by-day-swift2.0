//
//  BetterMovingAverageCalculator.swift
//  SpeedAverage
//
//  Created by WJ on 15/10/27.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation


public class BetterMovingAverageCalculator: MovingAverageCalculator {
    
    public var windowSize: Int
    
    public init() {
        windowSize = 1
    }
    
    public func calculateMovingAverage(data: [Double]) -> [Double] {
        var result = [Double]()
        
        // Bail out if we don't have enough data
        if(data.count < windowSize) {
            return result
        }
        
        var currentSum = data[0..<windowSize].reduce(0) { $0 + $1 }
        result.append(Double(currentSum) / Double(windowSize))
        for i in 0..<(data.count - windowSize) {
            // Remove the first entry
            currentSum -= data[i]
            // And add the new one
            currentSum += data[i + windowSize]
            // Save it off
            result.append(Double(currentSum) / Double(windowSize))
        }
        return result
    }
    
}