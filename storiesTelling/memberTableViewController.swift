//
//  memberTableViewController.swift
//  storiesTelling
//
//  Created by Ryan on 27/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON
import YYWebImage

class memberTableViewController: UITableViewController {
        @IBOutlet var memberTableView: UITableView!
    var userArray = [User]()
    var currentPage = 1
    override func viewDidLoad() {
        super.viewDidLoad()
        self.memberTableView.rowHeight = UITableViewAutomaticDimension
        self.memberTableView.estimatedRowHeight = 50
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
       
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let userDefault = NSUserDefaults.standardUserDefaults()
        let user_id = userDefault.objectForKey("user_id")
        if let _ = FBSDKAccessToken.currentAccessToken() {
            if let _ = user_id {
                getDatafromSever()
            } else {
                let askUserLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookLoginViewController")
                self.navigationController?.presentViewController(askUserLoginViewController!, animated: true, completion: nil)
            }
        } else {
            let askUserLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookLoginViewController")
            self.navigationController?.presentViewController(askUserLoginViewController!, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getDatafromSever () {
        
            
            let url = baseUrl + "api/v1/profiles/"
            let userDefault = NSUserDefaults.standardUserDefaults()
            let user_id = userDefault.objectForKey("user_id")
            let apiUrl = url + "\(user_id!)"
            let param = ["page": currentPage]
            print("apiUrl: \(apiUrl)")
            
        Alamofire.request(.GET, apiUrl, parameters: param).responseJSON { response in switch response.result {
        case .Success(let data):

                let result = JSON(data)["profile"]
                print("result\(result)")
                
                for(_,subJson):(String, JSON) in result {
                    let user = User(json: subJson)
                    self.userArray.append(user)
                    self.memberTableView.reloadData()
                    print("userArray\(self.userArray)")
                }
//                let user = User(json: result)
//                self.userArray.append(user)
//                self.memberTableView.reloadData()
            
            case .Failure (let error):
                print(error)
                }
            }
    }
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var numOfRow = 0
        if section == 0{
            
            if userArray.count > 1 {
                numOfRow = 1
            } else {
                numOfRow = 0
            }
        } else if section == 1{
            numOfRow = 0
        }
        return numOfRow
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let user = userArray[indexPath.row]
            let cell = tableView.dequeueReusableCellWithIdentifier("memberProfileTableViewCell") as! memberProfileTableViewCell
            cell.userNameLabel.text = "使用者名稱： \(user.username)"
            cell.sexLabel.text = "性別： \(user.gender)"
            cell.birthdayLabel.text = "生日： \(user.birthday)"
            cell.bloodtypeLabel.text = "血型： \(user.bloodtype)"
            cell.descriptionLabel.text = "自我介紹： \(user.about_me)"
            cell.profilePic.yy_setImageWithURL(NSURL(string: (user.picture)!), placeholder: UIImage(named: "userProfilePic"))
            return cell
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("StorySummaryCell") as! StorySummaryCellTableViewCell
            return cell
        }
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
