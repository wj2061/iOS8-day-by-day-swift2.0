//
//  WordTileCollectionViewCell.swift
//  WordTiles
//
//  Created by WJ on 15/11/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class WordTileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!

    var word:String = ""{
        didSet{
            wordLabel.text = word
            
        }
    }
    
    
    
    
}
