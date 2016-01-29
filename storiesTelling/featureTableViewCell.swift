//
//  featureTableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 26/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class featureTableViewCell: UITableViewCell {
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var featureCell: featureCollectionViewCell!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
 

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        flowLayout.itemSize = CGSize(width: UIScreen.mainScreen().bounds.width, height: 230)
        pageControl.currentPageIndicatorTintColor = UIColor.yellowColor()
        pageControl.pageIndicatorTintColor = UIColor.whiteColor()
   
    }

    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
