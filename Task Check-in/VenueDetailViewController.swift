//
//  VenueDetailViewController.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit

class VenueDetailViewController: UIViewController {

    /* Initialization */
    var venueID: String!
    
    // ------------------------------------------------------------
    // MARK: - States
    
    var venue: Venue?{
        didSet{
            guard let venue = venue else { return }
            showTextFromVenue(venue)
        }
    }
    // ------------------------------------------------------------

    
    let foursquare = Foursquare()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        // request complete detail of venue.
        
        let route = VenueRoute.Get(venueID: venueID)
        
        foursquare
            .responseFromRoute(route, accessToken: UserStore.defaultStore.currentUserToken)
            .onSuccess{ json in
                self.venue = Venue(json: json["response"]["venue"])
            }
            .onFail{ error in
                print("can't get venue detail: \(error)")
            }
    }
    
    
    func showTextFromVenue(venue: Venue){
        
        var textToShow = ""
        textToShow += "ID: \(venue.id)\n\n"
        textToShow += "Name: \(venue.name)\n\n"
        textToShow += "Description: \(venue.description)\n\n"
        textToShow += "Tags: " + venue.tags.joinWithSeparator(", ") + "\n\n"
        textView.text = textToShow
    }
    
    
    
    
    
    
}
