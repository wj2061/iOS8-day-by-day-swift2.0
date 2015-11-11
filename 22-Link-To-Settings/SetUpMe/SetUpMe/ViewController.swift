//
//  ViewController.swift
//  SetUpMe
//
//  Created by WJ on 15/11/11.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var takeMeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "defaultsChanged", name: NSUserDefaultsDidChangeNotification, object: nil)
        configureAppearance()
    }

    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    @IBAction func handleTakeMeButtonPressed(sender: UIButton) {
        UIApplication.sharedApplication().openURL(NSURL(string: UIApplicationOpenSettingsURLString)!)
    }
    
    private func     configureAppearance(){
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let title = userDefaults.stringForKey("AppTitle")
        titleLabel.text = title
        print(title)
    }
    
    func  defaultsChanged(){
        configureAppearance()
    }
}

