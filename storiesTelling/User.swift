//
//  User.swift
//  storiesTelling
//
//  Created by Ryan on 14/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var id:Int
    var display_name: String
    var email: String
    
    init(json:JSON) {
        self.id = json["id"].intValue
        self.display_name = json["display_name"].stringValue
        self.email = json["email"].stringValue
    }
}
