//
//  initialPageTableViewController.swift
//  storiesTelling
//
//  Created by Ryan on 21/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage
let baseUrl = "http://stori.crowdy.space/"

class initialPageTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    
    @IBOutlet var initalTableView: UITableView!
    var initPageItem = ["最熱門故事","最新故事","心情故事"]
    var featureArray = ["https://wooflyd.typeform.com/to/c1ackf","https://www.facebook.com/crowdy.space/?fref=ts","https://www.facebook.com/events/490695534450570/"]
    var currentPage = 1
    var hotItemArray = [Story]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        self.tableView.estimatedRowHeight = 50
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "crowdyLogo"))

        tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        getDataFromServerHotItem("api/v1/chapters/finished")
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        self.tabBarController?.tabBar.hidden = false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView.tag == 100 {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
            var tableCell:UIView! = scrollView.superview
            while tableCell is featureTableViewCell == false  {
                tableCell = tableCell.superview
            }
            
            (tableCell as? featureTableViewCell)?.pageControl.currentPage = page
        }
      
        
    }
    
    func getDataFromServerHotItem(sec: String) {
        
        let apiUrl = baseUrl + sec
        let apiPath = apiUrl
        let param = ["page": currentPage]
        
        Alamofire.request(.GET, apiPath, parameters: param).responseJSON { response in switch response.result {
        case .Success(let data):
            
            let result = JSON(data)["stories"]
            
            for(_, subJson):(String, JSON) in result {
                let story = Story(json: subJson)
                
                self.hotItemArray.append(story)
                self.tableView.reloadData()
            }
        case .Failure(let error):
            print("\(error)")
            }
        }
        
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 3
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowNum = 0
        if section == 0 {
            rowNum = 1
        }
        
        if section == 1 {
            rowNum = initPageItem.count
            
        }
        if section == 2 {
            rowNum = 1
        }
        return rowNum
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCellWithIdentifier("featureTableViewCell", forIndexPath: indexPath) as! featureTableViewCell
            return cell
        }
        
        if indexPath.section == 1 {
        let cell = tableView.dequeueReusableCellWithIdentifier("initialTableViewCell", forIndexPath: indexPath) as! initialPageTableViewCell
        cell.initialPageCellText.text = initPageItem[indexPath.row]
        cell.collectionView.reloadData()
        return cell
           
        }
        else {
        let cell2 = tableView.dequeueReusableCellWithIdentifier("showMeAllCell", forIndexPath: indexPath) as! showAllStoriesTableViewCell
        return cell2
        }
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var itemNum = 0
        if collectionView.tag == 100 {
        itemNum = featureArray.count
        }
        else {
        itemNum = hotItemArray.count
        }
        
        return itemNum
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if collectionView.tag == 100 {
            
            let url = self.featureArray[indexPath.row]
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("featureCollectionViewCell", forIndexPath: indexPath) as! featureCollectionViewCell
            cell.featureImageView.image = UIImage(named: "feature\(indexPath.row)")
            
            return cell
        } else {
        
        let story = self.hotItemArray[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let randomPic = Int(arc4random_uniform(9))
        cell.collectionViewCellImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), placeholder: UIImage(named: "\(randomPic)"))
        cell.collectionViewCellText.text = story.topic
        
        return cell
        }

    }


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(sender)
        var tableCell = sender?.superview
        while tableCell is UITableViewCell == false {
            tableCell = tableCell??.superview
        }
        let targetCell = tableCell as! UITableViewCell
        let tableIndexPath = self.tableView.indexPathForCell(targetCell)
        print(tableIndexPath!.row)
        
        
        if segue.identifier == "firstPageToDetial" {

            let targetCollectionCell = sender as! UICollectionViewCell
            let collectionView = sender?.superview as! UICollectionView
            let collectionIndexPath = collectionView.indexPathForCell(targetCollectionCell)
            print("item: \(collectionIndexPath!.item)")
            let vc = segue.destinationViewController as! StoryDetialViewController
            vc.story = self.hotItemArray[(collectionIndexPath?.item)!]
          
        }
        if segue.identifier == "webViewSegue" {
            let targetCollectionCell = sender as! UICollectionViewCell
            let collectionView = sender?.superview as! UICollectionView
            let collectionIndexPath = collectionView.indexPathForCell(targetCollectionCell)
            let vc = segue.destinationViewController as! WebViewController
            vc.webViewUrl = self.featureArray[(collectionIndexPath?.item)!]
        }

    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
