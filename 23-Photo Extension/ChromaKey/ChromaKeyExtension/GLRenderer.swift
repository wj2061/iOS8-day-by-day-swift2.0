//
//  GLRenderer.swift
//  ChromaKey
//
//  Created by WJ on 15/11/12.
//  Copyright © 2015年 wj. All rights reserved.
//
import CoreImage
import GLKit

class GLRenderer {
    var glView :GLKView
    var renderContext:CIContext!
    
    init(glView:GLKView){
        self.glView = glView
        self.renderContext = CIContext(EAGLContext: glView.context)
    }
    
    convenience init(frame:CGRect,superView:UIView){
        let  view = GLKView(frame: frame, context: EAGLContext(API: .OpenGLES2))
        view.frame = frame
        superView.addSubview(view)
        self.init(glView:view)
    }
    
    func renderImage(image:CIImage){
        glView.bindDrawable()
        if glView.context != EAGLContext.currentContext(){
            EAGLContext.setCurrentContext(glView.context)
        }
        
        let imageSize = image.extent.size
        var drawFrame = CGRectMake(0, 0, CGFloat(glView.drawableWidth), CGFloat(glView.drawableHeight))
        let imageAR = imageSize.width/imageSize.height
        let viewAR  = drawFrame.width/drawFrame.height
        if imageAR > viewAR{
            drawFrame.origin.y += (drawFrame.height - drawFrame.width / imageAR) / 2.0
            drawFrame.size.height = drawFrame.width / imageAR
        }else{
            drawFrame.origin.x += (drawFrame.width - drawFrame.height * imageAR) / 2.0
            drawFrame.size.width = drawFrame.height * imageAR
        }
        
        glClearColor(0, 0, 0, 1)
        glClear(0x00004000)
        
        glEnable(0x0BE2)
        glBlendFunc(1, 0x0303)
        
        renderContext.drawImage(image , inRect: drawFrame, fromRect: image.extent)
        glView.display()
    }
}
