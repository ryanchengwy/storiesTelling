//
//  StoryDetialViewController.swift
//  storiesTelling
//
//  Created by Ryan on 7/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class StoryDetialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    var story:Story?
    var storyArray = [Story]()
    
    @IBAction func likeButton(sender: AnyObject) {
    }
    @IBAction func composeButton(sender: AnyObject) {
    }
    @IBAction func bookmarkButton(sender: AnyObject) {
    }
    
    @IBOutlet weak var detailTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Hide the TabBar
        self.tabBarController?.tabBar.hidden = true
        self.detailTableView.rowHeight = UITableViewAutomaticDimension
        self.detailTableView.estimatedRowHeight = 200
        self.detailTableView.delegate = self
        self.detailTableView.dataSource = self
    
        if let story = story {

            if let parents = story.parent {
            
                for parent:Parent in parents {
                    
                    let s = Story(parent: parent)
                    
                    self.storyArray.append(s)
                }
            }
            
            self.storyArray.append(story)
        }
        
        self.detailTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return storyArray.count
    }
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title: String?
        switch section {
        case 0 :
            title = "第一部"
        case 1:
            title = "第二部"
        case 2:
            title = "第三部"
        default:
            break
        }
        return title
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = detailTableView.dequeueReusableCellWithIdentifier("detailStoryCell", forIndexPath: indexPath) as! part1TableViewCell

            
        for var i = storyArray.count ; i > 0 ; i-- {
            let pStory = self.storyArray[i - 1]
            if indexPath.section == (i - 1) {
                if i == storyArray.count {
                    if pStory.avatar?.url == "" {
                        let randomPic = Int(arc4random_uniform(7))
                        cell.storyImage.image = UIImage(named: "\(randomPic)")
                    } else {
                        cell.storyImage.yy_setImageWithURL(NSURL(string: pStory.avatar!.url), options: .SetImageWithFadeAnimation)
                    }
                } else {
                    if pStory.avatar?.url == nil {
                        let randomPic = Int(arc4random_uniform(7))
                        cell.storyImage.image = UIImage(named: "\(randomPic)")
                    } else {
                        cell.storyImage.yy_setImageWithURL(NSURL(string: pStory.avatar!.url), options: .SetImageWithFadeAnimation)
                    }
                }
                cell.part1ContentLabel.text = pStory.content
                cell.part1SettingLabel.text = pStory.setting
                cell.part1TitleLabel.text = pStory.topic
            }else{
                print("fk")
            }
            
        }
//        if indexPath.section == 0 {
//        let pStory = self.storyArray[0]
//        
//        cell.part1ContentLabel.text = pStory.content
//        cell.part1SettingLabel.text = pStory.setting
//        cell.part1TitleLabel.text = pStory.topic
//        if pStory.avatar?.url != nil{
//            cell.storyImage.yy_setImageWithURL(NSURL(string: pStory.avatar!.url), options: .SetImageWithFadeAnimation)
//        }else{
//            let randomPic = Int(arc4random_uniform(7))
//            cell.storyImage.image = UIImage(named: "\(randomPic)")
//        }
//        }
//        if indexPath.section == 1 {
//            let pStory = self.storyArray[1]
//            
//            cell.part1ContentLabel.text = pStory.content
//            cell.part1SettingLabel.text = pStory.setting
//            cell.part1TitleLabel.text = pStory.topic
//            if pStory.avatar?.url != nil || pStory.avatar?.url != "" {
//                cell.storyImage.yy_setImageWithURL(NSURL(string: pStory.avatar!.url), options: .SetImageWithFadeAnimation)
//            }else{
//                let randomPic = Int(arc4random_uniform(7))
//                cell.storyImage.image = UIImage(named: "\(randomPic)")
//            }
//        }
//        if indexPath.section == 2 {
//            let pStory = self.storyArray[2]
//            
//            cell.part1ContentLabel.text = pStory.content
//            cell.part1SettingLabel.text = pStory.setting
//            cell.part1TitleLabel.text = pStory.topic
//            if pStory.avatar?.url != nil || pStory.avatar?.url != "" {
//                cell.storyImage.yy_setImageWithURL(NSURL(string: pStory.avatar!.url), options: .SetImageWithFadeAnimation)
//            }else{
//                let randomPic = Int(arc4random_uniform(7))
//                cell.storyImage.image = UIImage(named: "\(randomPic)")
//            }
//        }

        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
