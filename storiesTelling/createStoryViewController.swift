//
//  createStoryViewController.swift
//  storiesTelling
//
//  Created by Ryan on 12/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKCoreKit

class createStoryViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tabBarController?.tabBar.hidden = false
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func createNewStoryButton(sender: AnyObject) {
        if let _ = FBSDKAccessToken.currentAccessToken() {
            let showCreateNewStory = self.storyboard?.instantiateViewControllerWithIdentifier("writePart1ViewController") as! createStroyTableViewController
            
            showCreateNewStory.delegate = self
            
            
            self.navigationController?.pushViewController(showCreateNewStory, animated: true)
            
        } else {
            let askUserLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookLoginViewController")
            self.navigationController?.presentViewController(askUserLoginViewController!, animated: true, completion: nil)
        }
    
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        
        if segue.identifier == "segueToUnfinishStory" {
            
        }
        
    }

}

extension createStoryViewController : CreateStroyDelegate {

    func storyCreated(result: String) {
        print("result: " + result)
    }
    
}
