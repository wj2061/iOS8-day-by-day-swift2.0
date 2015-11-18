//
//  ActionViewController.swift
//  Marquee
//
//  Created by WJ on 15/11/18.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tagList = [TagStatus]()



    override func viewDidLoad() {
        super.viewDidLoad()
        
        tagList = createTagList()

    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        for item: AnyObject in self.extensionContext!.inputItems {
            let inputItem = item as! NSExtensionItem
            for provider: AnyObject in inputItem.attachments! {
                let itemProvider = provider as! NSItemProvider
                if itemProvider.hasItemConformingToTypeIdentifier(kUTTypePropertyList as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    itemProvider.loadItemForTypeIdentifier(kUTTypePropertyList as String, options: nil, completionHandler: { (list , error ) -> Void in
                        if let  result = list as? NSDictionary{
                            NSOperationQueue.mainQueue().addOperationWithBlock({ () -> Void in
                                print(result)
                            })
                        }
                    }) 
                }
            }
        }
    }
    
    
    // MARK:- UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tagList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("tagTypeCell", forIndexPath: indexPath)
        let tag = tagList[indexPath.row]
        cell.textLabel?.text = "\(tag)"
        cell.accessoryType = tag.status ? .Checkmark : .None
        return cell
    }
    
    // MARK:- UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let tag = tagList[indexPath.row]
        tag.toggleStatus()
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = tag.status ? .Checkmark : .None
            cell.selected = false
        }
    }
    
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        let error = NSError(domain:  "errorDomain", code: 0, userInfo: nil)
        self.extensionContext!.cancelRequestWithError(error )
    }


    @IBAction func done() {
        let marqueeTagNames = tagList.filter { $0.status } .map{$0.tag}
        
        let extensionItem = NSExtensionItem()
        let jsDict = [ NSExtensionJavaScriptFinalizeArgumentKey : [ "marqueeTagNames" : marqueeTagNames ]]
        extensionItem.attachments = [ NSItemProvider(item: jsDict, typeIdentifier: kUTTypePropertyList as String)]
        
        self.extensionContext!.completeRequestReturningItems([extensionItem], completionHandler: nil)
    }
    
    // MARK:- Utility Methods
    private func createTagList() -> [TagStatus] {
        return [("Heading 1", "h1"),
            ("Heading 2", "h2"),
            ("Heading 3", "h3"),
            ("Heading 4", "h4"),
            ("Paragraph", "p")].map { (name: String, tag: String) in TagStatus(tag: tag,name: name) }
    }

}
