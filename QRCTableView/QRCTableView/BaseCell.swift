//
//  BaseCell.swift
//  QRCTableView
//
//  Created by Apple on 6/6/18.
//  Copyright © 2018 Quantox. All rights reserved.
//

import UIKit

class BaseCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func config(_ data: Any) {
        
        if let user = (data as! QRCBaseElementData).data as? User{
            
            self.textLabel?.text = user.name + " " + user.lastName
        }
    }
    
}
