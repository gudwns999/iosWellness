//
//  SNSCell.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 9..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class SNSCell : UITableViewCell{
    
    @IBOutlet var IDLabel: UILabel!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var replyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}