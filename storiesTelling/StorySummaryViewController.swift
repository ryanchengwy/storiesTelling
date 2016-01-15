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



class StorySummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var storySummaryTable: UITableView!
    let apiUrl = "http://139.162.22.162/api/v1/chapters"
    var dataArray = [Story]()
    var currentPage = 1
    var finishedStoryArray = [Story]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Auto height for the cell
        self.storySummaryTable.rowHeight = UITableViewAutomaticDimension
        self.storySummaryTable.estimatedRowHeight = 50
        getDataFromServer()
        self.tabBarController?.tabBar.hidden = false
        
        
    }
    
    func getDataFromServer () {
        let apiPath = apiUrl
        let param = ["page": currentPage]
        
        Alamofire.request(.GET, apiPath, parameters: param).responseJSON { response in switch response.result {
            case .Success(let data):
                
                let result = JSON(data)["data"]
            
            for(_, subJson):(String, JSON) in result {
            let story = Story(json: subJson)
            self.dataArray.append(story)
                print("\(data)")
                
            }
     
            self.storySummaryTable.reloadData()
            
            case .Failure(let error):
            print("\(error)")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: tableView
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let story = self.dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCellWithIdentifier("StorySummaryCell", forIndexPath: indexPath) as! StorySummaryCellTableViewCell
        if story.finish == "true"{
        
            cell.labelTitlePart3.text = story.topic
                        
        }
        
        return cell
    }

}
