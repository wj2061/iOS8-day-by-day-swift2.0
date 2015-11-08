//
//  ChromaKeyViewController.swift
//  FilterBuilder
//
//  Created by wj on 15/11/8.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit

class ChromaKeyViewController: UIViewController {
    
    private let filter = ChromaKeyFilter()
    @IBOutlet weak var outputImageView: UIImageView!
    @IBOutlet weak var thresholdSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupfilter()
        updateOutputImage()
    }
    
    @IBAction func handleThresholdSliderChanged(sender: UISlider) {
        if abs(filter.threshold - CGFloat(sender.value) ) > 0.05{
            updateOutputImage()
        }
    }

    
    // MARK: - Utility methods

    private func setupfilter(){
        let inputImage = UIImage(named: "chroma_key")
        filter.inputImage = CIImage(image: inputImage!)
        filter.activeColor = CIColor(red: 0, green: 1, blue: 0)
    }
    
    private func filteredImage()->UIImage{
        let outputImage = filter.outputImage
        return UIImage(CIImage: outputImage!)
    }
    
    private func updateOutputImage(){
        filter.threshold = CGFloat(thresholdSlider.value)
        outputImageView.image = filteredImage()
    }
}
