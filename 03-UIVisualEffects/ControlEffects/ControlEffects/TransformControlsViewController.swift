//
//  TransformControlsViewController.swift
//  ControlEffects
//
//  Created by WJ on 15/10/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

protocol TransformControlsDelegate{
    func transformDidChange(transform:CGAffineTransform,sender:AnyObject?)
}

struct Vect2D {
    var x: Float
    var y: Float
    
    var xCG: CGFloat {
        return CGFloat(x)
    }
    var yCG: CGFloat {
        return CGFloat(y)
    }
}


class TransformControlsViewController: UIViewController {

    @IBOutlet weak var rotationSlider: UISlider!
    @IBOutlet weak var xScaleSlider: UISlider!
    @IBOutlet weak var yScaleSlider: UISlider!
    @IBOutlet weak var xTranslationSlider: UISlider!
    @IBOutlet weak var yTranslationSlider: UISlider!
    
    var transformDelegate : TransformControlsDelegate?
    
    var currentTransform :CGAffineTransform?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyTransformToSliders(currentTransform)

        // Do any additional setup after loading the view.
    }

    @IBAction func handleDismissButtonPressed() {
        dismissViewControllerAnimated(true , completion: nil)
    }
    
    @IBAction func handleSliderValueChanged(sender: UISlider) {
        if transformDelegate != nil{
            let transform = transformFromSliders()
            transformDelegate!.transformDidChange(transform, sender: sender)
        }
        
    }
    
    func applyTransformToSliders(transform:CGAffineTransform?){
        if  transform != nil{
           let decomposition = decomposeAffineTransform(transform!)
            rotationSlider.value = decomposition.rotation
            xScaleSlider.value = decomposition.scale.x
            yScaleSlider.value = decomposition.scale.y
            xTranslationSlider.value = decomposition.translation.x
            yTranslationSlider.value = decomposition.translation.y
        }
    }
    
    func transformFromSliders()->CGAffineTransform{
        let scale = Vect2D(x: xScaleSlider.value, y: yScaleSlider.value)
        let  translation = Vect2D(x: xTranslationSlider.value, y: yTranslationSlider.value)
        
        return constructTransform(rotationSlider.value, scale: scale, translation: translation)
    }
    
    func constructTransform(rotation:Float,scale:Vect2D,translation:Vect2D)->CGAffineTransform{
        let rotnTransform = CGAffineTransformMakeRotation(CGFloat(rotation))
        let scaleTransform = CGAffineTransformScale(rotnTransform, scale.xCG, scale.yCG)
        let translationTransform = CGAffineTransformTranslate(scaleTransform, translation.xCG, translation.yCG)
        return translationTransform
    }

    func decomposeAffineTransform(transform:CGAffineTransform)->(rotation:Float,scale:Vect2D,translation:Vect2D){
        let  translation = Vect2D(x: Float(transform.tx), y: Float(transform.ty))
        
        let scaleX = sqrt( Double(transform.a*transform.a + transform.c + transform.c) )
        let scaleY = sqrt( Double(transform.b*transform.b + transform.d + transform.d) )
        let  scale = Vect2D(x: Float(scaleX), y: Float(scaleY))
        
        let rotation = Float(atan2(Double(transform.b), Double(transform.a)))
        
        return(rotation,scale,translation)
    }


}
