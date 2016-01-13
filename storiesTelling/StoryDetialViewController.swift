//
//  StoryDetialViewController.swift
//  storiesTelling
//
//  Created by Ryan on 7/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit

class StoryDetialViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
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

        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCellWithIdentifier("", forIndexPath: indexPath)
        
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
