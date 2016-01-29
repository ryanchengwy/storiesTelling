//
//  writePart2TableViewController.swift
//  storiesTelling
//
//  Created by Ryan on 26/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire


class writePart2TableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var finishSwitch: UISwitch!
    @IBOutlet weak var coverImageView: UIImageView!
    var parent_id = ""
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneButton = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: "doneButtPressed:")
        self.navigationItem.rightBarButtonItem = doneButton
        contentTextView.layer.borderWidth = 1
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        indicator.center.x = view.center.x
        indicator.center.y = view.center.y - 50
        indicator.color = UIColor.orangeColor()
        view.addSubview(indicator)
//        indicator.startAnimating()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        indicator.center = view.center
//        indicator.color = UIColor.orangeColor()
//        view.addSubview(indicator)
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imageLibraryButtonPressed(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.sourceType = .PhotoLibrary
        controller.delegate = self
        self.presentViewController(controller, animated: true, completion: nil)
    }
    @IBAction func cameraButtonPressed(sender: AnyObject) {
        let controller = UIImagePickerController()
        controller.sourceType = .Camera
        controller.delegate = self
        controller.allowsEditing = true
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        //save image in app
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths.first
        let interval = NSDate.timeIntervalSinceReferenceDate()
        let name = ("\(interval).jpg")
        let path = (documentsDirectory as NSString?)?.stringByAppendingPathComponent(name)
        let data = UIImageJPEGRepresentation(image, 0.9)
        data?.writeToFile(path!, atomically: true)
        //save image to phone
        self.coverImageView.image = image as UIImage
        UIImageWriteToSavedPhotosAlbum(self.coverImageView.image!, nil, nil, nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func doneButtPressed(sender: AnyObject) {
        let alertController = UIAlertController(title: "確定送出？", message: "送出後不能修改了喔！", preferredStyle: .Alert)
        let cancelButton = UIAlertAction(title: "取消", style: .Default) { (action: UIAlertAction) -> Void in
            
        }
        let okButton = UIAlertAction(title: "確定", style: .Default) { (action: UIAlertAction) -> Void in
            self.uploadDataToServer()
        }
        alertController.addAction(cancelButton)
        alertController.addAction(okButton)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    func uploadDataToServer () {
        indicator.startAnimating()
        let apiUrl = baseUrl + "api/v1/chapters"
        var imageData:NSData!
        if self.coverImageView.image != nil {
            
            
            imageData  = UIImageJPEGRepresentation(self.coverImageView.image!, 0.2)
            
        }
        
        let userDefault = NSUserDefaults.standardUserDefaults()
        let auth_token = userDefault.objectForKey("auth_token")
        
        
        let parameter = [
            "auth_token": "\(auth_token!)",
            "topic": "\(topicTextField.text!)",
            "content":"\(contentTextView.text!)",
            "finish": "\(finishSwitch.on)",
            "parent_id":"\(parent_id)"
            //"avatar":"\(base64Decoded!)"
        ]
        Alamofire.upload(.POST, apiUrl,
            // define your headers here
            multipartFormData: { multipartFormData in
                
                // import image to request
                
                print("imageData \(imageData)")
                
                
                
                if imageData != nil {
                    
                    multipartFormData.appendBodyPart(data: imageData, name: "avatar", fileName: "photo.jpg", mimeType: "image/jpg")
                    
                }
                
                // import parameters
                for (key, value) in parameter {
                    multipartFormData.appendBodyPart(data: value.dataUsingEncoding(NSUTF8StringEncoding)!, name: key)
                }
            }, // you can customise Threshold if you wish. This is the alamofire's default value
            encodingMemoryThreshold: Manager.MultipartFormDataEncodingMemoryThreshold,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .Success(let upload, _, _):
                    upload.responseJSON { response in
                        print(response.result.value)
                        
                        self.indicator.stopAnimating()
                        let alertController = UIAlertController(title: "上傳成功", message: nil, preferredStyle: .Alert)
                        let successButton = UIAlertAction (title: "確定", style: .Default) { (action: UIAlertAction) -> Void in
                            if self.finishSwitch.on == false{
                                let unfinishedStoryVC = self.storyboard?.instantiateViewControllerWithIdentifier("UnfinishedStroiesList") as! UnfinishedStroiesTableViewController
                                
                                self.navigationController?.pushViewController(unfinishedStoryVC, animated: true)
                                
                                self.removeFromParentViewController()
                            } else {
                            let finishedStoryVC = self.storyboard?.instantiateViewControllerWithIdentifier("storySummaryTable") as! StorySummaryTableViewController
                            
                            self.navigationController?.pushViewController(finishedStoryVC, animated: true)
                            
                            self.removeFromParentViewController()

                            }

                            
                            
                            
                        }
                        
                        alertController.addAction(successButton)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }
                    
                    
                case .Failure(let encodingError):
                    print(encodingError)
                    
                    
                }
        })
        
    }

    // MARK: - Table view data source


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
