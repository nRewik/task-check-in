//
//  VenueViewModel.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 24/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation

class VenueViewModel{
    
    var name: String
    var photoUrl: NSURL?
    var itemsToShow: [ (title: String, detail: String ) ]
    
    init(venue: Venue){
        
        let titles = ["ID","Name","Description","Tags"]
        let details = [venue.id, venue.name, venue.description, venue.tags.joinWithSeparator(", ")]
        
        itemsToShow = zip(titles, details).map{ (title: $0, detail: $1 ) }
        
        if let venuePhotoUrl = venue.photoUrl{
            photoUrl = NSURL(string: venuePhotoUrl)
        }
        
        name = venue.name
    }
    
}
