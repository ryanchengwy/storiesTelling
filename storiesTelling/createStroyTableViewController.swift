//
//  createStroyTableViewController.swift
//  storiesTelling
//
//  Created by Ryan on 23/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import Alamofire


class createStroyTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
  var cate = ""
    @IBOutlet weak var cateButtonText: UIButton!
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        
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
    @IBAction func cateSelectButtonPressed(sender: AnyObject) {
        
        let alertController = UIAlertController(title: "分類選擇", message: nil, preferredStyle: .ActionSheet)
        let classicButton = UIAlertAction (title: "經典故事", style: .Default) { (action: UIAlertAction) -> Void in
            
            self.cateButtonText.setTitle("經典故事", forState: .Normal)
            self.cate = "經典故事"
        }
        let endingButton = UIAlertAction (title: "結局改編", style: .Default) { (action: UIAlertAction) -> Void in
            
             self.cateButtonText.setTitle("結局改編", forState: .Normal)
            self.cate = "結局改編"
        }
        let newsButton = UIAlertAction (title: "時事創作", style: .Default) { (action: UIAlertAction) -> Void in
            
             self.cateButtonText.setTitle("時事創作", forState: .Normal)
            self.cate = "時事創作"
        }
        alertController.addAction(classicButton)
        alertController.addAction(endingButton)
        alertController.addAction(newsButton)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    @IBOutlet weak var imageViewCover: UIImageView!
    @IBOutlet weak var finishStorySwitch: UISwitch!
    @IBOutlet weak var topicTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var settingTextField: UITextField!
    
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
        self.imageViewCover.image = image as UIImage
        UIImageWriteToSavedPhotosAlbum(self.imageViewCover.image!, nil, nil, nil)
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    func uploadDataToServer() {
        let apiUrl = baseUrl + "api/v1/chapters"
        let imageData = UIImageJPEGRepresentation(self.imageViewCover.image!, 0.8)
        
        let parameter = [
            "topic": "\(topicTextField.text)",
            "setting": "\(settingTextField.text)",
            "content":"\(contentTextView.text)",
            "finish": "\(finishStorySwitch.on)",
            "category": "\(cate)"
        ]
        
        Alamofire.upload(.POST, apiUrl,
            // define your headers here
            headers: ["auth_token": "\(auth_token)"],
            multipartFormData: { multipartFormData in
                
                // import image to request
            
                    multipartFormData.appendBodyPart(data: imageData!, name: "avatar", mimeType: "image/jpg")
                
                
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
                        print("upload\(response)")
                        let alertController = UIAlertController(title: "上傳成功", message: nil, preferredStyle: .Alert)
                        let successButton = UIAlertAction (title: "確定", style: .Default) { (action: UIAlertAction) -> Void in
                            
                        }

                        alertController.addAction(successButton)
                        self.presentViewController(alertController, animated: true, completion: nil)
                        
                    }

                    
                case .Failure(let encodingError):
                    print(encodingError)
                }
        
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        contentTextView.layer.borderColor = UIColor.lightGrayColor().CGColor
        contentTextView.layer.borderWidth = 1
      
       
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

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
