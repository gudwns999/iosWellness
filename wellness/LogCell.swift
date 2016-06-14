//
//  LogCell.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 9..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class LogCell : UITableViewCell{
    
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}