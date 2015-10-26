//
//  MTTableViewController.swift
//  MagicTable
//
//  Created by WJ on 15/10/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class MTTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 2
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("RightDetailCell", forIndexPath: indexPath)
            cell.detailTextLabel?.text = "\(indexPath.section),\(indexPath.row)"
            cell.textLabel?.text = "Cell \(indexPath.row)"
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("CustomCell", forIndexPath: indexPath) as!CustomFontCell
            cell.customFontLabel.text = "Cell \(indexPath.row)"
            cell.customFontLabel.font = cell.customFontLabel.font.fontWithSize(CGFloat(indexPath.row)*4.0)
            return cell
        }
    }
}
