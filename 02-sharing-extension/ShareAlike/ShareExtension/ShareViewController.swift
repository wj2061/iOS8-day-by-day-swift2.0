//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by WJ on 15/10/21.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {
    
    let sc_maxCharactersAllowed = 26
    
    let sc_uploadURL = "http://requestb.in/18vl0xo1"

    
    var attachedImage :UIImage? = nil

    override func isContentValid() -> Bool {
        let currentMessageLength = contentText.characters.count
        charactersRemaining = sc_maxCharactersAllowed - currentMessageLength
        
        if Int(charactersRemaining) < 0{
            return false
        }
        return true
    }
    
    override func presentationAnimationDidFinish() {
        let extensionItem  = extensionContext?.inputItems[0] as! NSExtensionItem
        imageFromExtensionItem(extensionItem){
            image in
            if let image = image {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.attachedImage = image
                })
            }
        }
    }

     override func didSelectPost() {
        print("didselect")
        let configName = "com.shinobicontrols.ShareAlike.BackgroundSessionConfig"
        let sessionConfig = NSURLSessionConfiguration.backgroundSessionConfigurationWithIdentifier(configName)
        sessionConfig.sharedContainerIdentifier = "group.com.cn"
        let session = NSURLSession(configuration: sessionConfig)
        
        let request = urlRequestWithImage(attachedImage, text: contentText)
        
        let task = session.dataTaskWithRequest(request!)
        
        task.resume()
        
        extensionContext?.completeRequestReturningItems([AnyObject](), completionHandler: { (_ ) -> Void in
            print("finish")
        })
    }

    override func configurationItems() -> [AnyObject]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    // MARK:- Utility functions
    
    private func urlRequestWithImage(image: UIImage?, text: String) -> NSURLRequest? {
        let url = NSURL(string: sc_uploadURL)
//        let url = NSURL(fileURLWithPath: sc_uploadURL)
        let request  =  NSMutableURLRequest(URL: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        
        let jsonObject = NSMutableDictionary()
        jsonObject["text"] = text
        if let image = image {
            jsonObject["image_details"] = extractDetailsFromImage(image)
        }
        
        // Create the JSON payload
        var jsonError: NSError?
        let jsonData: NSData?
        do {
            jsonData = try NSJSONSerialization.dataWithJSONObject(jsonObject, options: [])
        } catch let error as NSError {
            jsonError = error
            jsonData = nil
        }
        if (jsonData != nil) {
            request.HTTPBody = jsonData
        } else {
            if let error = jsonError {
                print("JSON Error: \(error.localizedDescription)")
            }
        }
        return request
    }
    
    private func extractDetailsFromImage(image: UIImage) -> NSDictionary {
        var resultDict = [String : AnyObject]()
        resultDict["height"] = image.size.height
        resultDict["width"] = image.size.width
        resultDict["orientation"] = image.imageOrientation.rawValue
        resultDict["scale"] = image.scale
        resultDict["description"] = image.description
        return resultDict
    }
    
    private func imageFromExtensionItem(extensionItem:NSExtensionItem,callback:(image:UIImage?)->Void)
    {
        for  attchment in extensionItem.attachments  as! [NSItemProvider]{
            if attchment.hasItemConformingToTypeIdentifier(kUTTypeImage as String){
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                    attchment.loadItemForTypeIdentifier(kUTTypeImage as String, options: nil, completionHandler: { (imageProvider, error) -> Void in
                        var image : UIImage? = nil
                        if let error = error{
                            print("Item loading error: \(error.localizedDescription)")
                        }
                        image = imageProvider as? UIImage
                        dispatch_async(dispatch_get_main_queue()) {
                            callback(image: image)
                        }
                    })
                })
            }
        }
    }
}
