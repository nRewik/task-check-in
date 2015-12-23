//
//  LocaltionTableViewController+UISearchResultsUpdating.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 23/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import UIKit


extension LocaltionTableViewController: UISearchResultsUpdating{
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        guard let searchText = searchController.searchBar.text else { return }
        guard let mostRecentLocation = locationManager.location else { return }
        
        let latitude = mostRecentLocation.coordinate.latitude
        let longitude = mostRecentLocation.coordinate.longitude
        
        let route = VenueRoute.Search(latitude: latitude, longitude: longitude, radius: discoverRadius,query: searchText)
        
        fousquare
            .responseFromRoute(route, accessToken: UserStore.defaultStore.currentUserToken)
            .onComplete{ result in
                switch result {
                case let .Success(json):
                    
                    // This json contains the list of compacted version of venues.
                    let newVenues = json["response"]["venues"].map{ index, venueJSON in
                        return Venue(json: venueJSON)
                    }
                    
                    self.searchVenues = newVenues
                    self.tableView.reloadData()
                    
                case let .Fail(error):
                    print(error)
                default:
                    break
                }                
            }

        
    }
    
    
    
}