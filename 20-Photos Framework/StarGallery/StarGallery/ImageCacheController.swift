//
//  ImageCacheController.swift
//  StarGallery
//
//  Created by WJ on 15/11/9.
//  Copyright © 2015年 wj. All rights reserved.
//

import Foundation
import Photos

class ImageCacheController{
    private var cachedIndices = NSIndexSet()
    var cachePreheatSize:Int
    var imageCache:PHCachingImageManager
    var images :PHFetchResult
    var targetSize = CGSize(width: 320, height: 320)
    var contentMode = PHImageContentMode.AspectFill
    
    init(imageManager: PHCachingImageManager, images: PHFetchResult, preheatSize: Int = 1) {
        cachePreheatSize = preheatSize
        imageCache = imageManager
        self.images = images
    }
    
    func updateVisibleCells(visibleCells:[NSIndexPath]) {
        let updatedCache = NSMutableIndexSet()
        for path in  visibleCells{
            updatedCache.addIndex(path.item)
        }
        let minCache = max(0, updatedCache.firstIndex - cachePreheatSize)
        let maxCache = min(images.count-1, updatedCache.lastIndex + cachePreheatSize)
        updatedCache.addIndexesInRange(NSMakeRange(minCache, maxCache - minCache + 1))
        
        self.cachedIndices.enumerateIndexesUsingBlock { (index , _ ) -> Void in
            if !updatedCache.containsIndex(index ){
                let asset :PHAsset = self.images[index ] as! PHAsset
                self.imageCache.stopCachingImagesForAssets([asset], targetSize: self.targetSize, contentMode: self.contentMode, options: nil)
                print("Stopping caching image \(index)")
            }
        }
        
        updatedCache.enumerateIndexesUsingBlock { (index , success ) -> Void in
            if !self.cachedIndices.containsIndex(index ){
                let asset :PHAsset = self.images[index ] as! PHAsset
                self.imageCache.startCachingImagesForAssets([asset], targetSize: self.targetSize, contentMode: self.contentMode, options: nil)
                print("Starting caching image \(index)")
            }
        }
        
        cachedIndices = NSIndexSet(indexSet: updatedCache)
    }
}
