//
//  myProjectTableViewCell.swift
//  FreelanceManager
//
//  Created by Teodik Abrami on 1/16/19.
//  Copyright © 2019 Teodik Abrami. All rights reserved.
//

import UIKit

class myProjectTableViewCell: UITableViewCell {

    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var remainingDaysLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
