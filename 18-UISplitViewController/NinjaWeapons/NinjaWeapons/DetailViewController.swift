//
//  DetailViewController.swift
//  NinjaWeapons
//
//  Created by wj on 15/11/7.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {


    var weapon:Weapon?{
        didSet{
            if isViewLoaded(){
                configureView()
            }
        }
    }
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partOfSpeechLabel: UILabel!
    @IBOutlet weak var furtherDetailLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weaponImageView: UIImageView!

    func configureView() {
        if let weapon = self.weapon {
            self.nameLabel.text = weapon.name
            self.partOfSpeechLabel.text = weapon.partOfSpeech
            self.furtherDetailLabel.text = weapon.alternative
            self.descriptionLabel.text = weapon.detail
            self.weaponImageView.image = weapon.image
            self.title = weapon.name
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

