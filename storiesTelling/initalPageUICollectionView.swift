//
//  initalPageUICollectionView.swift
//  storiesTelling
//
//  Created by Ryan on 21/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage


class initalPageUICollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let apiUrl = "http://139.162.22.162/api/v1/chapters/finished"
    var currentPage = 1
    var hotItemArray = [Story]()
    

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

    func getDataFromServer(sender: AnyObject) {
        
        let apiPath = apiUrl
        let param = ["page": currentPage]
        
        Alamofire.request(.GET, apiPath, parameters: param).responseJSON { response in switch response.result {
        case .Success(let data):
            
            let result = JSON(data)["stories"]
            
            for(_, subJson):(String, JSON) in result {
                let story = Story(json: subJson)
                
                self.hotItemArray.append(story)
                print(self.hotItemArray)
                
                
                
                
                
            }
            
            
        case .Failure(let error):
            print("\(error)")
            }
        }
        
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        

        return hotItemArray.count
        
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let story = self.hotItemArray[indexPath.row]
        
        cell.collectionViewCellImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), options: .SetImageWithFadeAnimation)
        return cell
    }

}
