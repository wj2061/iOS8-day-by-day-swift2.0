//
//  VideoTableViewCell.swift
//  VCR
//
//  Created by wj on 15/11/15.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos


class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoNameLabel: UILabel!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    var imageManager : PHImageManager?
    
    var videoAsset: PHAsset? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let videoAsset = videoAsset{
            let durationString = NSString(format: "%0.1f", videoAsset.duration)
            self.videoNameLabel.text = "\(durationString)s"
            self.imageManager?.requestImageForAsset(videoAsset, targetSize: CGSize(width: 150, height: 150), contentMode: .AspectFit, options: nil, resultHandler: { (image , info ) -> Void in
                self.thumbnailImageView.image = image
            })
        }
    }
}
