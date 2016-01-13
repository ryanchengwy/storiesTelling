//
//  StorySummaryCellTableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 6/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class StorySummaryCellTableViewCell: UITableViewCell {

 
    @IBOutlet weak var labelTitlePart3: UILabel!
    @IBOutlet weak var labelTitlePart2: UILabel!
    @IBOutlet weak var labelStorySetting: UILabel!
    @IBOutlet weak var labelTitlePart1: UILabel!
    @IBOutlet weak var storyCoverImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
