//
//  photoViewController.swift
//  storiesTelling
//
//  Created by Ryan on 15/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import MobileCoreServices


class photoViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let userUploadFirstPartImagePath: String = ""

    @IBAction func takePhotoButton(sender: AnyObject) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .Camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImmage"] as! UIImage
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        let documentsDirectory = paths.first
        let interval = NSDate.timeIntervalSinceReferenceDate()
        let name = "\(interval).jpg"
        let path = (documentsDirectory as? NSString)?.stringByAppendingPathComponent(name)
        let data = UIImageJPEGRepresentation(image, 0.9)
        data?.writeToFile(path!, atomically: true)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func selectFromAlbum(sender: AnyObject) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
