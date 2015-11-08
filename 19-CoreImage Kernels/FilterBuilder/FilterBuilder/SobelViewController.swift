//
//  SobelViewController.swift
//  FilterBuilder
//
//  Created by wj on 15/11/8.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class SobelViewController: UIViewController {
    let filter = SobelFilter()

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFliter()
        updateOutputImage()
    }

    // MARK: - Utility methods
    private func setupFliter(){
        let inputImage = UIImage(named: "flowers")
        filter.inputImage = CIImage(image: inputImage!)
    }

    private func filteredImage()->UIImage{
        let outputImage = filter.outputImage
        return UIImage(CIImage: outputImage!)
    }
    
    private func updateOutputImage(){
        imageView.image = filteredImage()
    }
}
