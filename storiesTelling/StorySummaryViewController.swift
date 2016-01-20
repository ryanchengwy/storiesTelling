//
//  StorySummaryViewController.swift
//  storiesTelling
//
//  Created by Ryan on 6/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import YYWebImage



class StorySummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var storySummaryTable: UITableView!
    let apiUrl = "http://139.162.22.162/api/v1/chapters/finished"
    var currentPage = 1
    var finishedStoryArray = [Story]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Auto height for the cell
        self.storySummaryTable.rowHeight = UITableViewAutomaticDimension
        self.storySummaryTable.estimatedRowHeight = 50
        getDataFromServer()
        self.tabBarController?.tabBar.hidden = false
          tabBarController?.tabBar.tintColor = UIColor.orangeColor()
        storySummaryTable.dataSource = self
        storySummaryTable.delegate = self
        
        
        
    }
    
    func getDataFromServer () {
        
        let apiPath = apiUrl
        let param = ["page": currentPage]
        
        Alamofire.request(.GET, apiPath, parameters: param).responseJSON { response in switch response.result {
            case .Success(let data):
                
            let result = JSON(data)["stories"]
            
            for(_, subJson):(String, JSON) in result {
            let story = Story(json: subJson)
            
            self.finishedStoryArray.append(story)
            
            self.storySummaryTable.reloadData()
                
            
                
            }
     
            
            
            case .Failure(let error):
            print("\(error)")
            }
        }
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = false
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.finishedStoryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let story = self.finishedStoryArray[indexPath.row]
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {


    }
    let randomPic = Int(arc4random_uniform(7))
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "summaryToDetial" {
        
            let vc = segue.destinationViewController as! StoryDetialViewController
            vc.story = self.finishedStoryArray[(self.storySummaryTable.indexPathForSelectedRow?.row)!]
            

        }
        
        if let indexPath = self.storySummaryTable.indexPathForSelectedRow {
            storySummaryTable.deselectRowAtIndexPath(indexPath, animated: true)
        }
    }

}
