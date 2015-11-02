//
//  ViewController.swift
//  LiveDection
//
//  Created by WJ on 15/11/2.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var qrDecodeLabel: UILabel!
    @IBOutlet weak var detectorModeSelector: UISegmentedControl!
    
    var videoFilter : CoreImageVideoFilter!
    var detector : CIDetector?

    override func viewDidLoad() {
        super.viewDidLoad()
        videoFilter = CoreImageVideoFilter(superview: view, applyFilterCallback: nil)
        detectorModeSelector.selectedSegmentIndex = 0
        
        handleDetectorSelectionChange()
    }

    @IBAction func handleDetectorSelectionChange() {
        videoFilter.stopFiltering()
        qrDecodeLabel.hidden = true
        switch detectorModeSelector.selectedSegmentIndex{
        case 0:
            detector = prepareRectangleDetector()
            videoFilter.applyFilter = {
                image in
                return self.performRectangleDetection(image)
            }
        case 1:
            qrDecodeLabel.hidden = false
            detector = prepareQRCodeDetector()
            videoFilter.applyFilter = {
                image in
                let found = self.performQRCodeDetection(image)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if found.decode != ""{
                        self.qrDecodeLabel.text = found.decode
                    }
                })
                return found.outImage
            }
        default:
            videoFilter.applyFilter = nil
        }
        videoFilter.startFiltering()
    }

    
    func prepareRectangleDetector()->CIDetector{
        let options : [String: AnyObject] = [CIDetectorAccuracy:CIDetectorAccuracyHigh,CIDetectorAspectRatio:1.0]
        return CIDetector(ofType: CIDetectorTypeRectangle, context: nil, options: options)
    }
    
    func prepareQRCodeDetector()->CIDetector{
        let options : [String: AnyObject] = [CIDetectorAccuracy:CIDetectorAccuracyHigh,CIDetectorAspectRatio:1.0]
        return CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: options)
    }
    
    func performRectangleDetection(image: CIImage) -> CIImage? {
        var resultImage : CIImage?
        if let detector = detector{
            let features = detector.featuresInImage(image)
            for feature in features as! [CIRectangleFeature]{
                resultImage = drawHighlightOverlayForPoints(image, topLeft: feature.topLeft, topRight: feature.topRight,
                    bottomLeft: feature.bottomLeft, bottomRight: feature.bottomRight)
            }
        }
        return resultImage
    }
    
    func performQRCodeDetection(image: CIImage) -> (outImage: CIImage?, decode: String) {
        var resultImage: CIImage?
        var decode = ""
        if let detector = detector {
            let features = detector.featuresInImage(image)
            for feature in features as! [CIQRCodeFeature] {
                resultImage = drawHighlightOverlayForPoints(image, topLeft: feature.topLeft, topRight: feature.topRight,
                    bottomLeft: feature.bottomLeft, bottomRight: feature.bottomRight)
                decode = feature.messageString
            }
        }
        return (resultImage, decode)
    }
    
    
    func drawHighlightOverlayForPoints(image: CIImage, topLeft: CGPoint, topRight: CGPoint,
        bottomLeft: CGPoint, bottomRight: CGPoint) -> CIImage{
            var overlay = CIImage(color: CIColor(red: 1, green: 0, blue: 0, alpha: 1))
            overlay = overlay.imageByCroppingToRect(image.extent)
            overlay = overlay.imageByApplyingFilter("CIPerspectiveTransformWithExtent", withInputParameters: [
                "inputExtent": CIVector(CGRect: image.extent),
                "inputTopLeft": CIVector(CGPoint: topLeft),
                "inputTopRight": CIVector(CGPoint: topRight),
                "inputBottomLeft": CIVector(CGPoint: bottomLeft),
                "inputBottomRight": CIVector(CGPoint: bottomRight)
            ])
            return overlay.imageByCompositingOverImage(image)
    }


}

