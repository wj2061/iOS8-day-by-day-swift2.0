//
//  ViewController.swift
//  ControlEffects
//
//  Created by WJ on 15/10/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController,TransformControlsDelegate{

    @IBOutlet weak var imageVIew: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func transformDidChange(transform: CGAffineTransform, sender: AnyObject?) {
        imageVIew.transform = transform
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier  == "showTransformController" {
            if  let  tranform = segue.destinationViewController as? TransformControlsViewController{
                 tranform.transformDelegate = self
                 tranform.currentTransform = imageVIew.transform
            }
        }
    }


}

