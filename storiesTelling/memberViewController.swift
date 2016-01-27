//
//  memberViewController.swift
//  storiesTelling
//
//  Created by Ryan on 12/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import YYWebImage
import SwiftyJSON



class memberViewController: UIViewController {

   
    @IBOutlet weak var memberPageFBLoginButton: FBSDKLoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = FBSDKAccessToken.currentAccessToken() {
            
//            let apiUrl = baseUrl + "api/v1/login"
//            let parameter = ["facebook_token" : "\(accessToken.tokenString)"]
//            
//            Alamofire.request( .POST, apiUrl, parameters: parameter).responseJSON{ response in switch response.result {
//            
//            case .Success(let data):
//                
//                let result = JSON(data)
//                
//                for(_, subJson):(String, JSON) in result {
//                    let user = User(json: subJson)
//                    auth_token = user.auth_token
//                }
//            
//            case .Failure(let error):
//                print("\(error)")
//                }
//            }
            
        } else {
            
            let askUserLoginViewController = self.storyboard?.instantiateViewControllerWithIdentifier("facebookLoginViewController")
            self.navigationController?.presentViewController(askUserLoginViewController!, animated: true, completion: nil)
             memberPageFBLoginButton.hidden = true
        }
    }
    

    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        memberPageFBLoginButton.hidden = true
        let apiUrl = baseUrl + "api/v1/logout"
        let userDefault = NSUserDefaults.standardUserDefaults()
        let auth_token = userDefault.objectForKey("auth_token")
        let parameter = ["auth_token" : "\(auth_token)"]
        
        Alamofire.request( .POST, apiUrl, parameters: parameter)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
     if let _ = FBSDKAccessToken.currentAccessToken() {
        memberPageFBLoginButton.hidden = false
     } else {
        
        
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

}
