//
//  parent.swift
//  storiesTelling
//
//  Created by Ryan on 18/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Parent {
    var part:Int
    var id: String
    var topic: String
    var content: String
    var setting: String
    
    init(json:JSON) {
        self.part = json["part"].intValue
        self.id = json["id"].stringValue
        self.topic = json["topic"].stringValue
        self.content = json["content"].stringValue
        self.setting = json["setting"].stringValue
    }
}
