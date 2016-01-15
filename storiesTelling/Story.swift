//
//  Story.swift
//  storiesTelling
//
//  Created by Ryan on 14/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Story {
    var id: Int
    var ancestry: [String]
    var topic: String
    var setting: String
    var content: String
    var finish: String
    var user_id: String
    var user: User
    var view: Int

    
   
    init(json:JSON) {
        self.id = json["id"].intValue
        self.ancestry = json["ancestry"].arrayObject as! [String]
        self.topic = json["topic"].stringValue
        self.setting = json["setting"].stringValue
        self.content = json["content"].stringValue
        self.finish = json["finish"].stringValue
        self.user_id = json["user_id"].stringValue
        self.user = User(json: ["user"])
        self.view = json ["view"].intValue
    }
}


