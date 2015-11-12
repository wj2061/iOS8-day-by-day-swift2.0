//
//  ChromaKeyFilter.swift
//  FilterBuilder
//
//  Created by wj on 15/11/8.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ChromaKeyFilter: CIFilter {
    var kernel : CIColorKernel?
    var inputImage : CIImage?
    var activeColor = CIColor(red: 0, green: 1, blue: 0)
    var threshold:Float = 0.7
    
    override init() {
        super.init()
        kernel = createKernel()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        kernel = createKernel()
    }
    
    override var outputImage:CIImage?{
        if let inputImage = inputImage,
            let kernel = kernel{
                let dod = inputImage.extent
                let args = [inputImage as AnyObject, activeColor as AnyObject, threshold as AnyObject]
                return kernel.applyWithExtent(dod, arguments: args)
        }
      return nil
    }
    
    // MARK: - Utility methods
    private func createKernel() -> CIColorKernel? {
        let kernelString =
        "kernel vec4 chromaKey( __sample s, __color c, float threshold ) { \n" +
            "  vec4 diff = s.rgba - c;\n" +
            "  float distance = length( diff );\n" +
            "  float alpha = compare( distance - threshold, 0.0, 1.0 );\n" +
            "  return vec4( s.rgb, alpha ); \n" +
        "}"
        return CIColorKernel(string: kernelString)
    }
}


extension ChromaKeyFilter{
    func importFilterParameters(data: NSData?) {
        if let data = data{
            if let dataDict = NSKeyedUnarchiver.unarchiveObjectWithData(data) as? [String:AnyObject]{
                activeColor = (dataDict["color"] as? CIColor) ?? activeColor
                threshold   = (dataDict["threshold"] as? Float) ?? threshold
            }
        }
    }
    
    func encodeFilterParameters() -> NSData {
        var dataDict = [String:AnyObject]()
        dataDict["activeColor"] = activeColor
        dataDict["threshold"]   = threshold
        return  NSKeyedArchiver.archivedDataWithRootObject(dataDict)
    }
}