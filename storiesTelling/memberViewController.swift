//
//  memberViewController.swift
//  storiesTelling
//
//  Created by Ryan on 12/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKLoginKit

class memberViewController: UIViewController {

    @IBOutlet weak var memberProfilePic: UIImageView!
    @IBOutlet weak var memberPageFBLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let accessToken = FBSDKAccessToken.currentAccessToken() {


            
        } else {
            let askUserLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookLoginViewController")
            self.navigationController?.presentViewController(askUserLoginViewController!, animated: true, completion: nil)
        }
        
        //Profile Pic

        
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
