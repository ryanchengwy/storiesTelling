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
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var rowNum = 0
        if section == 0 {
            rowNum = initPageItem.count
            
        }
        if section == 1{
            rowNum = 1
        }
        return rowNum
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
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
        if section == 0 {
        itemNum = hotItemArray.count
        }
        
        return itemNum
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let story = self.hotItemArray[indexPath.row]
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionViewCell", forIndexPath: indexPath) as! CollectionViewCell
        let randomPic = Int(arc4random_uniform(7))
        cell.collectionViewCellImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), placeholder: UIImage(named: "\(randomPic)"))
        cell.collectionViewCellText.text = story.topic
        
        return cell

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
