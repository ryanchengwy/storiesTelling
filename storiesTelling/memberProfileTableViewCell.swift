//
//  memberProfileTableViewCell.swift
//  storiesTelling
//
//  Created by Ryan on 27/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Alamofire



class memberProfileTableViewCell: UITableViewCell {

    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var bloodtypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var logoutButton: FBSDKLoginButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        let apiUrl = baseUrl + "api/v1/logout"
        let userDefault = NSUserDefaults.standardUserDefaults()
        let auth_token = userDefault.objectForKey("auth_token")
        let parameter = ["auth_token" : "\(auth_token)"]
        
        Alamofire.request( .POST, apiUrl, parameters: parameter)
        
        
    }


    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
