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
    var part: Int
    var id: String
    var topic: String
    var setting: String
    var content: String
    var parent: [Parent]?
    var avatar: Avatar?
    
    init(json:JSON) {
        self.part = json["part"].intValue
        self.id = json["id"].stringValue
        self.topic = json["topic"].stringValue
        self.setting = json["setting"].stringValue
        self.content = json["content"].stringValue
        self.parent = []
        let array = json["parent"].array
        if let array = array {
            for dic in array {
                self.parent!.append( Parent(json: dic))
            }
        }
        self.avatar = Avatar(json: json["avatar"])
        
    }
    
    init(parent:Parent) {
    
        self.part = parent.part
        self.id = parent.id
        self.topic = parent.topic
        self.setting = parent.setting
        self.content = parent.content
//         self.avatar = parent.avatar
    }
}


