//
//  LocaltionTableViewController+LocationManagerDelegate.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit
import CoreLocation
import FutureKit

extension LocaltionTableViewController: CLLocationManagerDelegate{
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    
        guard !requestingNewVenue else { return }
        
        guard let location = locations.first else { return }
        
        let latitude = "\(location.coordinate.latitude)"
        let longitude = "\(location.coordinate.longitude)"

        let route = VenueRoute.Search(latitude: latitude, longitude: longitude, radius: discoverRadius)
        
        requestingNewVenue = true /* lock new request */
        
        fousquare
            .responseFromRoute(route, accessToken: UserStore.defaultStore.currentUserToken)
            .onComplete{ result in
                switch result {
                case let .Success(json):
                    
                    // This json contains the list of compacted version of venues.
                    
                    let newVenues = json["response"]["venues"].map{ index, venueJSON in
                        return Venue(json: venueJSON)
                    }
                    
                    self.venues = newVenues
                    
                case let .Fail(error):
                    print(error)
                default:
                    break
                }
                
                self.requestingNewVenue = false /* allow new request */
            }
    }
    
}



