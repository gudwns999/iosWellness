//
//  ChatCell.swift
//  wellness
//
//  Created by Kim's_PC on 2016. 6. 9..
//  Copyright © 2016년 kim. All rights reserved.
//


import UIKit

class ChatCell: BaseCell {
    
    @IBOutlet weak var lblChatMessage: UILabel!
    
    @IBOutlet weak var lblMessageDetails: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
