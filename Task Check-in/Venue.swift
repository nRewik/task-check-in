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
    
    /// A unique string identifier for this venue.
    var id: String = ""
    
    /// The best known name for this venue.
    var name: String = ""
    
    /// Description of the venue provided by venue owner.
    var description: String = ""
    
    /// An array of string tags applied to this venue.
    var tags: [String] = []
    
    /// A short URL for this venue, e.g. http://4sq.com/Ab123D
    var shortUrl: String = ""
    
    var photoURLString: String?
    
    // This is just for a demonstration.
    // We can add more properties here, for example,
    // var mayor: User = ...
    // var beenHere: Int = ...
    // The list can be found at https://developer.foursquare.com/docs/responses/venue
    
    init(json: JSON){
        id = json["id"].stringValue
        name = json["name"].stringValue
        description = json["description"].stringValue
        tags = json["tags"].map{ key, value in value.stringValue }
        shortUrl = json["shortUrl"].stringValue
        
        if let
            (_,groupJSON) = json["photos"]["groups"].first,
            (_,photoJSON) = groupJSON["items"].first
        {
            
            let prefix = photoJSON["prefix"].stringValue
            let suffix = photoJSON["suffix"].stringValue
            
            photoURLString = prefix + "original" + suffix
        }
        
    }
    
    
    /// A url of venue's photo.
    var photoUrl: NSURL?{
        guard let photoURLString = photoURLString else { return nil }
        return NSURL(string: photoURLString)
    }
    
}



