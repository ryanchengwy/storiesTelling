//
//  Avatar.swift
//  storiesTelling
//
//  Created by Ryan on 19/1/2016.
//  Copyright © 2016 Ryan. All rights reserved.
//

import Foundation
import SwiftyJSON

class Avatar {
    var url: String
    var thumb: String
    
    init (json: JSON) {
        self.url = json["url"].stringValue
        self.thumb = json["thumb"].stringValue
    }
}