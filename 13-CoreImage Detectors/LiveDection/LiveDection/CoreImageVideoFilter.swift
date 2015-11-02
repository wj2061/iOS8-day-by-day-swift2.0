//
//  CoreImageVideoFilter.swift
//  LiveDection
//
//  Created by WJ on 15/11/2.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import GLKit
import AVFoundation
import CoreMedia
import CoreImage
import OpenGLES
import QuartzCore

class CoreImageVideoFilter: NSObject ,AVCaptureVideoDataOutputSampleBufferDelegate{
    var applyFilter: ((CIImage) -> CIImage?)?
    var videoDisplayView: GLKView!
    var videoDisplayViewBounds: CGRect!
    var renderContext: CIContext!
    var avSession: AVCaptureSession?
    var sessionQueue: dispatch_queue_t!
    var detector: CIDetector?
    
    init(superview: UIView, applyFilterCallback: ((CIImage) -> CIImage?)?){
        applyFilter = applyFilterCallback
        videoDisplayView = GLKView(frame: superview.frame, context: EAGLContext(API: .OpenGLES2))
        videoDisplayView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        videoDisplayView.frame = superview.bounds
        superview.addSubview(videoDisplayView)
        superview.sendSubviewToBack(videoDisplayView)
        
        renderContext = CIContext(EAGLContext: videoDisplayView.context)
        sessionQueue = dispatch_queue_create("AVSessionQueue",DISPATCH_QUEUE_SERIAL)
        
        videoDisplayView.bindDrawable()
        videoDisplayViewBounds = CGRect(x: 0, y: 0, width: videoDisplayView.drawableWidth, height: videoDisplayView.drawableHeight)
    }
    
    deinit{
        stopFiltering()
    }
    
    func startFiltering(){
        if avSession == nil{
            avSession = createAVSession()
        }
        avSession?.startRunning()
    }
    
    func stopFiltering(){
        avSession?.stopRunning()
    }
    
    func createAVSession()->AVCaptureSession{
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var  input : AVCaptureDeviceInput! = nil
        do{
            input =  try AVCaptureDeviceInput(device: device)
        }catch  let error1{
          print("error = \(error1)")
        }
        let session = AVCaptureSession()
        session.sessionPreset = AVCaptureSessionPresetMedium
        
        let videoOutput = AVCaptureVideoDataOutput()
        videoOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey: NSNumber(unsignedInt: kCVPixelFormatType_32BGRA)]
        videoOutput.alwaysDiscardsLateVideoFrames = true
        videoOutput.setSampleBufferDelegate(self, queue: sessionQueue)
        
        session.addInput(input)
        session.addOutput(videoOutput)
        
        return session
    }
    
    //MARK: -AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, fromConnection connection: AVCaptureConnection!) {
        let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
        
        let opaqueBuffer = Unmanaged<CVImageBuffer>.passUnretained(imageBuffer!).toOpaque()
        let pixelBuffer = Unmanaged<CVPixelBuffer>.fromOpaque(opaqueBuffer).takeUnretainedValue()
        
        let sourceImage = CIImage(CVPixelBuffer: pixelBuffer)
        
        let detectionResult = applyFilter?(sourceImage)
        var outputImage = sourceImage
        if detectionResult != nil{
            outputImage = detectionResult!
        }
        
        var drawFrame = outputImage.extent
        let imageAR = drawFrame.width/drawFrame.height
        let viewAR = videoDisplayViewBounds.width/videoDisplayViewBounds.height
        if imageAR > viewAR{
            drawFrame.origin.x += (drawFrame.width - drawFrame.height * viewAR) / 2.0
            drawFrame.size.width = drawFrame.height / viewAR
        } else {
            drawFrame.origin.y += (drawFrame.height - drawFrame.width / viewAR) / 2.0
            drawFrame.size.height = drawFrame.width / viewAR
        }
        
        videoDisplayView.bindDrawable()
        if videoDisplayView.context != EAGLContext.currentContext(){
            EAGLContext.setCurrentContext(videoDisplayView.context)
        }
        
        glClearColor(0.5, 0.5, 0.5, 1.0)
        glClear(0x00004000)
        
        glEnable(0x0BE2)
        glBlendFunc(1, 0x0303)
        
        renderContext.drawImage(outputImage, inRect: videoDisplayViewBounds, fromRect: drawFrame)
        videoDisplayView.display()
    }

}
