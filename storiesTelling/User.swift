//
//  User.swift
//  storiesTelling
//
//  Created by Ryan on 29/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    var username: String
    var picture: String?
    var gender: String
    var birthday: String
    var bloodtype: String
    var interest: String
    var about_me: String
    var voice: String
    var participated: ParticipatedStory?
    
    init (json: JSON) {
        self.username = json["username"].stringValue
        self.picture = json["picture"].stringValue
        self.gender = json["gender"].stringValue
        self.birthday = json["birthday"].stringValue
        self.bloodtype = json["bloodtype"].stringValue
        self.interest = json["insterest"].stringValue
        self.about_me = json["about_me"].stringValue
        self.voice = json["voice"].stringValue
        self.participated = ParticipatedStory(json: json["participated"])
    }
}