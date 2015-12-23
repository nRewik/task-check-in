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
    
        guard let location = locations.first else { return }
        
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        let route = VenueRoute.Explore(latitude: latitude, longitude: longitude, radius: discoverRadius, query: nil)
        
        fousquare
            .responseFromRoute(route, accessToken: UserStore.defaultStore.currentUserToken)
            .onComplete{ result in
                switch result {
                case let .Success(json):
                    
                    // This json contains the list of compacted version of venues.
                    
                    let newVenues = json["response"]["groups"][0]["items"].map{ index, itemJSON in
                        return Venue(json: itemJSON["venue"])
                    }
                    
                    self.nearbyVenues = newVenues
                    self.tableView.reloadData()
                    
                case let .Fail(error):
                    print(error)
                default:
                    break
                }
                
            }
    }
    
}



