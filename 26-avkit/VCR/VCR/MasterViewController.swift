//
//  MasterViewController.swift
//  VCR
//
//  Created by wj on 15/11/15.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos

class MasterViewController: UITableViewController {
    
    var videos : PHFetchResult!
    let imageManager = PHImageManager.defaultManager()

    

    override func viewDidLoad() {
        super.viewDidLoad()
        videos = PHAsset.fetchAssetsWithMediaType(.Video, options: nil)
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let detailVC = segue.destinationViewController as? DetailViewController{
                    detailVC.videoAsset = videos[indexPath.row] as? PHAsset
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! VideoTableViewCell
        cell.imageManager = imageManager
        cell.videoAsset = videos[indexPath.row] as? PHAsset
        return cell
    }



}

