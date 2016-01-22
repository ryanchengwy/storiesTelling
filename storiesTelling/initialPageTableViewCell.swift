//
//  initialPageTableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 21/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class initialPageTableViewCell: UITableViewCell {

    
    @IBOutlet weak var collectionView: initalPageUICollectionView!
    @IBOutlet weak var initialPageCellText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
