//
//  HealthCell.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 9..
//  Copyright © 2016년 kim. All rights reserved.
//

import Foundation
import UIKit

class HealthCell : UITableViewCell{
    
    @IBOutlet var nameText: UILabel!
    @IBOutlet var setText: UILabel!
    @IBOutlet var amountText: UILabel!
    @IBOutlet var weightText: UILabel!
    @IBOutlet var dateText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}