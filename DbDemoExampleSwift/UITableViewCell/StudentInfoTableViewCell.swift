//
//  StudentInfoTableViewCell.swift
//  Customer Record Summit
//
//  Created by Sanip Shrestha on 6/16/19.
//  Copyright © 2019 Summit. All rights reserved.
//

import UIKit

class StudentInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var studentName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
