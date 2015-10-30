//
//  EventTableViewCell.swift
//  GitHubToday
//
//  Created by WJ on 15/10/29.
//  Copyright © 2015年 wj. All rights reserved.
//

import UIKit
import GitHubTodayCommon


class EventTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconLabel: UILabel!
    @IBOutlet weak var repoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var event:GitHubEvent?{
        didSet{
            if let event = event{
                iconLabel.text = event.eventType.icon
                repoLabel.text = event.repoName
                dateLabel.text = "\(event.time)"
            }
        }
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(NSEC_PER_SEC)), dispatch_get_main_queue()){ () -> Void in
                self.setSelected(false, animated: true)
            }
        }
    }
}
