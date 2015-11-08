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
    var threshold:CGFloat = 0.7
    
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
