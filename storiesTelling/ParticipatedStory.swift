//
//  ParticipatedStory.swift
//  storiesTelling
//
//  Created by Ryan on 29/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

struct ParticipatedStory {
    var id:String
    var topic: String
    var url:String
    
    init (json: JSON) {
        self.id = json["id"].stringValue
        self.topic = json["topic"].stringValue
        self.url = json["url"].stringValue
    }
}