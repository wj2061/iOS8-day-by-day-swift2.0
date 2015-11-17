//
//  ViewController.swift
//  EdTxt
//
//  Created by WJ on 15/11/17.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MobileCoreServices


class ViewController: UIViewController , UIDocumentMenuDelegate , UIDocumentPickerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func handleImportMenuPressed(sender: UIButton) {
        let importMenu = UIDocumentMenuViewController(documentTypes: [kUTTypeText as String ], inMode: .Import)
        importMenu.delegate = self
        importMenu.addOptionWithTitle("Create New Document", image: nil, order: .First) { () -> Void in
            print("New Doc Requested")
        }
        presentViewController(importMenu, animated:true , completion: nil )
    }
    
    @IBAction func handleImportPickerPressed(sender: UIButton) {
        let documetPicker = UIDocumentPickerViewController(documentTypes: [kUTTypeText as String ], inMode: .Import)
        documetPicker.delegate = self
        presentViewController(documetPicker, animated: true, completion: nil)
    }
    
    //MARK: - UIDocumentMenuDelegate
    
    func documentMenu(documentMenu: UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        presentViewController(documentPicker, animated: true , completion: nil)
    }
    
    // MARK:- UIDocumentPickerDelegate
    func documentPicker(controller: UIDocumentPickerViewController, didPickDocumentAtURL url: NSURL) {
        // Do something
        print(url)
    }
    

}

