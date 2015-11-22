//
//  MasterViewController.swift
//  CloudNodes
//
//  Created by wj on 15/11/22.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import CloudKit

class MasterViewController: UITableViewController ,NoteEditingDelegate{
    var loadingOverlay:LoadingOverlay!
    
    let noteManager = CloudKitNoteManager(database: CKContainer.defaultContainer().privateCloudDatabase)
    var noteCollection :[Note] = [Note](){
        didSet{
            dispatch_async(dispatch_get_main_queue()) { () -> Void in
                self.tableView.reloadData()
            }
        }
    }

    var detailViewController: DetailViewController? = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
        
        noteManager.getSummaryOfNotes { (notes) -> () in
            self.noteCollection = notes
        }
        
        
        loadingOverlay = LoadingOverlay(frame: view.bounds)
        view.addSubview(loadingOverlay)
        
        let topCons = NSLayoutConstraint(item: loadingOverlay, attribute: .Top, relatedBy: .Equal, toItem: view, attribute: .Top, multiplier: 1.0, constant: 0)
        let leftCons = NSLayoutConstraint(item: loadingOverlay, attribute: .Left, relatedBy: .Equal, toItem: view, attribute: .Left, multiplier: 1.0, constant: 0)
        let bottomCons = NSLayoutConstraint(item: loadingOverlay, attribute: .Bottom, relatedBy: .Equal, toItem: view, attribute: .Bottom, multiplier: 1.0, constant: 0)
        let rightCons = NSLayoutConstraint(item: loadingOverlay, attribute: .Right, relatedBy: .Equal, toItem: view, attribute: .Right, multiplier: 1.0, constant: 0)
        NSLayoutConstraint.activateConstraints([topCons, leftCons, bottomCons, rightCons])
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let note = noteCollection[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.noteManager = noteManager
                controller.noteID = note.id
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        } else if segue.identifier == "addNote" {
            let newNoteVC = segue.destinationViewController as! NoteEditViewController
            newNoteVC.noteEditingDelegate = self
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteCollection.count ?? 0
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let note = noteCollection[indexPath.row]
        cell.textLabel?.text = note.title
        cell.detailTextLabel?.text = "\(note.createdAt)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let note = noteCollection[indexPath.row]
            noteManager.deleteNote(note, callback: { success in
                if success {
                    dispatch_async(dispatch_get_main_queue()) {
                        var newCollection = self.noteCollection
                        newCollection.removeAtIndex(indexPath.row)
                        self.noteCollection = newCollection
                        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
                    }
                }
            })
        }
    }
    
    override func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return .Delete
    }

    // MARK: - NoteEditingDelegate
    func completedEditingNote(note: Note) {
        dismissViewControllerAnimated(true, completion: nil)
        showOverlay(true)
        noteManager.createNote(note) {
            (success, newNote) in
            self.showOverlay(false)
            if let newNote = newNote {
                let newCollection = self.noteCollection + [newNote]
                self.noteCollection = newCollection
            }
        }
    }
    
    // MARK: - Utility methods
    private func showOverlay(show: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            UIView.animateWithDuration(0.5) {
                self.loadingOverlay.alpha = show ? 1.0 : 0.0
            }
        }
    }

}

