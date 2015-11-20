//
//  ViewController.swift
//  TouchyFeely
//
//  Created by WJ on 15/11/20.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var secretInputTextField: UITextField!
    @IBOutlet weak var secretRetrievalLabel: UILabel!
    @IBOutlet weak var commitButton: UIButton!
    @IBOutlet weak var retrieveButton: UIButton!
    
    let secureStore = KeyChainStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secretRetrievalLabel.alpha = 0
    }
    
    @IBAction func commitSecret(sender: UIButton) {
        secretInputTextField.resignFirstResponder()
        let secretToSave = secretInputTextField.text
        secureStore.secret = secretToSave
        secretInputTextField.text = ""
        secretRetrievalLabel.text = "<placeholder>"
    }
    

    @IBAction func retrieveSecret(sender: UIButton) {
        secretInputTextField.resignFirstResponder()
        let secret = secureStore.secret
        secretRetrievalLabel.text = secret
        secretRetrievalLabel.alpha = 1.0
        
        let fadeOutTime = dispatch_time(DISPATCH_TIME_NOW, Int64(Double(NSEC_PER_SEC) * 1.0))
        dispatch_after(fadeOutTime, dispatch_get_main_queue()) { () -> Void in
            UIView.animateWithDuration(1, animations: { () -> Void in
                self.secretRetrievalLabel.alpha = 0
                }, completion: { (_ ) -> Void in
                self.secretRetrievalLabel.text = "<placeholder>"
            })
        }
    }
 


}

