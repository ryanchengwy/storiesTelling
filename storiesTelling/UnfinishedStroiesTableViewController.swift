//
//  UnfinishedStroiesTableViewController.swift
//  storiesTelling
//
//  Created by Ryan on 25/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage


class UnfinishedStroiesTableViewController: UITableViewController {

    @IBOutlet var storiesSummaryTable: UITableView!
    let apiUrl = baseUrl + "api/v1/chapters/unfinished"
    var currentPage = 1
    var unfinishedStoryArray = [Story]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
            
        self.refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Refreshing")
        self.storiesSummaryTable.addSubview(self.refreshControl!)
        refreshControl?.addTarget(self, action: "getDataFromServer:", forControlEvents: .ValueChanged)
        
        //Auto height for the cell
        self.storiesSummaryTable.rowHeight = UITableViewAutomaticDimension
        self.storiesSummaryTable.estimatedRowHeight = 50
        
        
        tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        storiesSummaryTable.dataSource = self
        storiesSummaryTable.delegate = self
        
        self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
        
        self.getDataFromServer(self.refreshControl!)
    }
    
    func getDataFromServer(sender: AnyObject) {
        
        let apiPath = apiUrl
        let param = ["page": currentPage]
        
        Alamofire.request(.GET, apiPath, parameters: param).responseJSON { response in switch response.result {
        case .Success(let data):
            
            let result = JSON(data)["continue"]
            
            for(_, subJson):(String, JSON) in result {
                let story = Story(json: subJson)
                
                self.unfinishedStoryArray.append(story)
                self.storiesSummaryTable.reloadData()
                
                
                
                
            }
            self.refreshControl?.endRefreshing()
            
            
        case .Failure(let error):
            print("\(error)")
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 49, right: 0)
        self.tabBarController?.tabBar.hidden = false
        self.getDataFromServer(self.refreshControl!)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: tableView
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.unfinishedStoryArray.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let story = self.unfinishedStoryArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("StorySummaryCell", forIndexPath: indexPath) as! StorySummaryCellTableViewCell
        cell.storyCoverImage.image = nil
        
        
        if story.part == 1{
            cell.labelTitlePart1.text = story.topic
            cell.labelStorySetting.text = story.setting
            cell.labelTitlePart2.text = ""
            cell.labelTitlePart3.text = ""
            
            if story.avatar?.url != ""{
                cell.storyCoverImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), options: .SetImageWithFadeAnimation)
                
            }else{
                let randomPic = Int(arc4random_uniform(7))
                cell.storyCoverImage.image = UIImage(named: "\(randomPic)")
            }
        } else {
            let parentArray = story.parent
            
            if parentArray!.count == 1{
                cell.labelTitlePart1.text = story.parent![0].topic
                cell.labelStorySetting.text = story.parent![0].setting
                cell.labelTitlePart2.text = ""
                cell.labelTitlePart3.text = story.topic
                if story.avatar?.url != ""{
                    cell.storyCoverImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), options: .SetImageWithFadeAnimation)
                    
                }else{
                    let randomPic = Int(arc4random_uniform(7))
                    cell.storyCoverImage.image = UIImage(named: "\(randomPic)")
                }
                
            }
            if parentArray!.count == 2 {
                cell.labelTitlePart1.text = story.parent![0].topic
                cell.labelStorySetting.text = story.parent![0].setting
                cell.labelTitlePart2.text = story.parent![1].topic
                cell.labelTitlePart3.text = story.topic
                if story.avatar?.url != ""{
                    cell.storyCoverImage.yy_setImageWithURL(NSURL(string: (story.avatar?.url)!), options: .SetImageWithFadeAnimation)
                    
                }else{
                    let randomPic = Int(arc4random_uniform(7))
                    cell.storyCoverImage.image = UIImage(named: "\(randomPic)")
                }
                
            }
        }
        
        
        
        
        
        
        return cell
    }
    
    let randomPic = Int(arc4random_uniform(7))
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "unfinishedSummaryToDetial" {
            
            let vc = segue.destinationViewController as! StoryDetialViewController
            vc.story = self.unfinishedStoryArray[(self.storiesSummaryTable.indexPathForSelectedRow?.row)!]
            vc.canCompose = true
            
            
        }
        
        if let indexPath = self.storiesSummaryTable.indexPathForSelectedRow {
            storiesSummaryTable.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }
    
}

