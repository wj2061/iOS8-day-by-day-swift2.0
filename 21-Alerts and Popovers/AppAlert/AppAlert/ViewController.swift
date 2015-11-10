//
//  ViewController.swift
//  AppAlert
//
//  Created by WJ on 15/11/10.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UIPopoverPresentationControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handlePopoverPressed(sender: UIButton) {
        let popoverVC = storyboard!.instantiateViewControllerWithIdentifier("codePopover")
        popoverVC.modalPresentationStyle = .Popover
        
        if let popoverController = popoverVC.popoverPresentationController{
            popoverController.delegate = self
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
            popoverController.permittedArrowDirections = .Any
        }
        presentViewController(popoverVC, animated: true, completion: nil)
    }

    @IBAction func handleAlertPressed(sender: UIButton) {
        let  alert = UIAlertController(title: "Alert", message: "Using the alert controller", preferredStyle: .Alert)
        
        let dismisHandler = {(action:UIAlertAction) in
            self.dismissViewControllerAnimated(true , completion: nil)
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: dismisHandler))
        alert.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: dismisHandler))
        alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: dismisHandler))
        alert.addTextFieldWithConfigurationHandler { (textfield ) -> Void in
            textfield.placeholder = "Sample text field"
        }
        presentViewController(alert, animated: true , completion: nil)
   
    }
    

    @IBAction func handleActionSheetPressed(sender: UIButton) {
        let  actionSheet = UIAlertController(title: "Alert", message: "Using the alert controller", preferredStyle: .ActionSheet)
        
        if let presentationcontroller = actionSheet.popoverPresentationController{
            presentationcontroller.sourceView = sender
            presentationcontroller.sourceRect = sender.bounds
        }
        
        let dismisHandler:(UIAlertAction)->Void = {(action:UIAlertAction) in
            self.dismissViewControllerAnimated(true , completion: nil)
        }
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: dismisHandler))
        actionSheet.addAction(UIAlertAction(title: "Delete", style: .Destructive, handler: dismisHandler))
        actionSheet.addAction(UIAlertAction(title: "OK", style: .Default, handler: dismisHandler))

        presentViewController(actionSheet, animated: true , completion: nil)
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate

    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        return .FullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }

}

