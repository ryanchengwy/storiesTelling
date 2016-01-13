//
//  part1TableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 7/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class part1TableViewCell: UITableViewCell {

    @IBOutlet weak var part1AuthorButton: UIButton!
    @IBOutlet weak var part1ContentLabel: UILabel!
    @IBOutlet weak var part1SettingLabel: UILabel!
    @IBOutlet weak var part1TitleLabel: UILabel!
    @IBOutlet weak var storyImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
