//
//  ViewController.swift
//  ShareAlike
//
//  Created by WJ on 15/10/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var sharingContentImageView: UIImageView!

    @IBAction func handleShareSampleTapped() {
        shareContent(text: "highland cow", image: sharingContentImageView.image)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func shareContent(text text:String?,image:UIImage?){
        var itemToShare = [AnyObject]()
        
        if let text = text{
            itemToShare.append(text)
        }
        if  let  image = image{
            itemToShare.append(image)
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        
        presentViewController(activityViewController, animated: true, completion: nil)
    }
}

