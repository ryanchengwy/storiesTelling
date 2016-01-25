//
//  facebookLoginViewController.swift
//  storiesTelling
//
//  Created by Ryan on 11/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire
import SwiftyJSON



class facebookLoginViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    
var loginInfo = []
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
    @IBOutlet weak var FBLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.FBLoginButton.readPermissions = ["public_profile", "email"]
        self.FBLoginButton.delegate = self
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
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        if result.token != nil {
            print ("Login Result: \(result.token!.tokenString)")
            
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name,id,picture,gender,birthday,email"])
            let apiUrl = baseUrl + "api/v1/login"
            let parameter = ["access_token" : "\(result.token!.tokenString)"]
            
            Alamofire.request( .POST, apiUrl, parameters: parameter).responseJSON{ response in switch response.result {
                
            case .Success(let data):
                
                let result = JSON(data)["logged_in"]
                

                for(_, subJson):(String, JSON) in result {
                    let login = Login(json: subJson)
                
                
                    auth_token = login.auth_token
                print("auth_token\(auth_token)")
                    selfUserID = login.user_id
                print("userid\(selfUserID)")
                }
                
            case .Failure(let error):
                print("\(error)")
                }
            }

            
            request.startWithCompletionHandler { (connection:FBSDKGraphRequestConnection!, result:AnyObject!, err:NSError!) -> Void in if err == nil { print("fetched user:\(result)")
                self.dismissViewControllerAnimated(true, completion: nil)
                }
            }
        }
        if error != nil {
            print("Login with error: \(error)")
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let apiUrl = baseUrl + "api/v1/logout"
        let parameter = ["auth_token" : "\(auth_token)"]
        
        Alamofire.request( .POST, apiUrl, parameters: parameter)
        
        
    }

}
