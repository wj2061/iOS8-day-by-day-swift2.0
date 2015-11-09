//
//  PhotosCollectionViewCell.swift
//  StarGallery
//
//  Created by WJ on 15/11/9.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos

class PhotosCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var starButton: UIButton!
    
    var imageManager :PHImageManager?
    
    var imageAsset:PHAsset?{
        didSet{
            self.imageManager?.requestImageForAsset(imageAsset!, targetSize: CGSize(width: 320, height: 320), contentMode: .AspectFill, options: nil, resultHandler: { (image , info ) -> Void in
                self.photoImageView.image = image
            })
            starButton.alpha = imageAsset!.favorite ? 1.0 : 0.4
        }
    }
    
    @IBAction func handleStarButtonPressed(sender: UIButton) {
        PHPhotoLibrary.sharedPhotoLibrary().performChanges({ () -> Void in
            let changeRequest = PHAssetChangeRequest(forAsset: self.imageAsset!)
            changeRequest.favorite = !self.imageAsset!.favorite
            }, completionHandler: nil)
    }
}
