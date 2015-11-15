//
//  DetailViewController.swift
//  VCR
//
//  Created by wj on 15/11/15.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import Photos
import AVKit

class DetailViewController: UIViewController {
    let imageManager = PHImageManager.defaultManager()


    var videoAsset: PHAsset?{
        didSet {
            self.configureView()
        }
    }
    
    var player:AVPlayer?{
        didSet{
            if let avpVC = self.childViewControllers.first as? AVPlayerViewController {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    avpVC.player = self.player
                })
            }
        }
    }

    func configureView() {
        if let videoAsset = videoAsset{
            imageManager.requestPlayerItemForVideo(videoAsset, options: nil, resultHandler: { (playerItem , info ) -> Void in
                self.player =  self.createPlayerByPrefixingItem(playerItem!)
            })
        }

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    private func createPlayerByPrefixingItem(playerItem: AVPlayerItem) -> AVPlayer {
        let countDown = AVPlayerItem(URL: NSBundle.mainBundle().URLForResource("countdown_new", withExtension: "mov" )!)
        return AVQueuePlayer(items:[countDown, playerItem])
    }


}

