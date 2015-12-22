//
//  Venue.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Venue {
    
    var id: String = ""
    var name: String = ""
    
    init(json: JSON){
        id = json["id"].stringValue
        name = json["name"].stringValue
    }
}