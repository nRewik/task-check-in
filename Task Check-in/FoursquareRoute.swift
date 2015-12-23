//
//  FoursquareRoute.swift
//  Task Check-in
//
//  Created by Nutchaphon Rewik on 22/12/2015.
//  Copyright © 2015 Nutchaphon Rewik. All rights reserved.
//

import Foundation
import Alamofire


/// Any Route of Foursquare API should conform to this protocol.
///
/// In the future, we can add more route for any foursquare endpoints easily.
/// For example, UserRoute, EventsRoute.
protocol FoursquareRoute: Route{ }



// MARK: - VenueRoute

/// `/Venue` endpoint
enum VenueRoute: FoursquareRoute{
    
    case Get(venueID: String)
    case Search(latitude: Double, longitude: Double, radius: Double, query: String?)
    
    var method: Alamofire.Method {
        switch self {
        case .Get, .Search:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case let .Get(venueID: venueID):
            return "/venues/\(venueID)"
        case .Search:
            return "/venues/search"
        }
    }
    
    var parameters: [String:AnyObject] {
        
        var params: [String:AnyObject] = [:]
        
        switch self{
        case .Get:
            break
        case let .Search(latitude: latitude, longitude: longitude, radius: radius, query: query):
            params["intent"] = "checkin" // find places around the location that user likely to check-in
            
            params["ll"] = "\(latitude),\(longitude)"
            params["radius"] = "\(radius)"
            
            if let query = query{
                params["query"] = query
            }
        }
        
        return params
    }
    
    
}











