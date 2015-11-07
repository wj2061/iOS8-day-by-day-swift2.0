//
//  TraitOverrideViewController.swift
//  NinjaWeapons
//
//  Created by wj on 15/11/7.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class TraitOverrideViewController: UIViewController ,UISplitViewControllerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        performTraitCollectionOverrideForSize(view.bounds.size)
        configureSplitVC()
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        performTraitCollectionOverrideForSize(size)
    }
    

    private func performTraitCollectionOverrideForSize(size:CGSize){
        var overrideTraitCollection : UITraitCollection? = nil
        if size.width > 320{
            overrideTraitCollection = UITraitCollection(horizontalSizeClass: .Regular)
        }
        for vc in self.childViewControllers{
            setOverrideTraitCollection(overrideTraitCollection, forChildViewController: vc)
        }
    }
    
    private func configureSplitVC(){
       let splitVC = self.childViewControllers[0] as! UISplitViewController
        splitVC.delegate = self
        splitVC.preferredPrimaryColumnWidthFraction = 0.3
        let nav = splitVC.childViewControllers.last as! UINavigationController
        nav.topViewController?.navigationItem.leftBarButtonItem = splitVC.displayModeButtonItem()
    }
    
    // MARK: - Split view delegate
    
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController: UIViewController, ontoPrimaryViewController primaryViewController: UIViewController) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController,
            let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController
            where topAsDetailController.weapon == nil {
                return true
        }
        return false
    }
    



    


}
