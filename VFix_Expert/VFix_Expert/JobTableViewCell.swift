//
//  JobTableViewCell.swift
//  VFix_Expert
//
//  Created by Dustyn August on 3/10/16.
//  Copyright © 2016 Dustyn August. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {

    @IBOutlet weak var serviceTypeLabel: UILabel!
    @IBOutlet weak var appointmentTime: UILabel!
    @IBOutlet weak var appointmentDate: UILabel!
    @IBOutlet weak var serviceIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
