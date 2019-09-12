//
//  locationTableViewCell.swift
//  BugetBuddy
//
//  Created by Harsh Shah on 4/13/19.
//  Copyright © 2019 Harsh Shah. All rights reserved.
//

import UIKit

class locationTableViewCell: UITableViewCell {

    @IBOutlet weak var locationNameLabel: UILabel!
    
    @IBOutlet weak var amountLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
