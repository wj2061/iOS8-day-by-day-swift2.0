//
//  PhotosCollectionViewController.swift
//  StarGallery
//
//  Created by WJ on 15/11/9.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos


private let reuseIdentifier = "Cell"

class PhotosCollectionViewController: UICollectionViewController ,PHPhotoLibraryChangeObserver{
    
    var images:PHFetchResult!
    let imageManager=PHCachingImageManager()
    var imageCacheController:ImageCacheController!

    override func viewDidLoad() {
        super.viewDidLoad()        
    
        images = PHAsset.fetchAssetsWithMediaType(.Image, options: nil)
        imageCacheController = ImageCacheController(imageManager: imageManager, images: images, preheatSize: 1)
        PHPhotoLibrary.sharedPhotoLibrary().registerChangeObserver(self)
    }
    


    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images?.count ?? 0
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as!PhotosCollectionViewCell
        cell.imageManager = imageManager
        cell.imageAsset = images[indexPath.item] as? PHAsset
        return cell
    }
    
    //MARK: - ScrollViewDelegate
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        let indexpaths = collectionView?.indexPathsForVisibleItems()
        imageCacheController.updateVisibleCells(indexpaths!)
    }


    // MARK: - PHPhotoLibraryChangeObserver
    func photoLibraryDidChange(changeInstance: PHChange) {
        let changeDetails = changeInstance.changeDetailsForFetchResult(images)
        
        self.images = changeDetails!.fetchResultAfterChanges
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
//            self.collectionView?.reloadData()
            let indexpaths = self.collectionView?.indexPathsForVisibleItems()
            for   indexpath in indexpaths!{
                if changeDetails!.changedIndexes!.containsIndex(indexpath.item){
                    let cell = self.collectionView?.cellForItemAtIndexPath(indexpath) as!PhotosCollectionViewCell
                    cell.imageAsset = changeDetails?.fetchResultAfterChanges[indexpath.item] as? PHAsset
                }
            }
        }
    }
}
