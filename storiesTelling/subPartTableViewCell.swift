//
//  subPartTableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 7/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class subPartTableViewCell: UITableViewCell {

    @IBOutlet weak var subPartAuthorButton: UIButton!
    @IBOutlet weak var subPartContent: UILabel!
    @IBOutlet weak var subPartTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
