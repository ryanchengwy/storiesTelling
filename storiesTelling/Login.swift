//
//  Login.swift
//  storiesTelling
//
//  Created by Ryan on 23/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Login {
    var auth_token: String
    var user_id: String
    
    init (json: JSON) {
        self.auth_token = json["auth_token"].stringValue
        self.user_id = json["user_id"].stringValue
        
    }
}