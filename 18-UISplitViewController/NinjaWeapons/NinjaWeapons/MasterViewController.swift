//
//  MasterViewController.swift
//  NinjaWeapons
//
//  Created by wj on 15/11/7.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [AnyObject]()
    
    var weaponProvider:WeaponProvider?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad{
            self.clearsSelectionOnViewWillAppear =  false
            self.preferredContentSize = CGSize(width: 320, height: 600)
        }
        weaponProvider = WeaponProvider()
        self.title = "Weapons"
    }
    


    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                if let weapon = weaponProvider?.weapons[indexPath.row]{
                    let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                    controller.weapon = weapon
                    controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                    controller.navigationItem.leftItemsSupplementBackButton = true
                }
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weaponProvider?.weapons.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)

       let weapon = weaponProvider?.weapons[indexPath.row]
       cell.textLabel?.text = weapon?.name
        return cell
    }





}

