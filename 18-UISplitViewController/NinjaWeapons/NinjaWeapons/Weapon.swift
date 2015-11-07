//
//  Weapon.swift
//  NinjaWeapons
//
//  Created by wj on 15/11/7.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

struct Weapon{
    let name:String
    let partOfSpeech:String
    let alternative:String
    let detail:String
    let imageName:String
    
    var image:UIImage{
        return UIImage(named: imageName)!
    }
    
    init(dictionary:[String:String]){
        name = dictionary["name"]!
        partOfSpeech = dictionary["partOfSpeech"]!
        alternative = dictionary["alternative"]!
        detail = dictionary["detail"]!
        imageName = dictionary["image"]!
    }
}

class WeaponProvider{
    private(set) var weapons = [Weapon]()
    
    init(plistName:String){
        self.weapons = loadWeaponsFromPListNamed(plistName)
    }
    
    convenience init(){
        self.init(plistName:"WeaponCollection")
    }
    
    private func loadWeaponsFromPListNamed(plistName:String)->[Weapon]{
        let path = NSBundle.mainBundle().pathForResource(plistName, ofType: "plist")
        let rowArray = NSArray(contentsOfFile: path!)
        var weaponCollection = [Weapon]()
        for rawWeapon in rowArray as! [[String:String]]{
            weaponCollection.append(Weapon(dictionary: rawWeapon))
        }
        return weaponCollection
    }
}
