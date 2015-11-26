//
//  WordList.swift
//  WordTiles
//
//  Created by WJ on 15/11/26.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation

class WordList{
    var words = [String]()
    
    init(filename:String){
        words = importWordsFromFile(filename)
    }
    
    convenience init(){
        self.init(filename:"words")
    }

    func importWordsFromFile(name: String) -> [String] {
        var result = [String]()
        if let path = NSBundle.mainBundle().pathForResource(name, ofType: "txt"){
            let s = try?  String(contentsOfFile: path ,encoding: NSUTF8StringEncoding)
            if let s = s{
                result = s.componentsSeparatedByString("\n")
            }
        }
        return result
    }
}
